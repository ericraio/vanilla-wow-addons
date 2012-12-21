--[[ 

Natur EnemyCastBar

Revision History:
-----------------
.
. Deleted the original History to achive some less scrolling! Sorry Limited ;-)
. This mod was mainly coded by "Limited" - I (Naturfreund) added all codes after Limited's version Carnical Enemy Cast Bar 1.5c
.

=================================
Read Changelog.txt for more info!
=================================
]]--

CECB_status_version_txt = "4.4.0";

menuesizex = 500;
mshrinksizex = 260;
menuesizey = 480;
mshrinksizey = 140;

carniactive = true;
mobname = "Mob";
mob = "Mob";
spell = "Cast Bar";

function CEnemyCastBar_DefaultVars()

		CEnemyCastBar = { };
		CEnemyCastBar.bStatus = true;
		CEnemyCastBar.bPvP = true;
		CEnemyCastBar.bPvE = true;
		CEnemyCastBar.bLocked = true;
		CEnemyCastBar.bTimer = true;
		CEnemyCastBar.bScale = 1;
		CEnemyCastBar.bAlpha = 1;
		CEnemyCastBar.bShowafflict = true;
		CEnemyCastBar.bTargetM = true;
		CEnemyCastBar.bCDown = false;
		CEnemyCastBar.bAfflictuni = false;
		CEnemyCastBar.bNumBars = 15;
		-- new variables for new versions (check onload variables!)
		CEnemyCastBar.bParseC = true;
		CEnemyCastBar.bGains = true;
		CEnemyCastBar.bFlipB = false;
		CEnemyCastBar.bSmallTSize = false;
		CEnemyCastBar.bFlashit = true;
		CEnemyCastBar.bGlobalFrag = true;
		CEnemyCastBar.bCDownShort = false;
		CEnemyCastBar.bCT_RA_chan = CECB_menue_CTRAnoBC;
		CEnemyCastBar.bBCaster = false;
		CEnemyCastBar.bSoloD = false;
		CEnemyCastBar.bSpace = 20;
		CEnemyCastBar.bDRTimer = false;
		CEnemyCastBar.bMageC = false;
		CEnemyCastBar.bMiniMap = 356;
		CEnemyCastBar.bClassDR = false;
		CEnemyCastBar.bShowIcon = true;
		CEnemyCastBar.bSDoTs = false;
		CEnemyCastBar.tDisabledSpells = { };

end

function CEnemyCastBar_RegisterEvents(unregister)

	local eventpacket = {	"CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE", "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF", "CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE",
				"CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF", "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS",
				"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE", "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE",
				"CHAT_MSG_SPELL_PARTY_DAMAGE", "CHAT_MSG_SPELL_PARTY_BUFF", "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE",
				"CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS", "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE", "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS",
				"CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF",
				"CHAT_MSG_SPELL_BREAK_AURA", "CHAT_MSG_SPELL_AURA_GONE_OTHER", "CHAT_MSG_SPELL_AURA_GONE_SELF",
				"CHAT_MSG_MONSTER_YELL", "CHAT_MSG_MONSTER_EMOTE",
				"CHAT_MSG_RAID", "CHAT_MSG_PARTY", "CHAT_MSG_CHANNEL", "CHAT_MSG_CHANNEL_NOTICE",
				"CHAT_MSG_COMBAT_HOSTILE_DEATH", "CHAT_MSG_COMBAT_FRIENDLY_DEATH", "CHAT_MSG_COMBAT_XP_GAIN",
				"PLAYER_REGEN_DISABLED", "CHAT_MSG_SPELL_SELF_DAMAGE", "PLAYER_COMBO_POINTS"};
			--	"CHAT_MSG_SPELL_SELF_BUFF", "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS", "CHAT_MSG_COMBAT_SELF_HITS" -- for testing only

	local i = 1;

	while (eventpacket[i]) do

		if (unregister) then
			this:UnregisterEvent(eventpacket[i]);
		else
			this:RegisterEvent(eventpacket[i]);
		end

		i = i + 1;
	end

	if (CEnemyCastBar.bStatus and CEnemyCastBar.bDebug) then
		i = i - 1;
		if (unregister) then
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Debug, |cffff0000"..i.." GameEvents UNRegistered!");
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Debug, |cff00ff00"..i.." GameEvents Registered!");
		end
	end

	-- unregister ComboPoint detection for all but rogues
	local _, playersclass = UnitClass("player");
	if (playersclass ~= "ROGUE") then
		this:UnregisterEvent("PLAYER_COMBO_POINTS");
	end
end

function CEnemyCastBar_OnLoad()

	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("VARIABLES_LOADED");
	
	SLASH_CARNIVALENEMYCASTBAR1 = "/necb";  
	SlashCmdList["CARNIVALENEMYCASTBAR"] = function(msg)
		CEnemyCastBar_Handler(msg);
	end
	
	for i=1, 20 do
	
		local button = getglobal("Carni_ECB_"..i);
		local fauxbutton = getglobal("FauxTargetBtn"..i);
		button:Hide();
		fauxbutton:Hide();
		
	end

	if ( not CEnemyCastBar ) then
		
			CEnemyCastBar_DefaultVars();
		
		for i=1, 20 do
	
			local frame = getglobal("Carni_ECB_"..i);
			frame:StopMovingOrSizing();
			frame:EnableMouse(0);
			
		end
			
	end

end

function CEnemyCastBar_OnEvent(event) --onevent

	if (event == "PLAYER_COMBO_POINTS") then

		if(CECBownCPsLast and GetComboPoints() < CECBownCPsLast) then

			CECBownCPsHit = CECBownCPsLast;
			CECBownCPsHitTime = GetTime();

			-- check if there was a finishing move right before you lost all CPs (the server might create a difference up to 500ms between those two events!)
			--CECBownCPsHitBuffer = {mob, spell, GetTime(), DRTimer }; -- just to understand what 1,2,3,4 stands for; defined in 'control' function (affliction)^
			if (CECBownCPsHitBuffer and (CECBownCPsHitTime - CECBownCPsHitBuffer[3]) < 1) then

				local CPSpell = CECBownCPsHitBuffer[2];
				castime = CEnemyCastBar_Afflictions[CPSpell].t - (CEnemyCastBar_Afflictions[CPSpell].cpinterval * (5 - CECBownCPsHit));

				local CPDRTimer = CECBownCPsHitBuffer[4];
				if (CPDRTimer == 4 or CPDRTimer == 6) then
					castime = castime / (CPDRTimer - 2);
				end

				CEnemyCastBar_UniqueCheck(CPSpell, castime - (CECBownCPsHitTime - CECBownCPsHitBuffer[3]), CECBownCPsHitBuffer[1], "trueupdate"); --update bar duration
				CECBownCPsHitTime = nil; -- spell already updated no need to wait 3 secs for new afflictions
			end
		end
		CECBownCPsLast = GetComboPoints();
		CECBownCPsHitBuffer = nil;

	elseif (event == "CHAT_MSG_MONSTER_YELL") then
	
		CEnemyCastBar_Yells(arg1, arg2);
		
	elseif (event == "CHAT_MSG_MONSTER_EMOTE") then
	
		CEnemyCastBar_Emotes(arg1, arg2);

	elseif (event == "PLAYER_LEAVING_WORLD" and CEnemyCastBar.bStatus) then

		CEnemyCastBar_RegisterEvents("unregister");

	elseif (event == "PLAYER_ENTERING_WORLD" and CEnemyCastBar.bStatus) then

		CEnemyCastBar_RegisterEvents();
		if ( not necbdisabledyell and CEnemyCastBar.tDisabledSpells and table.getn(CEnemyCastBar.tDisabledSpells) > 0 ) then
			CEnemyCastBar_Handler("disabled");
			necbdisabledyell = true;
		end

	elseif (event == "PLAYER_REGEN_DISABLED") then

		CEnemyCastBar_Player_Enter_Combat();

	elseif (event == "CHAT_MSG_RAID") then

		CEnemyCastBar_Parse_RaidChat(arg1, arg2, "Raid");

	elseif (event == "CHAT_MSG_PARTY") then

		CEnemyCastBar_Parse_RaidChat(arg1, arg2, "Party");

	elseif (event == "CHAT_MSG_CHANNEL") then --channelparser
		--CEnemyCastBar_Gfind(arg1); --!
		if (arg9 == CEnemyCastBar.bCT_RA_chan and type(arg1) == "string") then

			-- converter for 'drunken protection'
			local msg = string.gsub(arg1, "%$", "s");
			msg = string.gsub(msg, "§", "S");

			if ( strsub(msg, strlen(msg)-7) == " ...hic!") then
				msg = strsub(msg, 1, strlen(msg)-8);
			end
			-- converter finished
			
			-- cecb network infos + calls the parse function: CEnemyCastBar_Parse_RaidChat(arg1, arg2, "CT_RA");
			if (CEnemyCastBar_Parse_RaidChat(msg, arg2, "CT_RA")) then

				if ( ParserCollect[100] ) then
					table.remove (ParserCollect, 1);
				end

				local startpos;
				if (string.sub (msg, 1, 11) == ".cecbspell ") then
					startpos = 12;
					if (numspellcast == 99) then
						numspellcast = 0;
						numsender = " (|cffffffffS|cffffaaaa):";
					elseif (wrongclient) then
						numsender = " (|cffccccccC|cffffaaaa):";
					elseif (numspellcast > 0 and arg2 ~= UnitName("player")) then
						numsender = " (|cffffff00"..numspellcast.."|cffffaaaa):";
					else
						numsender = ":";
					end

				elseif (string.sub (msg, 1, 7) == "<CECB> ") then
					startpos = 8;
					numsender = ":";
					
				else
					startpos = 1;
					numsender = ":";
				end

				-- reduce length of line
				local i, cropped = 0, "";
				CECBParserFauxText:SetText("|cffffaaaa"..arg2..numsender.." |cffcccccc"..string.sub (msg, startpos, string.len (msg)));
				while (CECBParserFauxText:GetStringWidth() > 410) do
					i = i + 1;
					CECBParserFauxText:SetText("|cffffaaaa"..arg2..numsender.." |cffcccccc"..string.sub (msg, startpos, string.len (msg) -i));
				end

				if (i ~= 0) then
					cropped = "|cffffaaaa...";
				else
					cropped = "";
				end

				table.insert (ParserCollect, "|cffffaaaa"..arg2..numsender.." |cffcccccc"..string.sub (msg, startpos, string.len (msg) -i)..cropped);

				if (CECBParser) then
					if (parserline == 0) then
						CEnemyCastBar_ParserOnClick();
					else
						CECBCTRAParserFrameBOTTOMArrowFlash:Show();
						CEnemyCastBar_ParserOnClick("up");
					end
				end

			end
		end

	elseif (event == "CHAT_MSG_CHANNEL_NOTICE") then

		if (arg1 == "YOU_LEFT" and arg9 == CEnemyCastBar.bCT_RA_chan) then
			CEnemyCastBar.bCT_RA_chan = CECB_menue_CTRAnoBC;
			if (CECBOptionsFrame:IsVisible()) then
				CECB_ReloadOptionsUI();
			end
		end


	elseif ( event == "VARIABLES_LOADED" ) then

		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Natur EnemyCastBar |cffcccc00("..CECB_status_version_txt..")|cffffff00:|cffffffff AddOn loaded. Use |cff00ff00/necb|cffffffff to configure.");

		if ( not MobTargetName ) then
			MobTargetName = { };
		end

		if ( not VersionDB ) then
			VersionDB = { };
			VersionNames = { };
		end

		if ( not ParserCollect ) then
			ParserCollect = { };
		end

		DisabledSpells = { };

		-- new variables for new versions
		if (CEnemyCastBar.bParseC == nil) then
			CEnemyCastBar.bParseC = true;
		end
		if (CEnemyCastBar.bGains == nil) then
			CEnemyCastBar.bGains = true;
		end
		if (CEnemyCastBar.bFlashit == nil) then
			CEnemyCastBar.bFlashit = true;
		end
		if (CEnemyCastBar.bGlobalFrag == nil) then
			CEnemyCastBar.bGlobalFrag = true;
		end
		if (CEnemyCastBar.bCT_RA_chan == nil) then
			CEnemyCastBar.bCT_RA_chan = CECB_menue_CTRAnoBC;
		end
		if (CEnemyCastBar.bSpace == nil) then
			CEnemyCastBar.bSpace = 20;
		end
		if (CEnemyCastBar.bMiniMap == nil) then
			CEnemyCastBar.bMiniMap = 360;
		end
		if (CEnemyCastBar.bShowIcon == nil) then
			CEnemyCastBar.bShowIcon = true;
		end

		if ( CEnemyCastBar.tDisabledSpells and table.getn(CEnemyCastBar.tDisabledSpells) > 0 ) then
			CEnemyCastBar_LoadDisabledSpells("mute");
		else
			CEnemyCastBar.tDisabledSpells = { };
		end

		CECBOptionsFrame:SetHeight(menuesizey); -- set optionframe size, not needed atm
		CECBOptionsFrame:SetWidth(menuesizex);

		CEnemyCastBar.bLocked = true; -- remove if lock-option is inserted again
		CEnemyCastBar.bDebug = false; -- same here
		CEnemyCastBar_FlipBars();
		CEnemyCastBar_SetTextSize();
		CECBownCPsHit = 5; -- Set Combopoints to max for all classes, RogueClass will fire an event to change this dynamically

		-- setpos of Minimap button
		if (CEnemyCastBar.bMiniMap == 0) then
			CECBMiniMapButton:Hide();
		else
			CECBMiniMapButton:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 52 - (80 * cos(CEnemyCastBar.bMiniMap)), (80 * sin(CEnemyCastBar.bMiniMap)) - 52);
			CECBMiniMapButton:Show();
		end

 		-- variables for the ctra channel parser
		numspellcast = 0; parserline = 0;
		for i=1, 86 do
			table.insert (ParserCollect, "|cffcccccc- |cff666666"..i.."|cffcccccc -");
		end
		table.insert (ParserCollect, " ");
		table.insert (ParserCollect, "|r==================================");
		table.insert (ParserCollect, "|cffffff00Welcome to the NECB CTRA Channel Parser!");
		table.insert (ParserCollect, "This parser displays all NECB commands/broadcasts received by your client.");
		table.insert (ParserCollect, " ");
		table.insert (ParserCollect, "It follows this pattern:");
		table.insert (ParserCollect, "|cffffaaaaBroadcaster: |cffccccccDetected CTRA Message [, ClientLanguage, Latency]|cffffff00");
		table.insert (ParserCollect, "|cffffaaaa(|cffffffffS|cffffaaaa)|cffffff00 = Sender who triggered a castbar for you. |cffffaaaa(|cffccccccC|cffffaaaa)|cffffff00 = Wrong client!");
		table.insert (ParserCollect, "|cffffaaaa(|cffffff00n|cffffaaaa)|cffffff00 = n useless broadcasts of this spell event.|cffffff00");
		table.insert (ParserCollect, " ");
		table.insert (ParserCollect, "100 lines are buffered. Use up/down at topright to scroll the lines.");
		table.insert (ParserCollect, "I tried to make it work like the default chatframe :D");
		table.insert (ParserCollect, "|r==================================");
		table.insert (ParserCollect, " ");
		-- ctra parser finished

		-- set frames to be hidden if addon disabled
		OptionFrameNames = { CECBOptionsFrameCECB_pvp_check, CECBOptionsFrameCECB_cdown_check, CECBOptionsFrameCECB_cdownshort_check,
			CECBOptionsFrameCECB_gains_check, CECBOptionsFrameCECB_pve_check, CECBOptionsFrameCECB_afflict_check,
			CECBOptionsFrameCECB_globalfrag_check, CECBOptionsFrameCECB_magecold_check, CECBOptionsFrameCECB_solod_check,
			CECBOptionsFrameCECB_drtimer_check, CECBOptionsFrameCECB_classdr_check, CECBOptionsFrameCECB_sdots_check,
			CECBOptionsFrameCECB_affuni_check,
			CECBOptionsFrameCECB_timer_check, CECBOptionsFrameCECB_targetM_check, CECBOptionsFrameCECB_parseC_check,
			CECBOptionsFrameCECB_broadcast_check, CECBOptionsFrameBGFrameNet, CECBOptionsFrameCTRAChan,
			CECBOptionsFrameCECB_flipb_check, CECBOptionsFrameCECB_tsize_check, CECBOptionsFrameCECB_flashit_check,
			CECBOptionsFrameCECB_showicon_check,
			CECBOptionsFrameCECB_scale_Slider, CECBOptionsFrameCECB_alpha_Slider, CECBOptionsFrameCECB_numbars_Slider,
			CECBOptionsFrameCECB_space_Slider, CECBOptionsFrameCECB_MiniMap_Slider,
			CECBOptionsFrameBGFrame2, CECBOptionsFrameBGFrame3,
			CECBOptionsFrameMoveBar, CECBOptionsFrameBGFrameFPSBar, CECBOptionsFrameBGFrameFPSBar_check };

	else

		CEnemyCastBar_Gfind(arg1, event);
	
	end
	
end

function CEnemyCastBar_ParserOnClick(msg)

	if (msg) then
		if ((msg == "down" or msg == -1) and parserline < 0) then
			parserline = parserline + 1;
	
		elseif ((msg == "up"  or msg == 1) and parserline > -80) then
			parserline = parserline - 1;
	
		elseif (msg == 0) then
			parserline = 0;
			CECBCTRAParserFrameUPArrow:Enable();
		end

		if (parserline == -80) then
			CECBCTRAParserFrameUPArrow:Disable();
		elseif (parserline == 0) then
			CECBCTRAParserFrameDOWNArrow:Disable();
			CECBCTRAParserFrameBOTTOMArrow:Disable();
			CECBCTRAParserFrameBOTTOMArrowFlash:Hide();
		else
			CECBCTRAParserFrameUPArrow:Enable();
			CECBCTRAParserFrameDOWNArrow:Enable();
			CECBCTRAParserFrameBOTTOMArrow:Enable();
		end
	end

	CECBCTRAParserFrameLineText:SetText(parserline);
	local parserstring = table.concat (ParserCollect, "\n", 81 + parserline, 100 + parserline);
	CECBCTRAParserFrameBGText:SetText(parserstring);
	
end

function CEnemyCastBar_ParserButton_OnUpdate(elapsed)
	if (this:GetButtonState() == "PUSHED") then
		this.clickDelay = this.clickDelay - elapsed;
		if ( this.clickDelay < 0 ) then
			local name = this:GetName();
			if ( name == this:GetParent():GetName().."DOWNArrow" ) then
				CEnemyCastBar_ParserOnClick("down");
			elseif ( name == this:GetParent():GetName().."UPArrow" ) then
				CEnemyCastBar_ParserOnClick("up");
			end
			this.clickDelay = MESSAGE_SCROLLBUTTON_SCROLL_DELAY;
		end
	end
end

function CEnemyCastBar_TargetPlayer(txt)

	if (CEnemyCastBar.bTargetM == true) then

		TargetByName(MobTargetName[tonumber(txt)]);
		--DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Targetting \""..MobTargetName[tonumber(txt)].."\"");

	end
	
end

function CEnemyCastBar_HideBar(num, shiftright) --hide

	local button = getglobal("Carni_ECB_"..num);
	local fauxbutton = getglobal("FauxTargetBtn"..num);

	if (shiftright) then
		local spell = button.spell;
		local disabled = false;

		if (spell ~= "Stun DR" and not string.find(spell, "DR:") ) then

			if (CEnemyCastBar_Raids[spell]) then
				CEnemyCastBar_Raids[spell].disabled = true;
				disabled = true;
			end
	
			if (CEnemyCastBar_Spells[spell]) then
				CEnemyCastBar_Spells[spell].disabled = true;
				disabled = true;
			end
	
			if (CEnemyCastBar_Afflictions[spell]) then
				CEnemyCastBar_Afflictions[spell].disabled = true;
				disabled = true;
			end
		end

		if (disabled) then
			table.insert (DisabledSpells, spell);
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Disabled \"|cffffff00"..spell.."|r\" (|cffffff00"..table.getn (DisabledSpells).."|r total) for this session.");
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|cffffaaaa Spell not found! |rMaybe it was a CD/DR of some spell?");
		end

	end
		
	fauxbutton:Hide();
	button:Hide();
	--DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Deleted \""..button.label.."\"");
	button.spell = nil;
	button.label = nil;
	MobTargetName[num] = "";
	mobname = "";
	
end

function CEnemyCastBar_LockPos() --lockpos
	
	CEnemyCastBar.bLocked = not CEnemyCastBar.bLocked;
	
	if (CEnemyCastBar.bLocked) then
	
		for i=1, 20 do
	
			local frame = getglobal("Carni_ECB_"..i);
			local fauxframe = getglobal("FauxTargetBtn"..i);
			frame:StopMovingOrSizing();
			frame:EnableMouse(0);
			fauxframe:EnableMouse(1);
			
		end

	else
	
		for i=1, 20 do
	
			local frame = getglobal("Carni_ECB_"..i);
			local fauxframe = getglobal("FauxTargetBtn"..i);
			frame:EnableMouse(1);
			fauxframe:EnableMouse(0);
			
		end	

	end
	
end

function CEnemyCastBar_ResetPos() --resetpos

	local frame = getglobal("Carni_ECB_1");
	local fauxframe = getglobal("FauxTargetBtn1");
	frame:Hide();
	fauxframe:Hide();
	frame:ClearAllPoints();
	frame:SetPoint("TOPLEFT", "UIParent", 50, -500);

	CEnemyCastBar_FlipBars();
end

function CEnemyCastBar_FlipBars() --flipbars; sets the SPACE and ICONSIZE, too!

	for i=2, 21 do
	
		local o = i - 1;
		if (i <= 20) then
			local frame = getglobal("Carni_ECB_"..i);
			local fauxframe = getglobal("FauxTargetBtn"..i);
	
			if (CEnemyCastBar.bFlipB) then
				frame:SetPoint("TOPLEFT", "Carni_ECB_"..o, "TOPLEFT", 0, -CEnemyCastBar.bSpace);
			else
				frame:SetPoint("TOPLEFT", "Carni_ECB_"..o, "TOPLEFT", 0, CEnemyCastBar.bSpace);
			end
		end
		local buttonicon = getglobal("Carni_ECB_"..o.."_Icon");
		buttonicon:SetHeight(CEnemyCastBar.bSpace);
		buttonicon:SetWidth(CEnemyCastBar.bSpace);
		buttonicon:SetPoint("LEFT", "Carni_ECB_"..o, "LEFT", -CEnemyCastBar.bSpace + 4, 5);
		
	end

end

function CEnemyCastBar_SetTextSize() --settextsize and ICONSIZE

	for i=1, 20 do
	
		local buttontext = getglobal("Carni_ECB_"..i.."_Text");
		local buttonttext = getglobal("Carni_ECB_"..i.."_CastTimeText");
		
		if (CEnemyCastBar.bSmallTSize) then
			buttontext:SetFontObject(GameFontHighlightSmall);
			buttonttext:SetFontObject(GameFontHighlightSmall);
		else
			buttontext:SetFontObject(GameFontHighlight);
			buttonttext:SetFontObject(GameFontHighlight);
		end
	end
end

function CEnemyCastBar_Boolean(var)

	if (var) then
	
		return "on";
		
	else
	
		return "off";
		
	end

end

function CEnemyCastBar_Handler(msg) --Handler
	if (msg == "help") then

		DEFAULT_CHAT_FRAME:AddMessage(" ")
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Natur EnemyCastBar |cffcccc00("..CECB_status_version_txt..")|cffffff00:|cffff0000 /necb help")
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cff00ff00/necb |cffffffff- Toggles the options window.")
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cff00ff00/necb clear |cffffffff- Removes all castbars from screen")
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cff00ff00/necb gcinfo |cffffffffDisplay memory usage of all addons")
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cff00ff00/necb countsec sss label |cffffffff- Starts a countdown of sss seconds")
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cff00ff00/necb countmin mmm label |cffffffff- Starts a countdown of mmm minutes")
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cff00ff00/necb repeat sss label |cffffffff- Repeated countdown of sss seconds")
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cff00ff00/necb stopcount label |cffffffff- Stops all grey CastBars which inherit 'label'")
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cffffffffYou may also try |cff00ff00.countsec|cffffffff (s. Options -> Raid/PartyChat!)")
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cff00ff00/necb versions |cffffffff- Displays RaidUsers NECB versions.")
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cff00ff00/necb parser |cffffffff- Opens the NECB - CTRA Channel parser.")
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cff00ff00SHIFT + LeftClick |cffffffffdeletes the bar, |cff00ff00ALT + click |cffffffffdeletes all bars")
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cff00ff00SHIFT + RightClick |cffffffffdisables the spell for the rest of your session!")
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cff00ff00/necb disabled |cfffffffflists disabled spells, |cff00ff00/necb restore |cffffffffrestores spells!")
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cff00ff00/necb load |cffffffffloads disabled spells, |cff00ff00/necb save |cffffffffsaves disabled spells!")
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |cff00ff00/necb remove xyz |cffffffff removes xyz from the list of disabled spells!")

	elseif (msg == "" or msg == nil) then

		if (CECBOptionsFrame:IsVisible()) then
			fademenue = 1;
		else
			fademenue = 2;
			CECBOptionsFrame:SetAlpha(0);
			CECB_ShowHideOptionsUI();
		end

	elseif (msg == "gcinfo") then

		if (CECBGCFrame:IsVisible()) then
			CECBGCFrame:Hide();
			cecbgc_last = nil;
		else
			CECBGCFrame:Show();
		end

	elseif (msg == "versions") then

		DEFAULT_CHAT_FRAME:AddMessage(" ")
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Natur EnemyCastBar |cffcccc00("..CECB_status_version_txt..")|cffffff00:|cffff0000 /necb versions")

		local VersionDBTemp = { };

		if (VersionDB and VersionDB[1]) then
			for i=1, table.getn (VersionDB) do
				VersionDB[i] = string.gsub (VersionDB[i], "Natur ", "");
				table.insert (VersionDBTemp, "|cffaaaaaaNECB: |rVersion |cff00ff00"..VersionDB[i].."|r is used by |cffcccc00"..VersionNames[i].."|r.");	
			end

			table.sort (VersionDBTemp);
			local vcounter = 1;
	
			for i=1, table.getn (VersionDBTemp) do
				local o = i + 1;
				if (VersionDBTemp[o]) then
					local _,_,nextversion = string.find (VersionDBTemp[o], "Version (.+) is used")
					local _,_,thisversion = string.find (VersionDBTemp[i], "Version (.+) is used")
	
					if (nextversion and thisversion and nextversion == thisversion) then
						local _,_,nextname = string.find (VersionDBTemp[o], "is used by (.+).")
						table.remove (VersionDBTemp, o);
						VersionDBTemp[i] = string.sub (VersionDBTemp[i], 1, string.len( VersionDBTemp[i] ) - 1 ) .. ", " ..nextname ..".";
						i = i - 1;
						vcounter = vcounter + 1;
					else
						if (vcounter > 1) then
							VersionDBTemp[i] = VersionDBTemp[i] .. " (|cff00ff00" ..vcounter.. "|r Users)";
						end
						vcounter = 1;
					end
	
				else
	
					if (vcounter > 1 and VersionDBTemp[i]) then
						VersionDBTemp[i] = VersionDBTemp[i] .. " (|cff00ff00" ..vcounter.. "|r Users)";
					end
	
				end
	
			end
	
			for i=table.getn (VersionDBTemp), 1, -1 do
				DEFAULT_CHAT_FRAME:AddMessage(VersionDBTemp[i]);
			end

		else
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB: |rIt seems there was |cffff0000no CT_RA Broadcast|r, yet!\n|cffaaaaaaNECB: |rChannelparsing has to be enabled to detect versions.")
		end

	elseif (msg == "parser") then

		if (CECBParser) then
	
			CECBParser = false;
			CECBCTRAParserFrame:Hide();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Broadcast Parser |cffff9999disabled")
	
		else
		
			CECBParser = true;
				CEnemyCastBar_ParserOnClick(0);
			CECBCTRAParserFrame:Show();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Broadcast Parser |cff99ff99temporary enabled")
		
		end

	elseif (msg == "clear") then		

		lockshow = 0;

			if (not CEnemyCastBar.bLocked) then

				CEnemyCastBar_LockPos();
				
			end

		for i=1, 20 do
	
			CEnemyCastBar_HideBar(i);
			
		end

	elseif (msg == "restore") then		

		local i = 1;
		while (i <= table.getn (DisabledSpells)) do
			local spell = DisabledSpells[i];

			if (CEnemyCastBar_Raids[spell]) then
				CEnemyCastBar_Raids[spell].disabled = nil;
			end
	
			if (CEnemyCastBar_Spells[spell]) then
				CEnemyCastBar_Spells[spell].disabled = nil;
			end
	
			if (CEnemyCastBar_Afflictions[spell]) then
				CEnemyCastBar_Afflictions[spell].disabled = nil;
			end

			i = i + 1;
		end			

		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Restored (|cffffff00"..table.getn (DisabledSpells).."|r) spells which were disabled by Shift + RightClick");
		DisabledSpells = { };

	elseif (msg == "disabled") then

		local DSpells = table.concat (DisabledSpells, "|cffff0000 | |r");
		if (table.getn (DisabledSpells) == 0) then
			DSpells = " -.-";
		end
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|cffffffff Disabled Spells: |r"..DSpells, 1, 1, 0);

	elseif (msg == "save") then

		CEnemyCastBar.tDisabledSpells = { };

		local i = 1;
		while (DisabledSpells[i]) do
			table.insert (CEnemyCastBar.tDisabledSpells, DisabledSpells[i]);
			i = i + 1;
		end

		if (table.getn (DisabledSpells) == 0) then
			DSpells = "Nothing disabled! |rEmpty table saved.";
		else
			i = i - 1;
			DSpells = i.." |rDisabled Spells saved.";
		end
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|cffffff00 "..DSpells);

	elseif (msg == "load") then

		CEnemyCastBar_LoadDisabledSpells();

	elseif (string.sub (msg, 1, 7) == "remove " and CEnemyCastBar.bStatus) then

		local msg1 = string.sub (msg, 8, string.len(msg) );
		local spellfound = false;

		local i = 1;
		while (DisabledSpells[i]) do

			if (string.lower(DisabledSpells[i]) == string.lower(msg1)) then
				DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|cffffffff Restored Spell: |r".. table.concat (DisabledSpells, "", i, i), 1, 1, 0);

					local spell = DisabledSpells[i];
					if (CEnemyCastBar_Raids[spell]) then
						CEnemyCastBar_Raids[spell].disabled = nil;
					end
			
					if (CEnemyCastBar_Spells[spell]) then
						CEnemyCastBar_Spells[spell].disabled = nil;
					end
			
					if (CEnemyCastBar_Afflictions[spell]) then
						CEnemyCastBar_Afflictions[spell].disabled = nil;
					end

				table.remove (DisabledSpells, i);
				spellfound = true;
				break;
			end
			i = i + 1;
		end

		if (not spellfound) then
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|cffffaaaa Spell not found!");
		end

	elseif (string.sub (msg, 1, 9) == "countsec " and CEnemyCastBar.bStatus) then

		local msg1 = tonumber (string.sub (msg, 10, 12));

		local textlen = string.len (msg);
		local textinput = string.sub (msg, 10, textlen);
		local firstspace = string.find (textinput, " ");
		local msg2;
		if (firstspace and textlen >= (firstspace + 10)) then
			msg2 = string.sub (msg, firstspace + 10, textlen);
			if ((firstspace +8) <= 12) then
				msg1 = tonumber (string.sub (msg, 10, firstspace + 8));
			end
		end

		if (msg1) then

			if (msg1 < 0) then
	
				DEFAULT_CHAT_FRAME:AddMessage("NECB: |cffff9999Invalid value to start the countdown!")
		
			else
		
				if (msg2 == nil) then msg2 = "Countdown";
				end
	
				if ( CEnemyCastBar_UniqueCheck(msg2, msg1, "("..msg1.." Seconds)") == 0 ) then
					CEnemyCastBar_Show("("..msg1.." Seconds)", msg2, msg1, "grey", nil, "INV_Misc_Bomb_03.blp");
				end

			end

		end

	elseif (string.sub (msg, 1, 9) == "countmin " and CEnemyCastBar.bStatus) then

		local msg1 = tonumber (string.sub (msg, 10, 12));

		local textlen = string.len (msg);
		local textinput = string.sub (msg, 10, textlen);
		local firstspace = string.find (textinput, " ");
		local msg2;
		if (firstspace and textlen >= (firstspace + 10)) then
			msg2 = string.sub (msg, firstspace + 10, textlen);
			if ((firstspace +8) <= 12) then
				msg1 = tonumber (string.sub (msg, 10, firstspace + 8));
			end
		end

		if (msg1) then

			if (msg1 * 60 < 0) then
	
			DEFAULT_CHAT_FRAME:AddMessage("NECB: |cffff9999Invalid value to start the countdown!")
	
			else
			
				if (msg2 == nil) then msg2 = "Countdown";
				end
	
				if ( CEnemyCastBar_UniqueCheck(msg2, msg1 * 60, "("..msg1.." Minutes)") == 0 ) then
					CEnemyCastBar_Show("("..msg1.." Minutes)", msg2, msg1 * 60, "grey", nil, "INV_Misc_Bomb_03.blp");
				end
				
	
			end

		end
		
	elseif (string.sub (msg, 1, 7) == "repeat " and CEnemyCastBar.bStatus) then

		local msg1 = tonumber (string.sub (msg, 8, 10));

		local textlen = string.len (msg);
		local textinput = string.sub (msg, 8, textlen);
		local firstspace = string.find (textinput, " ");
		local msg2;
		if (firstspace and textlen >= (firstspace + 8)) then
			msg2 = string.sub (msg, firstspace + 8, textlen);
			if ((firstspace +6) <= 10) then
				msg1 = tonumber (string.sub (msg, 8, firstspace + 6));
			end
		end

		if (msg1) then

			if (msg1 < 0) then
	
			DEFAULT_CHAT_FRAME:AddMessage("NECB: |cffff9999Invalid value to start the repeater!")

			else

				if (msg2 == nil) then msg2 = "Repeater";
				else msg2 = "Repeater: "..msg2;
				end
				if ( CEnemyCastBar_UniqueCheck(msg2, msg1, "("..msg1.." Seconds)") == 0 ) then
					CEnemyCastBar_Show("("..msg1.." Seconds)", msg2, msg1, "grey", nil, "INV_Misc_Bomb_04.blp");
				end
					
			end

		end
		
	elseif (string.sub (msg, 1, 10) == "stopcount " and CEnemyCastBar.bStatus) then

		local msg1;
		local textlen = string.len (msg);
		if (textlen >= 11) then
			msg1 = string.sub (msg, 11, textlen);
		end

		if (msg1) then

			if (msg1 == "all") then msg1 = " ";
			end

			for i=1, CEnemyCastBar.bNumBars do
			
				local label = getglobal("Carni_ECB_"..i).label;
				local r,g,b = getglobal("Carni_ECB_"..i.."_StatusBar"):GetStatusBarColor();

				if (label) then
					if (string.find (label, msg1) and ceil(b*10) == 8) then
						CEnemyCastBar_HideBar(i);
					end
				end
			end
		end

	elseif (msg == "debug") then

		if (CEnemyCastBar.bDebug) then
	
			CEnemyCastBar.bDebug = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r DebugMode |cffffff99disabled")
		
		else
		
			CEnemyCastBar.bDebug = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r DebugMode |cffffff99enabled")
		
		end
	end
end


-- Options Handler -----------------------
function CEnemyCastBar_Options(msg) --Options

	if (msg == "enable") then

		CEnemyCastBar.bStatus = true;
		CEnemyCastBar_RegisterEvents();
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r AddOn |cff99ff99enabled|cffffffff. (Events |cff99ff99registered|cffffffff.)")
		
	elseif (msg == "disable") then

		
		CEnemyCastBar_Handler("clear");
		CEnemyCastBar.bStatus = false;
		CEnemyCastBar_RegisterEvents("unregister");
		TempFPSBar = false; CECB_FPSBarFree:Hide(); CECB_ReloadOptionsUI();

		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r AddOn |cffff9999disabled|cffffffff. (Events |cffff9999unregistered|cffffffff.)")
		
	elseif (msg == "lock") then

		CEnemyCastBar_LockPos()

	elseif (msg == "show") then

		CEnemyCastBar_Handler("clear");

			if (CEnemyCastBar.bLocked) then

				CEnemyCastBar_LockPos();

			end

		CEnemyCastBar_Show("(unlocked)", "Move this bar!", 15.0, "friendly");

		lockshow = 1;
		
	elseif (msg == "reset") then

		CEnemyCastBar_Handler("clear");
		local lockcheck = CEnemyCastBar.bLocked; -- check if there is a difference after restoring (because of unlocking through "show")
		CEnemyCastBar_DefaultVars();
		CEnemyCastBar_ResetPos();
		CEnemyCastBar_SetTextSize();
		CECBOptionsFrameCECB_scale_Slider:SetValue(CEnemyCastBar.bScale); -- set sliders to default
		CECBOptionsFrameCECB_alpha_Slider:SetValue(CEnemyCastBar.bAlpha);

			if (not lockcheck == CEnemyCastBar.bLocked) then
				CEnemyCastBar.bLocked = lockcheck;
				CEnemyCastBar_LockPos();
			end

		if (TempFPSBar) then CEnemyCastBar_Handler("fpsbar");
		end

		CECB_ReloadOptionsUI();
		CECB_FPSBarFree:SetPoint("TOPLEFT", "UIParent", 50, -550);
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r AddOn is now |cff99ff99restored")
		
	elseif (msg == "pvp") then

		if (CEnemyCastBar.bPvP) then
	
			CEnemyCastBar.bPvP = false;
			CECB_ReloadOptionsUI();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r CastBars for PvP spells |cffff9999completely disabled")
	
		else
		
			CEnemyCastBar.bPvP = true;
			CECB_ReloadOptionsUI();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r CastBars for PvP spells |cff99ff99enabled")
		
		end

	elseif (msg == "cdown") then

		if (CEnemyCastBar.bCDown) then
	
			CEnemyCastBar.bCDown = false;
			CECB_ReloadOptionsUI();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show some CoolDowns |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bCDown = true;
			CECB_ReloadOptionsUI();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show some CoolDowns |cff99ff99enabled")

		end

	elseif (msg == "cdownshort") then

		if (CEnemyCastBar.bCDownShort) then
	
			CEnemyCastBar.bCDownShort = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Only show short cooldowns |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bCDownShort = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Only show short cooldowns |cff99ff99enabled")

		end

	elseif (msg == "gains") then

		if (CEnemyCastBar.bGains) then
	
			CEnemyCastBar.bGains = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show 'gains' (and their cooldown) |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bGains = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show 'gain type spells' |cff99ff99enabled")

		end

	elseif (msg == "pve") then

		if (CEnemyCastBar.bPvE) then
	
			CEnemyCastBar.bPvE = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r CastBars for PvE spells |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bPvE = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r CastBars for PvE spells |cff99ff99enabled")
		
		end

	elseif (msg == "afflict") then

		if (CEnemyCastBar.bShowafflict) then
	
			CEnemyCastBar.bShowafflict = false;
			CECB_ReloadOptionsUI();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show Debuffs |cffff9999completely disabled")

		else
		
			CEnemyCastBar.bShowafflict = true;
			CECB_ReloadOptionsUI();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show Debuffs |cff99ff99enabled")
		
		end

	elseif (msg == "globalfrag") then

		if (CEnemyCastBar.bGlobalFrag) then
	
			CEnemyCastBar.bGlobalFrag = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show 'Mob Outs' even w/o target |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bGlobalFrag = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show 'Mob Outs' even w/o target |cff99ff99enabled")

		end

	elseif (msg == "solod") then

		if (CEnemyCastBar.bSoloD) then
	
			CEnemyCastBar.bSoloD = false;
			CECB_ReloadOptionsUI();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show 'Solo Debuffs' (e.g. most stuns) |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bSoloD = true;
			CECB_ReloadOptionsUI();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show 'Solo Debuffs' (e.g. most stuns) |cff99ff99enabled")

		end

	elseif (msg == "magecold") then

		if (CEnemyCastBar.bMageC) then
	
			CEnemyCastBar.bMageC = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show 'Mages Cold Effects' (DeBuffs) |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bMageC = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Show 'Mages Cold Effects' (DeBuffs) |cff99ff99enabled")

		end

	elseif (msg == "drtimer") then

		if (CEnemyCastBar.bDRTimer) then
	
			CEnemyCastBar.bDRTimer = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Consider 'Diminishing Return' for biggest stun-family |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bDRTimer = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Consider 'Diminishing Return' for biggest stun-family |cff99ff99enabled")

		end

	elseif (msg == "classdr") then

		if (CEnemyCastBar.bClassDR) then
	
			CEnemyCastBar.bClassDR = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Consider Class specific 'Diminishing Return' |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bClassDR = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Consider Class specific 'Diminishing Return' |cff99ff99enabled")

		end

	elseif (msg == "sdots") then

		if (CEnemyCastBar.bSDoTs) then
	
			CEnemyCastBar.bSDoTs = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r CastBars to watch your DoT duration |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bSDoTs = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r CastBars to watch your DoT duration |cff99ff99enabled")

		end

	elseif (msg == "affuni") then

		if (CEnemyCastBar.bAfflictuni) then
	
			CEnemyCastBar.bAfflictuni = false;
			CECB_ReloadOptionsUI();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Only show RaidDebuffs |cffff9999disabled")
		
		else

			CEnemyCastBar.bAfflictuni = true;
			CECB_ReloadOptionsUI();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Only show RaidDebuffs |cff99ff99enabled")

		end

	elseif (msg == "parsec") then

		if (CEnemyCastBar.bParseC) then
	
			CEnemyCastBar.bParseC = false;
			CECB_ReloadOptionsUI();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Parse Raid/PartyChannel for commands |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bParseC = true;
			CECB_ReloadOptionsUI();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Parse Raid/PartyChannel for commands |cff99ff99enabled")
		
		end

	elseif (msg == "broadcast") then

		if (CEnemyCastBar.bBCaster) then
	
			CEnemyCastBar.bBCaster = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Broadcast Spells through CT_RA channel |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bBCaster = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Broadcast Spells through CT_RA channel |cff99ff99enabled")
		
		end

	elseif (msg == "fpsbar") then

		if (TempFPSBar) then
	
			TempFPSBar = false;
			CECB_FPSBarFree:Hide();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Standalone FPS-Bar |cffff9999disabled")
		
		else
		
			TempFPSBar = true;
			CECB_FPSBarFree:Show();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Standalone FPS-Bar |cff99ff99enabled")

		end

	elseif (msg == "timer") then

		if (CEnemyCastBar.bTimer) then

		for i=1, 20 do
	
			getglobal("Carni_ECB_"..i.."_CastTimeText"):SetText( );
			
		end

			CEnemyCastBar.bTimer = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r CastBar time display |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bTimer = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r CastBar time display |cff99ff99enabled")
		
		end

	elseif (msg == "targetm") then

		if (CEnemyCastBar.bTargetM) then
	
			CEnemyCastBar.bTargetM = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Target on BarLeftClick |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bTargetM = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Target on BarLeftClick |cff99ff99enabled")
		
		end

	elseif (msg == "tsize") then

		if (CEnemyCastBar.bSmallTSize) then
	
			CEnemyCastBar.bSmallTSize = false;
			CEnemyCastBar_SetTextSize();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Small textsize of CastBars |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bSmallTSize = true;
			CEnemyCastBar_SetTextSize();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Small textsize of CastBars |cff99ff99enabled")

		end

	elseif (msg == "flipb") then

		if (CEnemyCastBar.bFlipB) then
	
			CEnemyCastBar.bFlipB = false;
			CEnemyCastBar_FlipBars();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Bars now appear from first bar upwards. 'FlipOver' |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bFlipB = true;
			CEnemyCastBar_FlipBars();
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Bars now appear from first bar downwards. 'FlipOver' |cff99ff99enabled")

		end

	elseif (msg == "flashit") then

		if (CEnemyCastBar.bFlashit) then
	
			CEnemyCastBar.bFlashit = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r 'Flash' CastBars at their end |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bFlashit = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r 'Flash' CastBars at their end |cff99ff99enabled")

		end

	elseif (msg == "showicon") then

		if (CEnemyCastBar.bShowIcon) then
	
			CEnemyCastBar.bShowIcon = false;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Display a Spell Icon next to the CastBar |cffff9999disabled")
		
		else
		
			CEnemyCastBar.bShowIcon = true;
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Display a Spell Icon next to the CastBar |cff99ff99enabled")

		end
	end
end


function CEnemyCastBar_Show(mob, spell, castime, ctype, turnlabel, icontexture) --Show

 if (lockshow ~= 1) then

	local showing = false;
	local i = 1;
	local o = CEnemyCastBar.bNumBars;
	
	while (i <= o) do
	
		local button = getglobal("Carni_ECB_"..i);
		local fauxbutton = getglobal("FauxTargetBtn"..i);
	
		if (not button:IsVisible()) then
		
			if (showing == false) then
			
				if (ctype == "hostile") then
				
					red = 1.0;
					green = 0.0;
					blue = 0.0;					
				
				elseif (ctype == "friendly") then
				
					red = 0.0;
					green = 1.0;
					blue = 0.0;	
					
				elseif (ctype == "cooldown") then
				
					red = 0.0;
					green = 0.0;
					blue = 1.0;	
				
				elseif (ctype == "gains") then
				
					red = 1.0;
					green = 0.0;
					blue = 1.0;

				elseif (ctype == "grey") then
				-- be carefull, those values are checked later to remove those bars - search for "GetStatusBarColor"				
					red = 0.8;
					green = 0.8;
					blue = 0.8;

				elseif (ctype == "afflict") then

					red = 0.8;
					green = 0.8;
					blue = 0.0;

				elseif (ctype == "cursetype") then

					red = 0.0;
					green = 0.8;
					blue = 0.8;
				
				end

				getglobal("Carni_ECB_"..i).startTime = GetTime();

				if (turnlabel) then
					getglobal("Carni_ECB_"..i).label = mob .." - ".. spell;
				else
					getglobal("Carni_ECB_"..i).label = spell .." - ".. mob;
				end

				if (mob == UnitName("player")) then
					getglobal("Carni_ECB_"..i.."_Text"):SetShadowColor(1,0,0);
				else
					getglobal("Carni_ECB_"..i.."_Text"):SetShadowColor(0,0,0);
				end

				if (CEnemyCastBar.bShowIcon and icontexture) then
					getglobal("Carni_ECB_"..i.."_Icon"):SetTexture("Interface\\Icons\\"..icontexture);
					getglobal("Carni_ECB_"..i.."_Icon"):Show();
				else
					getglobal("Carni_ECB_"..i.."_Icon"):Hide();
				end

				getglobal("Carni_ECB_"..i).spell = spell;
				getglobal("Carni_ECB_"..i).endTime = getglobal("Carni_ECB_"..i).startTime + castime;
				getglobal("Carni_ECB_"..i.."_StatusBar"):SetMinMaxValues(button.startTime,button.endTime);
				getglobal("Carni_ECB_"..i.."_StatusBar"):SetValue(button.startTime);
				getglobal("Carni_ECB_"..i.."_StatusBar"):SetStatusBarColor(red, green, blue);
				fauxbutton:SetScale(CEnemyCastBar.bScale);
				fauxbutton:Show();				
				button:SetAlpha(0);
				button:SetScale(CEnemyCastBar.bScale);
				button:Show();
				MobTargetName[i] = mob;
				showing = true;
			
			end
		
		end
		
		i = i + 1;
		
	end
	
	showing = false;

 end  

end



function CEnemyCastBar_Gfind(arg1, event) --Gfind

	if (CEnemyCastBar.bStatus) then

		if (arg1) then

			for mob, spell in string.gfind(arg1, CEnemyCastBar_SPELL_CAST) do
					
				CEnemyCastBar_Control(mob, spell, "casts", nil, event);
				return;
			end	
			
			for mob, spell in string.gfind(arg1, CEnemyCastBar_SPELL_PERFORM) do
					
				CEnemyCastBar_Control(mob, spell, "performs");
				return;
			end
		
			for mob in string.gfind(arg1, CEnemyCastBar_MOB_DIES) do

				if (mob == CEnemyCastBar_CTHUN_NAME1) then
					--CEnemyCastBar_UniqueCheck("Dark Glare (Repeater)", 0, "clears castbar");
					CEnemyCastBar_UniqueCheck("Eye Tentacle (Repeater)", 0, "clears castbar");
					CEnemyCastBar_Control("C'Thun", "Phase2 Eye Tentacle", "pve");
				end

				CEnemyCastBar_Control(mob, mob, "died");
				return;
			end

			for mob, spell in string.gfind(arg1, CEnemyCastBar_SPELL_GAINS) do
					
				CEnemyCastBar_Control(mob, spell, "gains", nil, event);
				return;
			end
		
			-- return if Spell damage from other players/mobs is detected -> german client problem (without it DoTs from everyone will be displayed, see next clause)
			if (string.find(arg1, CEnemyCastBar_SPELL_DAMAGE) ) then

				return;
			end

			if ( GetLocale() == "frFR" ) then

				for spell, damage, mob in string.gfind(arg1, CEnemyCastBar_SPELL_DAMAGE_SELFOTHER) do

						CEnemyCastBar_Control(mob, spell, "periodicdmg");
					return;
				end

			else
				-- periodic debuff damage routine for enUS and deDE pattern, No.1
				for mob, damage, spell in string.gfind(arg1, CEnemyCastBar_SPELL_DAMAGE_SELFOTHER) do

						CEnemyCastBar_Control(mob, spell, "periodicdmg");
					return;
				end

			end

			-- periodic debuff damage routine for frFR, enUS and deDE pattern, No.2 - crit! has to be checked first!
			for spell, mob, damage in string.gfind(arg1, CEnemyCastBar_SPELL_CRITS_SELFOTHER) do

					CEnemyCastBar_Control(mob, spell, "periodichitdmg");
				return;
			end

			-- periodic debuff damage routine for frFR, enUS and deDE pattern, No.3 - noncrit! has to be checked after crit!
			for spell, mob, damage in string.gfind(arg1, CEnemyCastBar_SPELL_HITS_SELFOTHER) do

					CEnemyCastBar_Control(mob, spell, "periodichitdmg");
				return;
			end

			if ( GetLocale() == "deDE" ) then

				for mob, spell in string.gfind(arg1, CEnemyCastBar_SPELL_AFFLICTED) do

					CEnemyCastBar_Control(mob, spell, "afflicted", nil, event);
					return;
				end

				for mob, spell in string.gfind(arg1, CEnemyCastBar_SPELL_AFFLICTED2) do

					CEnemyCastBar_Control(mob, spell, "afflicted", nil, event);
					return;
				end

				for spell, mob in string.gfind(arg1, CEnemyCastBar_SPELL_REMOVED) do

					CEnemyCastBar_Control(mob, spell, "fades");
					return;
				end

			else

				for mob, crap, spell in string.gfind(arg1, CEnemyCastBar_SPELL_AFFLICTED) do

					CEnemyCastBar_Control(mob, spell, "afflicted", nil, event);
					return;
				end

				for mob, spell in string.gfind(arg1, CEnemyCastBar_SPELL_REMOVED) do

					CEnemyCastBar_Control(mob, spell, "fades");
					return;
				end
			end

			for spell, mob in string.gfind(arg1, CEnemyCastBar_SPELL_FADE) do

				CEnemyCastBar_Control(mob, spell, "fades");
				return;
			end

			for mob, spell in string.gfind(arg1, CEnemyCastBar_SPELL_CASTS) do
					
				CEnemyCastBar_Control(mob, spell, "instcast", nil, event);
				return;
			end
		end
	end
end

function CEnemyCastBar_UniqueCheck(spellname, castime, mob, gspell, DRText) --Unique

	local ashowing, drstate, labeladd = 0;

	if (gspell == "true") then

		for i=1, CEnemyCastBar.bNumBars do
		
			local spell = getglobal("Carni_ECB_"..i).spell;
			
			if (spell == spellname and mob == MobTargetName[i]) then

				ashowing = 1;

					local button = getglobal("Carni_ECB_"..i); --START unique updater
					if (mob == UnitName("player")) then
						getglobal("Carni_ECB_"..i.."_Text"):SetShadowColor(1,0,0);
					else
						getglobal("Carni_ECB_"..i.."_Text"):SetShadowColor(0,0,0);
					end

				break; -- there can be only one :D
			end
		end

	elseif (gspell == "trueupdate") then

		for i=1, CEnemyCastBar.bNumBars do
		
			local spell = getglobal("Carni_ECB_"..i).spell;
			
			if (spell == spellname and mob == MobTargetName[i]) then

				ashowing = 1;

					local button = getglobal("Carni_ECB_"..i); --START unique updater
					if (mob == UnitName("player")) then
						getglobal("Carni_ECB_"..i.."_Text"):SetShadowColor(1,0,0);
					else
						getglobal("Carni_ECB_"..i.."_Text"):SetShadowColor(0,0,0);
					end
					getglobal("Carni_ECB_"..i).startTime = GetTime();
					getglobal("Carni_ECB_"..i).endTime = getglobal("Carni_ECB_"..i).startTime + castime;
					getglobal("Carni_ECB_"..i.."_StatusBar"):SetMinMaxValues(button.startTime,button.endTime);
					getglobal("Carni_ECB_"..i.."_StatusBar"):SetValue(button.startTime);

				break; -- there can be only one :D
			end
		end

	else

		for i=1, CEnemyCastBar.bNumBars do
		
			local spell = getglobal("Carni_ECB_"..i).spell;
			
			if (spell == spellname) then
	
				ashowing = 1;

					local button = getglobal("Carni_ECB_"..i); --START unique updater

					if (mob == UnitName("player")) then
						getglobal("Carni_ECB_"..i.."_Text"):SetShadowColor(1,0,0);
					else
						getglobal("Carni_ECB_"..i.."_Text"):SetShadowColor(0,0,0);
					end

					if (DRText) then
						if (string.find(button.label, "1/2")) then
							drstate = 4; DRText = "(|cffff00001/4|r)"; castime = castime/2 + 15;
						elseif (string.find(button.label, "1/4")) then
							drstate = 6; DRText = "(|cffff0000immune|r)"; castime = castime/4 + 15;
						elseif (string.find(button.label, "immune")) then
							drstate = 2; DRText = "(|cffff00001/2|r)"; castime = castime + 15;
						end

						getglobal("Carni_ECB_"..i).label = spell .." "..DRText.." - "..mob;
					else
							getglobal("Carni_ECB_"..i).label = spell .." - ".. mob;
					end

					getglobal("Carni_ECB_"..i).startTime = GetTime();
					getglobal("Carni_ECB_"..i).endTime = getglobal("Carni_ECB_"..i).startTime + castime;
					getglobal("Carni_ECB_"..i.."_StatusBar"):SetMinMaxValues(button.startTime,button.endTime);
					getglobal("Carni_ECB_"..i.."_StatusBar"):SetValue(button.startTime);

					MobTargetName[i] = mob; --END unique updater
					
				break; -- there can be only one :D
			end
		end
	end

	return ashowing, drstate;
end

function CEnemyCastBar_BCast_Control(bcasted, channum) --BCast Control

	local down, up, latency = GetNetStats();

	if (not bcasted and channum ~= 0 and latency < 500 and CEnemyCastBar.bBCaster and CEnemyCastBar.bParseC and GetNumRaidMembers() ~= 0) then
		if (LastSentBCPacket) then
			if (BCPacket[1] == LastSentBCPacket[1] and BCPacket[2] == LastSentBCPacket[2] and BCPacket[3] == LastSentBCPacket[3] and (GetTime() - LastSentBCPacket[4]) < 5) then
				return false, latency;
			end
		end
		return true, latency;
	end
	return false, latency;
end

function CEnemyCastBar_Control(mob, spell, special, bcasted, event) --Control

		if (CEnemyCastBar.bStatus and CEnemyCastBar.bDebug) then

			if (event) then
				DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Debug, Con: "..mob.." (event: "..event..")");
			end
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Debug, Con: "..mob.." ("..spell.." "..special..")");
		
		end

	-- Convert "You" into Playername, important for broadcasts
	if (mob == CECB_SELF1 or mob == CECB_SELF2) then
		mob = UnitName("player");
	end

	local spelllength = string.len (spell);
	-- crop the german aposthrophes from some spells (')
	local spell_de = string.sub(spell, 2, spelllength - 1);
	if (CEnemyCastBar_Raids[spell_de]) then spell = spell_de;
	end

	-- Network BC TempBCaster
	local channum = GetChannelName(CEnemyCastBar.bCT_RA_chan);
	local clientlang = GetLocale();

	
	if (special ~= "fades" and CEnemyCastBar_Raids[spell]) then
		
		if (CEnemyCastBar.bPvE) then

			-- stop Boss CDs from beeing updated by fault when player enters combat
			if (special == "engage") then
				if (engagecd and (GetTime() - engagecd) < 180) then
					engagecd = GetTime();
					return;
				end
				engagerunning = true;
				engagecd = GetTime();
			else
				if (engagerunning and (GetTime() - engagecd) < 180) then
					engagecd = GetTime();
			
				elseif (engagerunning or engagecd) then
					engagerunning, engagecd = nil;
				end
			end

			-- only allow instant casts with a flag pass to avoid spell mirroring
			if (special == "instcast" and not CEnemyCastBar_Raids[spell].icasted) then
				return;
			end

			-- check if previously disabled with shift + leftclick; +more
			if (
					(CEnemyCastBar_Raids[spell].disabled)
				or	(CEnemyCastBar_Raids[spell].checktarget and UnitName("target") ~= mob)
				or	(CEnemyCastBar_Raids[spell].aZone and GetRealZoneText() ~= CEnemyCastBar_Raids[spell].aZone)
				or	(CEnemyCastBar_Raids[spell].checkevent and (not event or not string.find(CEnemyCastBar_Raids[spell].checkevent, event) ) )

				) then
				return;
			end

			local icontex = CEnemyCastBar_Raids[spell].icontex; -- > get icon texture
			local globalspell = CEnemyCastBar_Raids[spell].global; -- > This castbar won't be updated if already active!
			castime = CEnemyCastBar_Raids[spell].t;
			ctype = CEnemyCastBar_Raids[spell].c;
			
			-- Spell might have the same name but a different cast time on another mob, ie. Onyxia/Nefarian on Bellowing Roar
			if (CEnemyCastBar_Raids[spell].r) then
			
				if (mob == CEnemyCastBar_Raids[spell].r) then
				
					castime = CEnemyCastBar_Raids[spell].a;
				
				end
			
			end


			if (CEnemyCastBar_Raids[spell].m) then

				mobbuffer = mob;
				mob = CEnemyCastBar_Raids[spell].m;
			
			end


			-- stop mirroring spells! only this mob produces castbars
			if (CEnemyCastBar_Raids[spell].mcheck) then
			
				mobcheck = CEnemyCastBar_Raids[spell].mcheck;
			else
				mobcheck = nil;
			
			end

			-- stop mirroring spells! only active casts are allowed
			if (CEnemyCastBar_Raids[spell].active and special ~= "casts") then
			
				mobcheck = "xyzdontshowspell";
			
			end

			if (mobcheck == nil or mobcheck == mob) then

				alreadyshowing = CEnemyCastBar_UniqueCheck(spell,castime,mob,globalspell);

			else

				alreadyshowing = 1;

			end
			
			if (alreadyshowing == 0) then

				CEnemyCastBar_Show(mob, spell, castime, ctype, nil, icontex);
			
			end
			
			if (CEnemyCastBar_Raids[spell].i) then

				castime = CEnemyCastBar_Raids[spell].i;

				--
				if (mobcheck == nil or mobcheck == mob) then
	
					alreadyshowing = CEnemyCastBar_UniqueCheck(spell.." (D)",castime,mob,globalspell);
	
				else
	
					alreadyshowing = 1;
	
				end
				--
			
				if (alreadyshowing == 0) then

					CEnemyCastBar_Show(mob, spell.." (D)", castime, "hostile", nil, icontex);
				
				end
			
			end


			-- Network BCasting
			if (mobcheck == nil or mobcheck == mob) then
				if (special == "afflicted" and mob ~= mobcheck) then
					mob = "CECBName"; -- so no channel spam appears after the raid got feared etc.
				end

				BCPacket = {mob, spell, special};
				local freetosend, latency = CEnemyCastBar_BCast_Control(bcasted, channum);
				if ( freetosend ) then
					CEnemyCastBar_SendMessage(".cecbspell "..mob..", "..spell..", "..special..", "..clientlang..", "..latency);
					LastSentBCPacket = {mob, spell, special, GetTime()};
					LastGotBCPacket = {mob, spell, special, GetTime()};
					numspellcast = 0;
				end
			end

			-- recall control function for mobs dying (Obsidian Destroyer) to clear all bars
			if (special == "died") then
				if (mobbuffer) then
					CEnemyCastBar_Control(mobbuffer, "dummy_xyz", "died");
					mobbuffer = nil;
				else
					CEnemyCastBar_Control(mob, "dummy_xyz", "died");
				end
			end
		end
		
	else
	
		if (CEnemyCastBar.bPvP) then

			if (UnitName("target") == mob) then

			    if (special == "casts" or special == "gains" or special == "performs") then

				-- crop the german aposthrophes from some spells (')
				local spell_de = string.sub(spell, 2, spelllength - 1);
				if (CEnemyCastBar_Spells[spell_de]) then spell = spell_de;
				end

				if (CEnemyCastBar_Spells[spell]) then

					-- check if previously disabled with shift + leftclick
					if (CEnemyCastBar_Spells[spell].disabled) then
						return;
					end

					local icontex = CEnemyCastBar_Spells[spell].icontex; -- > get icon texture
						
					if (UnitIsEnemy("player", "target")) then
						ctype = "hostile";
					else
						ctype = "friendly";
					end
			
					if (CEnemyCastBar_Spells[spell].i) then
					
						castime = CEnemyCastBar_Spells[spell].i;
						CEnemyCastBar_Show(mob, spell, castime, ctype, nil, icontex);					
					
					end
					
					if (CEnemyCastBar_Spells[spell].d and CEnemyCastBar.bCDown) then

						if (not (special == "gains" and not CEnemyCastBar.bGains)) then

							castime = CEnemyCastBar_Spells[spell].d;
							if (not (castime > 60 and CEnemyCastBar.bCDownShort) ) then
								if (CEnemyCastBar_UniqueCheck(spell.." (CD)", castime, mob, "trueupdate") == 0) then
									CEnemyCastBar_Show(mob, spell.." (CD)", castime, "cooldown", nil, icontex);
								end
							end
						end
					end

					castime = CEnemyCastBar_Spells[spell].t; -- but if only "d=" is applied then "t=nil", so check at end of this block
					
					-- Spell might have the same name but a different cast time on another mob, ie. Death Talon Hatchers/Players on Bellowing Roar
					if (CEnemyCastBar_Spells[spell].r) then
					
						if (mob == CEnemyCastBar_Spells[spell].r) then
						
							castime = CEnemyCastBar_Spells[spell].a;
						
						end
					
					end

					if (special == "gains") then

						if (CEnemyCastBar.bGains) then

							ctype = "gains";
							if (CEnemyCastBar_Spells[spell].g) then
							
								castime = CEnemyCastBar_Spells[spell].g;
							
							end
						else

							castime = nil;

						end
					end

					if (CEnemyCastBar_Spells[spell].c) then
					
						ctype = CEnemyCastBar_Spells[spell].c;
					
					end
					
					if (castime) then
					CEnemyCastBar_Show(mob, spell, castime, ctype, nil, icontex);
					end

			 	end
			
			    end

			end
				
		end
	-- new block
	-- other than PvE, independent of PvP
		-- now check everytime, since some gains shall be removed, too (see REMOVALS in afflictions section of localization.lua)
		if (special == "fades") then -- spells fading earlier than bar, not very important since most spells can't end earlier and aren't listed in c-log after recast and still afflicted

			-- crop the german aposthrophes from some spells (')
			local spell_de = string.sub(spell, 2, spelllength - 1);
			if (CEnemyCastBar_Afflictions[spell_de]) then spell = spell_de;
			end

			if (CEnemyCastBar_Afflictions[spell]) then

				if (CEnemyCastBar_Afflictions[spell].periodicdmg) then
					return; -- don't hide dmg debuffs, can be other player's fade!
				end

				-- correct DR if a DR Spell fades earlier
				if (CEnemyCastBar.bClassDR and CEnemyCastBar_Afflictions[spell].spellDR) then
					local drshare = CEnemyCastBar_Afflictions[spell].drshare;
					if (drshare) then
						CEnemyCastBar_UniqueCheck("DR: "..drshare, 15, mob, "trueupdate", "");
					else
						CEnemyCastBar_UniqueCheck("DR: "..spell, 15, mob, "trueupdate", "");
					end
				end

				for i=1, CEnemyCastBar.bNumBars do
	
					local spellrunning = getglobal("Carni_ECB_"..i).spell;
					if (spellrunning) then
	
						local mobrunning = MobTargetName[i];
						if (mob == mobrunning and spell == spellrunning and not CEnemyCastBar_Afflictions[spell].multi) then
							
							CEnemyCastBar_HideBar(i);

							if (CEnemyCastBar_Afflictions[spell].global or CEnemyCastBar_Afflictions[spell].fragile) then
							-- Network BCasting
								BCPacket = {mob, spell, special};
								local freetosend, latency = CEnemyCastBar_BCast_Control(bcasted, channum);
								if ( freetosend ) then
									CEnemyCastBar_SendMessage(".cecbspell "..mob..", "..spell..", "..special..", "..clientlang..", "..latency);
									LastSentBCPacket = {mob, spell, special, GetTime()};
									LastGotBCPacket = {mob, spell, special, GetTime()};
									numspellcast = 0;
								end
							end

							break; -- there can be only one :D
					
						end
					end
				end
			end

		-- clear on mob died; to save some CPU time breackit it out
		elseif (special == "died") then

			for i=1, CEnemyCastBar.bNumBars do

				local spellrunning = getglobal("Carni_ECB_"..i).spell;
				if (spellrunning) then

					-- remove DR Timers upon death
					if (string.find(spellrunning, "DR:")) then
						spellrunning = "Stun DR";
					end

					local mobrunning = MobTargetName[i];
					if (CEnemyCastBar_Afflictions[spellrunning]) then

						-- "if" mob can't die without removing the debuff, so this wasn't the 'afflicted' mob
						-- "death" negates the above
						local fragile = CEnemyCastBar_Afflictions[spellrunning].fragile;
						local death = CEnemyCastBar_Afflictions[spellrunning].death;

						if (mob == mobrunning and (not fragile or death)) then
							
							CEnemyCastBar_HideBar(i);

							if (CEnemyCastBar_Afflictions[spellrunning].global or CEnemyCastBar_Afflictions[spellrunning].fragile) then
							-- Network BCasting
								BCPacket = {mob, spell, special};
								local freetosend, latency = CEnemyCastBar_BCast_Control(bcasted, channum);
								if ( freetosend ) then
									CEnemyCastBar_SendMessage(".cecbspell "..mob..", "..spell..", "..special..", "..clientlang..", "..latency);
									LastSentBCPacket = {mob, spell, special, GetTime()};
									LastGotBCPacket = {mob, spell, special, GetTime()};
									numspellcast = 0;
								end
							end
						
						end

					-- to clear all but CD bars if mob dies
					elseif (CEnemyCastBar_Spells[spellrunning]) then

						if (mob == mobrunning and (CEnemyCastBar.bCDownShort or not string.find(getglobal("Carni_ECB_"..i).label, "(CD)") ) ) then
							CEnemyCastBar_HideBar(i);
						end --
					end
				end
			end

		-- other than faded/died
		elseif (CEnemyCastBar.bShowafflict) then

	 		-- only 'afflicted', DoTs allowed!
			if (special == "afflicted" or (CEnemyCastBar.bSDoTs and (special == "periodicdmg" or special == "periodichitdmg") ) ) then

				-- crop the german aposthrophes from some spells (')
				local spell_de = string.sub(spell, 2, spelllength - 1);
				if (CEnemyCastBar_Afflictions[spell_de]) then spell = spell_de;
				end
	
	 			-- check if spell stacks
				local fbracket,_,spellstacks = string.find(spell, "(%(%d+%))" );
				if (fbracket) then
					spell = string.sub(spell, 1, fbracket - 2);
				else
					spellstacks = false;
				end			
	
				-- database check
				if (CEnemyCastBar_Afflictions[spell]) then
	
					if (
								-- check if previously disabled with shift + leftclick
							(CEnemyCastBar_Afflictions[spell].disabled)
								-- break if 'mage cold debuff' but disabled
						or	(CEnemyCastBar_Afflictions[spell].magecold and not CEnemyCastBar.bMageC)
								-- periodic dmg spells shall only be triggered if they do damage, otherwise the affliction might be from another player!
						or	( (special == "afflicted" and CEnemyCastBar_Afflictions[spell].periodicdmg) or ((special == "periodicdmg" or special == "periodichitdmg") and not CEnemyCastBar_Afflictions[spell].periodicdmg) )

						) then
						return;
					end
	
					alreadyshowing = 0;
					local icontex = CEnemyCastBar_Afflictions[spell].icontex; -- > get icon texture
					local globalspell = CEnemyCastBar_Afflictions[spell].global; -- > castbars without a target check (Raidencounter)!
					local fragile = CEnemyCastBar_Afflictions[spell].fragile; -- > for option to show "fragiles" without a target!
	
					if (UnitName("target") == mob or globalspell or (fragile and CEnemyCastBar.bGlobalFrag) or special == "periodicdmg" or special == "periodichitdmg") then
	
						castime = CEnemyCastBar_Afflictions[spell].t;
	
						-- Consider Combo points for duration; wait 3 secs for 'Rupture's first DoT damage!
						if (CEnemyCastBar_Afflictions[spell].cpinterval and CECBownCPsHitTime and (GetTime() - CECBownCPsHitTime) < 3) then
							castime = castime - (CEnemyCastBar_Afflictions[spell].cpinterval * (5 - CECBownCPsHit));
							--DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Debug, castime="..castime.." -CECBownCPsHit="..CECBownCPsHit.." -cpinterval="..CEnemyCastBar_Afflictions[spell].cpinterval.." -timediff="..GetTime() - CECBownCPsHitTime) --!
						end
	
						if (special == "periodicdmg" or special == "periodichitdmg") then
							ctype = "cursetype";
						else
							ctype = "afflict";
						end
	
						-- DR START
						local DRTimer = 0;
						-- subfunction for DR Timer; CASTIME will be modified in Uni function (if DRText transmitted to funcion = last flag and label found -> after ELSE)
						local function CEnemyCastBar_DRBar(msg)
							if (CEnemyCastBar_UniqueCheck(msg, castime, mob, "true") == 0) then
								if (CEnemyCastBar_UniqueCheck(msg, castime, mob) == 0) then
									if (msg == "Stun DR") then
										CEnemyCastBar_Show(mob, msg, castime, "cooldown", nil, "Spell_Frost_Stun");
									else
										CEnemyCastBar_Show(mob, msg, castime, "cooldown", nil, icontex);
									end
								end
								CEnemyCastBar_UniqueCheck(msg, 15 + castime, mob, nil, "(|cffff00001/2|r)");
							else
								_, DRTimer = CEnemyCastBar_UniqueCheck(msg, castime, mob, nil, "trigger label check in uni function");
							end
						end
	
						-- stun diminishing returns bar
						if (not CEnemyCastBar.bAfflictuni and CEnemyCastBar.bDRTimer and mob ~= UnitName("player") and CEnemyCastBar_Afflictions[spell].stun) then
	
							CEnemyCastBar_DRBar("Stun DR");
						end
	
						-- pvp diminishing returns bar, CEnemyCastBar.bPvPDR
						local _, playersclass = UnitClass("player");
						if (CEnemyCastBar.bClassDR and not CEnemyCastBar.bAfflictuni and CEnemyCastBar_Afflictions[spell].spellDR and playersclass == CEnemyCastBar_Afflictions[spell].sclass and (UnitIsPlayer("target") or CEnemyCastBar_Afflictions[spell].affmob) and mob ~= UnitName("player")) then
							local drshare = CEnemyCastBar_Afflictions[spell].drshare;
							if (drshare) then
								CEnemyCastBar_DRBar("DR: "..drshare);
							else
								CEnemyCastBar_DRBar("DR: "..spell);
							end
						end
	
						if (DRTimer == 4 or DRTimer == 6) then
							castime = castime / (DRTimer - 2);
						end
						-- DR END
	
						-- break if 'solo spell' but disabled
						if (CEnemyCastBar_Afflictions[spell].solo and not CEnemyCastBar.bSoloD) then
							return;
						end
	
						if (CEnemyCastBar_Afflictions[spell].m) then
						
							mob = CEnemyCastBar_Afflictions[spell].m
						
						end
	
						-- unique check; Raidspells (globalspell) won't be updated; Fragiles will be updated and multiple bars allowed
						if (fragile) then
							alreadyshowing = CEnemyCastBar_UniqueCheck(spell,castime,mob,"trueupdate");
						elseif (spellstacks) then
							alreadyshowing = CEnemyCastBar_UniqueCheck(spell,castime,mob,nil,spellstacks);
						elseif (special == "periodicdmg" or special == "periodichitdmg") then
							if (special == "periodichitdmg" and CEnemyCastBar_Afflictions[spell].directhit) then
								alreadyshowing = CEnemyCastBar_UniqueCheck(spell,castime,mob);
								castime = castime + 1.0;
							else
								castime = castime - 1.5;
								alreadyshowing = CEnemyCastBar_UniqueCheck(spell,castime,mob,"true");
							end
						else
							alreadyshowing = CEnemyCastBar_UniqueCheck(spell,castime,mob,globalspell);
						end
	
						-- to detect if CPs are cleared AFTER a skill has been used, to update with correct duration afterwards if event "PLAYER_COMBO_POINTS" is fired
						if (playersclass == "ROGUE" and CEnemyCastBar_Afflictions[spell].cpinterval and not CEnemyCastBar_Afflictions[spell].periodicdmg) then
							CECBownCPsHitBuffer = {mob, spell, GetTime(), DRTimer };
						end
		
						if (globalspell or fragile) then
							-- Network BCasting
							BCPacket = {mob, spell, special};
							local freetosend, latency = CEnemyCastBar_BCast_Control(bcasted, channum);
							if ( freetosend ) then
								CEnemyCastBar_SendMessage(".cecbspell "..mob..", "..spell..", "..special..", "..clientlang..", "..latency);
								LastSentBCPacket = {mob, spell, special, GetTime()};
								LastGotBCPacket = {mob, spell, special, GetTime()};
								numspellcast = 0;
							end
						end
	
						if (alreadyshowing == 0) then
	
							-- Check for non-Raiddebuff and if they are switched off
							-- turnaroundlabel through "globalspell" (turnlabel), because the name is more important then
							if (not (globalspell ~= "true" and CEnemyCastBar.bAfflictuni) ) then
	
								CEnemyCastBar_Show(mob, spell, castime, ctype, globalspell, icontex);
								if (spellstacks) then
									CEnemyCastBar_UniqueCheck(spell,castime,mob,nil,spellstacks);
								end
							end
						end
					end

				end -- is spell in database?
		 	end -- check for afflicted/ DoTs option + periodicdmg

		end -- clear on mob fades/dies, elseif check option, afflictions set on?
		------ block end (afflictions+)

	end -- finishes pve 'else' pvp, died if afflictions/fades
		
end

function CEnemyCastBar_Yells(arg1, arg2) --Yell

		if (CEnemyCastBar.bStatus and CEnemyCastBar.bDebug) then
	
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Debug, YELL: "..arg1.."\nMOB="..arg2)
		
		end

	if (CEnemyCastBar.bStatus) then
	
		if (arg2 == "Nefarian") then

			if (string.find(arg1, CEnemyCastBar_NEFARIAN_SHAMAN_CALL)) then 
				CEnemyCastBar_Control("Shamans", "Nefarian calls", "pve");
				return;

			elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_DRUID_CALL)) then 
				CEnemyCastBar_Control("Druids", "Nefarian calls", "pve");
				return;

			elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_WARLOCK_CALL)) then 
				CEnemyCastBar_Control("Warlocks", "Nefarian calls", "pve");
				return;

			elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_PRIEST_CALL)) then 
				CEnemyCastBar_Control("Priests", "Nefarian calls", "pve");
				return;

			elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_HUNTER_CALL)) then 
				CEnemyCastBar_Control("Hunters", "Nefarian calls", "pve");
				return;

			elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_WARRIOR_CALL)) then 
				CEnemyCastBar_Control("Warriors", "Nefarian calls", "pve");
				return;

			elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_ROGUE_CALL)) then 
				CEnemyCastBar_Control("Rogues", "Nefarian calls", "pve");
				return;

			elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_PALADIN_CALL)) then 
				CEnemyCastBar_Control("Paladins", "Nefarian calls", "pve");
				return;

			elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_MAGE_CALL)) then 
				CEnemyCastBar_Control("Mages", "Nefarian calls", "pve");
				return;

			elseif (string.find(arg1, CEnemyCastBar_NEFARIAN_LAND)) then
			
				CEnemyCastBar_Control("Nefarian", "Landing", "pve");
				return;

			end

		elseif (arg2 == "Lord Victor Nefarius") then
	
			if (string.find(arg1, CEnemyCastBar_NEFARIAN_STARTING)) then
			
				CEnemyCastBar_Control("Nefarian", "Mob Spawn", "pve");
				return;
			
			end

		elseif (arg2 == "Ragnaros") then
		
			if (string.find(arg1, CEnemyCastBar_RAGNAROS_STARTING)) then
		
				CEnemyCastBar_Control("Ragnaros", "Submerge", "pve");
				return;
				
			elseif (string.find(arg1, CEnemyCastBar_RAGNAROS_KICKER)) then
			
				CEnemyCastBar_Control("Ragnaros", "Knockback", "pve");
				return;
				
			elseif (string.find(arg1, CEnemyCastBar_RAGNAROS_SONS)) then
			
				CEnemyCastBar_Control("Ragnaros", "Sons of Flame", "pve");
				return;
			
			end

		elseif (arg2 == CEnemyCastBar_RAZORGORE_CALLER) then
		
			if (string.find(arg1, CEnemyCastBar_RAZORGORE_CALL)) then
			
				CEnemyCastBar_Control("Razorgore", "Mob Spawn (45sec)", "pve");
				return;
			
			end

		elseif (arg2 == CEnemyCastBar_SARTURA_NAME) then
		
			if (string.find(arg1, CEnemyCastBar_SARTURA_CALL)) then

				CEnemyCastBar_Control("Sartura", "Enraged mode", "pve");
				return;
			
			end

		elseif (arg2 == "Hakkar") then
		
			if (string.find(arg1, CEnemyCastBar_HAKKAR_YELL)) then

				CEnemyCastBar_Control("Hakkar", "LIFE DRAIN", "pve");
				return;
			
			end
		
		end
	
	end

end

function CEnemyCastBar_Emotes(arg1, arg2) --Emote

	if (CEnemyCastBar.bStatus) then

		if (CEnemyCastBar.bStatus and CEnemyCastBar.bDebug) then
	
			DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r Debug, EMOTE: "..arg1.."\nMOB="..arg2)
		
		end

		if (arg2 == CEnemyCastBar_FLAMEGOR_NAME) then
		
			if (string.find(arg1, CEnemyCastBar_FLAMEGOR_FRENZY)) then
		
				CEnemyCastBar_Control("Flamegor", "Frenzy (CD)", "pve");
				return;
				
			end
		
		elseif (arg2 == "Chromaggus") then
		
			if (string.find(arg1, CEnemyCastBar_CHROMAGGUS_FRENZY)) then
		
				CEnemyCastBar_Control("Chromaggus", "Killing Frenzy", "pve");
				return;
				
			end

		elseif (arg2 == "Moam") then
		
			if (string.find(arg1, CEnemyCastBar_MOAM_STARTING)) then
		
				CEnemyCastBar_Control("Moam", "Until Stoneform", "pve");
				return;
				
			end

		elseif (arg2 == CEnemyCastBar_SARTURA_NAME) then
		
			if (string.find(arg1, CEnemyCastBar_SARTURA_CRAZY)) then

				CEnemyCastBar_Control("Sartura", "Enraged mode", "fades");
				CEnemyCastBar_Control("Sartura", "Enters Enraged mode", "pve");
				return;
				
			end

		elseif (arg2 == CEnemyCastBar_HUHURAN_NAME) then
		
			if (string.find(arg1, CEnemyCastBar_HUHURAN_FRENZY)) then
		
				CEnemyCastBar_Control("Huhuran", "Frenzy (CD)", "pve");
				return;

			elseif (string.find(arg1, CEnemyCastBar_HUHURAN_CRAZY)) then

				CEnemyCastBar_Control("Huhuran", "Berserk mode", "fades");
				CEnemyCastBar_Control("Huhuran", "Enters Berserk mode", "pve");
				return;
				
			end

		elseif (string.find(CEnemyCastBar_CTHUN_NAME1, arg2) ) then
		
			if (string.find(arg1, CEnemyCastBar_CTHUN_WEAKENED)) then
		
				CEnemyCastBar_UniqueCheck("Eye Tentacle (Repeater)", 0, "clears castbar");
				CEnemyCastBar_Control("C'Thun", "Weakened!!!", "pve", "true");
				CEnemyCastBar_Control("C'Thun", "Next Eye Tentacle", "pve", "true");
				return;
				
			end

		end
	
	end

end

function CEnemyCastBar_Player_Enter_Combat() --enter combat (Aggro etc., not only melee autoattack -> "regen. disabled" event)

	if (CEnemyCastBar.bStatus) then
	
		if (UnitName("target") == CEnemyCastBar_FIREMAW_NAME or UnitName("target") == CEnemyCastBar_FLAMEGOR_NAME or UnitName("target") == CEnemyCastBar_EBONROC_NAME) then

			CEnemyCastBar_Control("Presumed", "First Wingbuffet", "pve");
			return;

		elseif (UnitName("target") and (string.find (UnitName("target"), "Vek'lor") or string.find (UnitName("target"), "Vek'nilash"))) then

			CEnemyCastBar_Control("Twins", "Enraged mode", "engage");
			return;

		elseif (UnitName("target") and string.find (UnitName("target"), "Huhuran") ) then

			CEnemyCastBar_Control("Huhuran", "Berserk mode", "engage");
			return;

		elseif (UnitName("target") and string.find (UnitName("target"), CEnemyCastBar_CTHUN_NAME1) ) then

			CEnemyCastBar_Control("C'Thun", "Eye Tentacle (Repeater)", "engage");
			CEnemyCastBar_Control("C'Thun", "First Dark Glare", "engage");
			return;

		end

	end

end

function CEnemyCastBar_Parse_RaidChat(msg, author, origin) --parse Raid/PartyChat for commands

	if (CEnemyCastBar.bParseC) then

		if (string.sub (msg, 1, 10) == ".countsec " or string.sub (msg, 1, 10) == ".countmin " or string.sub (msg, 1, 8) == ".repeat " or string.sub (msg, 1, 11) == ".stopcount " or string.sub (msg, 1, 11) == ".cecbspell " or string.sub (msg, 1, 30) == "<CECB> CT_RA Channel detected.") then

			local detectedCECBcommand = true;

			if (origin == "CT_RA") then

				-- check if author is in your raidgroup
				local name, rank, inraid;
				for i = 1, GetNumRaidMembers() do
					name, rank = GetRaidRosterInfo(i);
					if ( name == author ) then
						inraid = true;
						break;
					end
				end

				if (not inraid) then return detectedCECBcommand; --!
				end --!
			end
		
			--Network BC
			if (string.sub (msg, 1, 11) == ".cecbspell ") then

				wrongclient = false;
				if (UnitName("player") == author) then return detectedCECBcommand; --!
				end --!

				for bcmob, bcspell, bcspecial, bcclientlang, bclatency in string.gfind (msg, ".cecbspell (.+), (.+), (.+), (.+), (.+)") do

					if (bcclientlang ~= GetLocale()) then
						wrongclient = true;
						return detectedCECBcommand;
					end

					-- Check if last receive was the same packet within 5 seconds -> then break!
					if (LastGotBCPacket) then
						if (bcmob == LastGotBCPacket[1] and bcspell == LastGotBCPacket[2] and bcspecial == LastGotBCPacket[3] and (GetTime() - LastGotBCPacket[4]) < 5) then
							numspellcast = numspellcast + 1; 
							return detectedCECBcommand;
						end
					end

				--DEFAULT_CHAT_FRAME:AddMessage("m:"..bcmob.." s:"..bcspell.." t:"..bcspecial) --!
				numspellcast = 99;
				LastGotBCPacket = {bcmob, bcspell, bcspecial, GetTime()};
				CEnemyCastBar_Control(bcmob, bcspell, bcspecial, "true");
				return detectedCECBcommand; --unnecessary but gives a good feeling :D
				end

			else
				-- version harvester
				for version in string.gfind(msg, "<CECB> CT_RA Channel detected. (.+)") do
					version = string.sub(version, 2, string.len (version) - 1); -- remove brackets
					table.insert (VersionDB, version);
					table.insert (VersionNames, author);
				end

				local msg1 = string.sub (msg, 2, string.len(msg));
				CEnemyCastBar_Handler(msg1);
				return detectedCECBcommand; --unnecessary but gives a good feeling :D
			end

			return detectedCECBcommand;

		-- check for CT_RaidAssist broadcast
		elseif (origin == "Raid") then

			for chan in string.gfind(msg, "<CTMod> This is an automatic message sent by CT_RaidAssist. Channel changed to: (.+)") do
				CEnemyCastBar.bCT_RA_chan = chan;
				if (CECBOptionsFrame:IsVisible()) then
					CECB_ReloadOptionsUI();
				end
				DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|r CT_RA Broadcast detected. Channel adopted!", 1, 0.5, 0);
				VersionDB = { };
				CEnemyCastBar_SendMessage("<CECB> CT_RA Channel detected. ("..CECB_status_version_txt..", "..GetLocale()..")");
			end
		end
	end
end

function CEnemyCastBar_SendMessage(msgs) --send

	-- converter for 'drunken protection'
	msgs = string.gsub(msgs, "s", "$");
	msgs = string.gsub(msgs, "S", "§");
	SendChatMessage(msgs, "CHANNEL", nil, GetChannelName(CEnemyCastBar.bCT_RA_chan));

end

function CEnemyCastBar_OnUpdate() --Update

	local CECname=this:GetName();
	local CECno=this:GetID();
	local fauxbtn=getglobal("FauxTargetBtn"..CECno);

    if (not carniactive) then
	
        -- Fade the bar out
        local alpha = this:GetAlpha() - 0.05;
        if (alpha > 0) then
            this:SetAlpha(alpha);
        end
	CEnemyCastBar_HideBar(CECno);
		
    else
	
		if (this.endTime) then

			local label = mobname;
			local now = GetTime();
			-- Update the spark, status bar and label
			local remains = this.endTime - now;
			--label = label .. CEnemyCastBar_NiceTime(remains);
			local sparkPos = ((now - this.startTime) / (this.endTime - this.startTime)) * 195;
			
			getglobal(this:GetName() .. "_StatusBar"):SetValue(now);
			getglobal(this:GetName() .. "_Text"):SetText( this.label );	
			getglobal(this:GetName() .. "_StatusBar_Spark"):SetPoint("CENTER", getglobal(this:GetName() .. "_StatusBar"), "LEFT", sparkPos, 0);
			
			if (CEnemyCastBar.bTimer) then
				
				getglobal(this:GetName() .. "_CastTimeText"):SetText( CEnemyCastBar_NiceTime(remains) );
			
			end


			-- fantastic fading routine + flashing, fps independent :D
			local framerate = GetFramerate();
			local stepping = 2/framerate;

			if (stepping > 0.4 ) then stepping = 0.4; -- security for very low fps (< 5fps)
			end

			local baralpha = this:GetAlpha();
			local totalTime = this.endTime - this.startTime;
			if (CEnemyCastBar.bFlashit and (remains/totalTime) < 0.20 and remains < 10 and totalTime >= 20) then

				stepping2 = stepping/1.2 -- manipulate flashing-speed
				if ((baralpha - stepping2) >= 0.1) then
					baralpha = baralpha - stepping2;
					this:SetAlpha(baralpha);
				else
					this:SetAlpha(1);
				end

			else

				if (baralpha + stepping <= CEnemyCastBar.bAlpha) then
					baralpha = baralpha + stepping;
					this:SetAlpha(baralpha);
				else
					if (baralpha ~= CEnemyCastBar.bAlpha) then
						this:SetAlpha(CEnemyCastBar.bAlpha);
					end
				end
			end
			-- fading routine finished

			if (remains < 0) then

				if (string.find (getglobal(this:GetName()).label, "Repeater") ) then

					local castime = getglobal(this:GetName()).endTime - getglobal(this:GetName()).startTime;
					getglobal(this:GetName()).startTime = GetTime();
					getglobal(this:GetName()).endTime = getglobal(this:GetName()).startTime + castime;
					getglobal(this:GetName().."_StatusBar"):SetMinMaxValues(getglobal(this:GetName()).startTime,getglobal(this:GetName()).endTime);
					getglobal(this:GetName().."_StatusBar"):SetValue(getglobal(this:GetName()).startTime);

					if (castime == 0) then
						getglobal(this:GetName()).label = "delete me!";
					end

				else
			
					if (getglobal(this:GetName()).spell == "Move this bar!" and lockshow == 1) then
					lockshow = 0;
						if (CEnemyCastBar.bLocked == false) then
							CEnemyCastBar_LockPos();
						end

					-- damn C'Thun crazy timers
					-- elseif (string.find (getglobal(this:GetName()).label, "First Dark Glare") ) then
					--	CEnemyCastBar_Control("C'Thun", "Dark Glare (Repeater)", "pve", "true");

					elseif (string.find (getglobal(this:GetName()).label, "Next Eye Tentacle") or string.find (getglobal(this:GetName()).label, "Phase2 Eye Tentacle") ) then
						CEnemyCastBar_Control("C'Thun", "Eye Tentacle (Repeater)", "pve", "true");
						CEnemyCastBar_UniqueCheck("Eye Tentacle (Repeater)", 30, "C'Thun");

					end

					CEnemyCastBar_HideBar(CECno);

				end

			elseif (remains >= 5 ) then

				-- pull the bars together
				local CECpre = CECno - 1;
				local cecbuttonpre = getglobal("Carni_ECB_"..CECpre);

				if (CECpre > 0 and not cecbuttonpre:IsShown()) then

					cecbuttonpre.startTime = this.startTime
					cecbuttonpre.label = this.label;
		
					local r,g,b = getglobal("Carni_ECB_"..CECno.."_Text"):GetShadowColor();
					getglobal("Carni_ECB_"..CECpre.."_Text"):SetShadowColor(r,g,b);
		
					if (getglobal("Carni_ECB_"..CECno.."_Icon"):IsShown()) then
						getglobal("Carni_ECB_"..CECpre.."_Icon"):SetTexture(getglobal("Carni_ECB_"..CECno.."_Icon"):GetTexture());
						getglobal("Carni_ECB_"..CECpre.."_Icon"):Show();
					end
		
					cecbuttonpre.spell = this.spell;
					cecbuttonpre.endTime = this.endTime;
					getglobal("Carni_ECB_"..CECpre.."_StatusBar"):SetMinMaxValues(getglobal("Carni_ECB_"..CECno.."_StatusBar"):GetMinMaxValues());
					getglobal("Carni_ECB_"..CECpre.."_StatusBar"):SetValue(getglobal("Carni_ECB_"..CECno.."_StatusBar"):GetValue());
					getglobal("Carni_ECB_"..CECpre.."_StatusBar"):SetStatusBarColor(getglobal("Carni_ECB_"..CECno.."_StatusBar"):GetStatusBarColor());
					getglobal("FauxTargetBtn"..CECpre):Show();				
					MobTargetName[CECpre] = MobTargetName[CECno];
					cecbuttonpre:SetAlpha(CEnemyCastBar.bAlpha);
					cecbuttonpre:Show();
		
					CEnemyCastBar_HideBar(CECno);
				end
			end
		
		end
    end
end

-- Movable window
function CEnemyCastBar_OnDragStart()
    CarniEnemyCastBarFrame:StartMoving();
end

function CEnemyCastBar_OnDragStop()
    CarniEnemyCastBarFrame:StopMovingOrSizing();
end

-- Format seconds into m:ss
function CEnemyCastBar_NiceTime(secs)
	if (secs > 60) then
		return string.format("%d:%02d", secs / 60, math.mod(secs, 60));
	else
		return string.format("%.1f", secs);
	end
end

-- Show/hide Options
function CECB_ShowHideOptionsUI()
	if (CECBOptionsFrame:IsVisible()) then
		CECBOptionsFrame:Hide();
	else
		CECBOptionsFrame:Show();

		if (CEnemyCastBar.bPvP) then
			CECB_Checkbox_toggle("cdown", "enable");
			CECB_Checkbox_toggle("gains", "enable");
			if (CEnemyCastBar.bCDown) then
				CECB_Checkbox_toggle("cdownshort", "enable");
			else
				CECB_Checkbox_toggle("cdownshort", "disable");
			end
		else
			CECB_Checkbox_toggle("cdown", "disable");
			CECB_Checkbox_toggle("gains", "disable");
			CECB_Checkbox_toggle("cdownshort", "disable");
		end

		if (CEnemyCastBar.bShowafflict) then
			-- + 'solo debuffs' + all DR Checkboxes under 'globalfrag'
			CECB_Checkbox_toggle("affuni", "enable");
			if (CEnemyCastBar.bAfflictuni) then
				CECB_Checkbox_toggle("globalfrag", "disable");
			else
				CECB_Checkbox_toggle("globalfrag", "enable");
			end
		else
			CECB_Checkbox_toggle("affuni", "disable");
			CECB_Checkbox_toggle("globalfrag", "disable");
		end

		if (CEnemyCastBar.bParseC) then
			if (GetChannelName(CEnemyCastBar.bCT_RA_chan) == 0) then
				CECB_Checkbox_toggle("broadcast", "disable");
				CECBOptionsFrameCTRAChanText:SetText("|cffffcc00"..CECB_menue_CTRAChan.."|cffaaaaaa"..CECB_menue_CTRAnoBC);
			else
				CECB_Checkbox_toggle("broadcast", "enable");
				CECBOptionsFrameCTRAChanText:SetText("|cffffcc00"..CECB_menue_CTRAChan.."|cffffaa00/"..GetChannelName(CEnemyCastBar.bCT_RA_chan).." "..CEnemyCastBar.bCT_RA_chan);
			end
		else
			CECB_Checkbox_toggle("broadcast", "disable");
			if (GetChannelName(CEnemyCastBar.bCT_RA_chan) == 0) then
				CECBOptionsFrameCTRAChanText:SetText("|cffaaaaaa"..CECB_menue_CTRAChan..CECB_menue_CTRAnoBC);
			else
				CECBOptionsFrameCTRAChanText:SetText("|cffaaaaaa"..CECB_menue_CTRAChan.."/"..GetChannelName(CEnemyCastBar.bCT_RA_chan).." "..CEnemyCastBar.bCT_RA_chan);
			end
		end
	end
end

function CECB_ReloadOptionsUI()
	CECB_ShowHideOptionsUI();
	CECB_ShowHideOptionsUI();
end

function CECB_Checkbox_toggle(which, todo) --toggle

	if (which == "status") then
	
		if (todo == "enable") then
			CECBOptionsFrameCECB_status_check:Enable();
			CECBOptionsFrameCECB_status_checkText:SetText(CECB_status_txt);

		elseif (CECBOptionsFrameCECB_status_check:IsEnabled() ) then
			CECBOptionsFrameCECB_status_check:Disable();
			CECBOptionsFrameCECB_status_checkText:SetText("|cffaaaaaa"..CECB_status_txt);
		end

	elseif (which == "cdown") then
	
		if (todo == "enable") then
			CECBOptionsFrameCECB_cdown_check:Enable();
			CECBOptionsFrameCECB_cdown_checkText:SetText(CECB_cdown_txt);
		else
			CECBOptionsFrameCECB_cdown_check:Disable();
			CECBOptionsFrameCECB_cdown_checkText:SetText("|cffaaaaaa"..CECB_cdown_txt);
		end

	elseif (which == "gains") then
	
		if (todo == "enable") then
			CECBOptionsFrameCECB_gains_check:Enable();
			CECBOptionsFrameCECB_gains_checkText:SetText(CECB_gains_txt);
		else
			CECBOptionsFrameCECB_gains_check:Disable();
			CECBOptionsFrameCECB_gains_checkText:SetText("|cffaaaaaa"..CECB_gains_txt);
		end

	elseif (which == "affuni") then
	
		if (todo == "enable") then
			CECBOptionsFrameCECB_affuni_check:Enable();
			CECBOptionsFrameCECB_affuni_checkText:SetText(CECB_affuni_txt);

		else
			CECBOptionsFrameCECB_affuni_check:Disable();
			CECBOptionsFrameCECB_affuni_checkText:SetText("|cffaaaaaa"..CECB_affuni_txt);

		end

	-- plus 'solo debuffs', plus 'mages cold effects'
	elseif (which == "globalfrag") then
	
		if (todo == "enable") then
			CECBOptionsFrameCECB_magecold_check:Enable();
			CECBOptionsFrameCECB_magecold_checkText:SetText(CECB_magecold_txt);
			CECBOptionsFrameCECB_solod_check:Enable();
			CECBOptionsFrameCECB_solod_checkText:SetText(CECB_solod_txt);
			CECBOptionsFrameCECB_globalfrag_check:Enable();
			CECBOptionsFrameCECB_globalfrag_checkText:SetText(CECB_globalfrag_txt);
			CECBOptionsFrameCECB_drtimer_check:Enable();
			CECBOptionsFrameCECB_drtimer_checkText:SetText(CECB_drtimer_txt);
			CECBOptionsFrameCECB_classdr_check:Enable();
			CECBOptionsFrameCECB_classdr_checkText:SetText(CECB_classdr_txt);
			CECBOptionsFrameCECB_sdots_check:Enable();
			CECBOptionsFrameCECB_sdots_checkText:SetText(CECB_sdots_txt);
		else
			CECBOptionsFrameCECB_magecold_check:Disable();
			CECBOptionsFrameCECB_magecold_checkText:SetText("|cffaaaaaa"..CECB_magecold_txt);
			CECBOptionsFrameCECB_solod_check:Disable();
			CECBOptionsFrameCECB_solod_checkText:SetText("|cffaaaaaa"..CECB_solod_txt);
			CECBOptionsFrameCECB_globalfrag_check:Disable();
			CECBOptionsFrameCECB_globalfrag_checkText:SetText("|cffaaaaaa"..CECB_globalfrag_txt);
			CECBOptionsFrameCECB_drtimer_check:Disable();
			CECBOptionsFrameCECB_drtimer_checkText:SetText("|cffaaaaaa"..CECB_drtimer_txt);
			CECBOptionsFrameCECB_classdr_check:Disable();
			CECBOptionsFrameCECB_classdr_checkText:SetText("|cffaaaaaa"..CECB_classdr_txt);
			CECBOptionsFrameCECB_sdots_check:Disable();
			CECBOptionsFrameCECB_sdots_checkText:SetText("|cffaaaaaa"..CECB_sdots_txt);
		end

	elseif (which == "cdownshort") then
	
		if (todo == "enable") then
			CECBOptionsFrameCECB_cdownshort_check:Enable();
			CECBOptionsFrameCECB_cdownshort_checkText:SetText(CECB_cdownshort_txt);
		else
			CECBOptionsFrameCECB_cdownshort_check:Disable();
			CECBOptionsFrameCECB_cdownshort_checkText:SetText("|cffaaaaaa"..CECB_cdownshort_txt);
		end

	elseif (which == "broadcast") then
	
		if (todo == "enable") then
			CECBOptionsFrameCECB_broadcast_check:Enable();
			CECBOptionsFrameCECB_broadcast_checkText:SetText(CECB_broadcast_txt);
		else
			CECBOptionsFrameCECB_broadcast_check:Disable();
			CECBOptionsFrameCECB_broadcast_checkText:SetText("|cffaaaaaa"..CECB_broadcast_txt);
		end
	end
end

-- Show/hide ApplyReset
function CECB_ApplyResetFrame()
	if (CECBApplyResetFrame:IsVisible()) then
		CECBApplyResetFrame:Hide();

	else
		CECBApplyResetFrame:Show();
	end
end

function CECB_Options_Sub(todo, value) --options sub

	local i = 1;
	while (OptionFrameNames[i]) do

		if (todo == "alpha") then OptionFrameNames[i]:SetAlpha(value);
		elseif (todo == "hide") then OptionFrameNames[i]:Hide();
		elseif (todo == "show") then OptionFrameNames[i]:Show();
		end

		i = i + 1;
	end
end

function CEnemyCastBar_Options_OnUpdate() --Menue on update

	if (not cecbmaxsize and CECBOptionsFrame:GetHeight() > (menuesizey - 1)) then
		bgalpha = 1; CECB_Options_Sub("show");
		cecbmaxsize = true; cecbminsize = false;
		CECB_Checkbox_toggle("status", "enable");
	elseif (not cecbminsize and CECBOptionsFrame:GetHeight() < (mshrinksizey + 1)) then
		bgalpha = 0; CECB_Options_Sub("hide");
		cecbminsize = true; cecbmaxsize = false;
		CECB_Checkbox_toggle("status", "enable");
	end

	local framerate = GetFramerate();
	local stepping = 2/framerate;
	if (stepping > 0.4 ) then stepping = 0.4; -- security for very low fps (< 5fps)
	end

	-- add fps-meter
	local g = framerate/30;
	local r = 30/framerate;

	if (g > 1) then g = 1;	end
	if (r > 1) then r = 1;	end

	if (framerate > 100) then frameratesafe = 100;
	else frameratesafe = framerate;
	end

	CECBOptionsFrameBGFrameFPSBar_StatusBar:SetMinMaxValues(1,100);
	CECBOptionsFrameBGFrameFPSBar_StatusBar:SetValue(frameratesafe);
	CECBOptionsFrameBGFrameFPSBar_StatusBar_Spark:SetPoint("CENTER", "CECBOptionsFrameBGFrameFPSBar_StatusBar", "LEFT", frameratesafe*1.95, 0);
	CECBOptionsFrameBGFrameFPSBar_Text:SetText("|cffffffaaFPS: |cffffcc00"..ceil(framerate));
	CECBOptionsFrameBGFrameFPSBar_StatusBar:SetStatusBarColor(r,g,0);
	-- fps-meter finished

-- now we start
	if (fademenue == 1) then
		local malpha = CECBOptionsFrame:GetAlpha() - stepping*2;
		if (malpha > 0) then
			CECBOptionsFrame:SetAlpha(malpha);
		else
			CECBOptionsFrame:Hide();
			fademenue = false;
		end

	elseif (fademenue == 2) then
		local malpha = CECBOptionsFrame:GetAlpha() + stepping*2;
		if (malpha < 1) then
			CECBOptionsFrame:SetAlpha(malpha);
		else
			CECBOptionsFrame:SetAlpha(1);
			fademenue = false;
		end
	end

	if (not CEnemyCastBar.bStatus) then

		if (not cecbminsize) then

			local optionsheight = CECBOptionsFrame:GetHeight();
			local optionswidth = CECBOptionsFrame:GetWidth();
			if ((optionsheight - stepping*150) > (mshrinksizey +1)) then
				CECB_Checkbox_toggle("status", "disable");
				optionsheight = optionsheight - stepping*150;
				CECBOptionsFrame:SetHeight(optionsheight);
				
				if ((optionswidth - stepping*200) > (mshrinksizex +1)) then
					optionswidth = optionswidth - stepping*200;
					CECBOptionsFrame:SetWidth(optionswidth);
				else
					CECBOptionsFrame:SetWidth(mshrinksizex);
				end
	
				if ((bgalpha - stepping) >= 0) then bgalpha = bgalpha - stepping;
					CECB_Options_Sub("alpha", bgalpha);
					CECBOptionsFrameBGFrame1:SetBackdropBorderColor(1 - bgalpha, 0, 0);
				else
					CECB_Options_Sub("alpha", 0);
				end

			else
				CECB_Options_Sub("hide");
				CECBOptionsFrame:SetHeight(mshrinksizey);
			end
		end

	elseif (not cecbmaxsize) then

		local optionsheight = CECBOptionsFrame:GetHeight();
		local optionswidth = CECBOptionsFrame:GetWidth();
		CECBOptionsFrameBGFrame1:SetBackdropBorderColor(0.4, 0.4, 0.4);

		CECB_Options_Sub("show");

		if ((optionsheight + stepping*150) < (menuesizey -1)) then
			CECB_Checkbox_toggle("status", "disable");
			optionsheight = optionsheight + stepping*150;
			CECBOptionsFrame:SetHeight(optionsheight);

			if ((optionswidth + stepping*200) < (menuesizex -1)) then
				optionswidth = optionswidth + stepping*200;
				CECBOptionsFrame:SetWidth(optionswidth);
			else
				CECBOptionsFrame:SetWidth(menuesizex);
			end

			if ((bgalpha + stepping) <= 1) then bgalpha = bgalpha + stepping;
				CECB_Options_Sub("alpha", bgalpha);
			else
				CECB_Options_Sub("alpha", 1);
			end
		else
			CECBOptionsFrame:SetHeight(menuesizey);
			CECB_Options_Sub("alpha", 1);
		end
	end
end

function CEnemyCastBar_FPSBar_OnUpdate() --FPSBar

	local framerate = GetFramerate();
	local g = framerate/30;
	local r = 30/framerate;

	if (g > 1) then g = 1;	end
	if (r > 1) then r = 1;	end

	if (framerate > 100) then frameratesafe = 100;
	else frameratesafe = framerate;
	end

	CECB_FPSBarFree_StatusBar:SetMinMaxValues(1,100);
	CECB_FPSBarFree_StatusBar:SetValue(frameratesafe);
	CECB_FPSBarFree_StatusBar_Spark:SetPoint("CENTER", "CECB_FPSBarFree_StatusBar", "LEFT", frameratesafe*1.95, 0);
	CECB_FPSBarFree_Text:SetText("|cffffffaaFPS: |cffffcc00"..ceil(framerate));
	CECB_FPSBarFree_StatusBar:SetStatusBarColor(r,g,0);

end

function CECB_MiniMap_Slider_OnShow()
	getglobal(this:GetName().."High"):SetText("360\194\176");
	getglobal(this:GetName().."Low"):SetText(CECB_minimapoff_txt);

	if (CEnemyCastBar.bMiniMap == 0) then
		getglobal(this:GetName() .. "Text"):SetText(CECB_minimap_txt .. CECB_minimapoff_txt);
	else
		getglobal(this:GetName() .. "Text"):SetText(CECB_minimap_txt .. CEnemyCastBar.bMiniMap .."\194\176");
	end

	this:SetMinMaxValues(0, 360);
	this:SetValueStep(2);
	this:SetValue(CEnemyCastBar.bMiniMap);
end

function CECB_MiniMap_Slider_OnValueChanged()

	CEnemyCastBar.bMiniMap = this:GetValue();

	if (CEnemyCastBar.bMiniMap == 0) then
		CECBMiniMapButton:Hide();
		getglobal(this:GetName() .. "Text"):SetText(CECB_minimap_txt .. CECB_minimapoff_txt);
	else
		CECBMiniMapButton:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 52 - (80 * cos(this:GetValue())), (80 * sin(this:GetValue())) - 52);
		CECBMiniMapButton:Show();
		getglobal(this:GetName() .. "Text"):SetText(CECB_minimap_txt .. CEnemyCastBar.bMiniMap .."\194\176");
	end
end

function CECB_scale_Slider_OnShow()
	getglobal(this:GetName().."High"):SetText("130%");
	getglobal(this:GetName().."Low"):SetText("30%");

	getglobal(this:GetName() .. "Text"):SetText(CECB_scale_txt .. CEnemyCastBar.bScale * 100 .. "%");

	this:SetMinMaxValues(0.3, 1.3);
	this:SetValueStep(0.1);
	this:SetValue(CEnemyCastBar.bScale);
end

function CECB_scale_Slider_OnValueChanged()

	local delta = abs(CEnemyCastBar.bScale - this:GetValue()) * 100;
	local BarScaleOld = CEnemyCastBar.bScale;
	-- DEFAULT_CHAT_FRAME:AddMessage("old: " .. CEnemyCastBar.bScale .. " | new: " .. this:GetValue() .." | delta "..delta)

	CEnemyCastBar.bScale = this:GetValue() * 10;

	if (CEnemyCastBar.bScale < 0) then
		CEnemyCastBar.bScale = ceil(CEnemyCastBar.bScale - 0.5)
	else
		CEnemyCastBar.bScale = floor(CEnemyCastBar.bScale + 0.5)
	end

	CEnemyCastBar.bScale = CEnemyCastBar.bScale / 10;

	getglobal(this:GetName() .. "Text"):SetText(CECB_scale_txt .. CEnemyCastBar.bScale * 100 .. "%");

	if (delta >= 1) then

		CEnemyCastBar_Handler("clear");
	
		local BarScaleFactor = BarScaleOld / CEnemyCastBar.bScale;

		local frame = getglobal("Carni_ECB_1");
		local p, rf, rp, x, y = frame:GetPoint();
		
		--DEFAULT_CHAT_FRAME:AddMessage("p="..p..", rp="..rp..", x="..x..", y="..y);
		x = (x + 102.5 - 102.5 * 1/BarScaleFactor)* BarScaleFactor;
		y = (y - 10 + 10 * 1/BarScaleFactor) * BarScaleFactor;
		frame:SetPoint("TOPLEFT", "UIParent", x, y);
	
		CEnemyCastBar_Show("Info", "New CastBarStyle!", 10.0, "friendly");

	end

end


function CECB_alpha_Slider_OnShow()
	getglobal(this:GetName().."High"):SetText("1");
	getglobal(this:GetName().."Low"):SetText("0.1");

	getglobal(this:GetName() .. "Text"):SetText(CECB_alpha_txt .. CEnemyCastBar.bAlpha);

	this:SetMinMaxValues(0.1, 1.0);
	this:SetValueStep(0.1);
	this:SetValue(CEnemyCastBar.bAlpha);
end

function CECB_alpha_Slider_OnValueChanged()

	local delta = abs(CEnemyCastBar.bAlpha - this:GetValue()) * 100;

	CEnemyCastBar.bAlpha = this:GetValue() * 10;
	if (CEnemyCastBar.bAlpha < 0) then
		CEnemyCastBar.bAlpha = ceil(CEnemyCastBar.bAlpha - 0.5)
	else
		CEnemyCastBar.bAlpha = floor(CEnemyCastBar.bAlpha + 0.5)
	end
	CEnemyCastBar.bAlpha = CEnemyCastBar.bAlpha / 10;

	getglobal(this:GetName() .. "Text"):SetText(CECB_alpha_txt .. CEnemyCastBar.bAlpha);

	CECB_PrintBar_OnMove(delta);

end

function CECB_numbars_Slider_OnShow()
	getglobal(this:GetName().."High"):SetText("20");
	getglobal(this:GetName().."Low"):SetText("5");

	getglobal(this:GetName() .. "Text"):SetText(CECB_numbars_txt .. CEnemyCastBar.bNumBars);

	this:SetMinMaxValues(5, 20);
	this:SetValueStep(1);
	this:SetValue(CEnemyCastBar.bNumBars);
end

function CECB_numbars_Slider_OnValueChanged()

	local delta = abs(CEnemyCastBar.bNumBars - this:GetValue()) * 10;
	--DEFAULT_CHAT_FRAME:AddMessage("old: " .. CEnemyCastBar.bNumBars .. " | new: " .. this:GetValue() .." | delta "..delta)

	if (delta >= 1) then

		CEnemyCastBar_Handler("clear");
	
		CEnemyCastBar.bNumBars = this:GetValue();
	
		getglobal(this:GetName() .. "Text"):SetText(CECB_numbars_txt .. CEnemyCastBar.bNumBars);
	
		for i=1, CEnemyCastBar.bNumBars do
			CEnemyCastBar_Show("Info", "CastBarNumbers", 5.0, "friendly");
		end

	end

end

function CECB_space_Slider_OnShow()
	getglobal(this:GetName().."High"):SetText("50");
	getglobal(this:GetName().."Low"):SetText("10");

	getglobal(this:GetName() .. "Text"):SetText(CECB_space_txt .. CEnemyCastBar.bSpace);

	this:SetMinMaxValues(10, 50);
	this:SetValueStep(1);
	this:SetValue(CEnemyCastBar.bSpace);
end

function CECB_space_Slider_OnValueChanged()

	local delta = abs(CEnemyCastBar.bSpace - this:GetValue()) * 10;

	if (delta >= 1) then

		CEnemyCastBar_Handler("clear");
	
		CEnemyCastBar.bSpace = this:GetValue();
	
		getglobal(this:GetName() .. "Text"):SetText(CECB_space_txt .. CEnemyCastBar.bSpace);
	
		CEnemyCastBar_FlipBars(); -- sets the space, too!
		for i=1, CEnemyCastBar.bNumBars do
			CEnemyCastBar_Show("Info", "Space between CastBars!", 5.0, "friendly", nil, "Spell_Holy_Renew");
		end

	end

end

function CECB_PrintBar_OnMove(delta)

	if (delta >= 1) then

		CEnemyCastBar_Handler("clear");
	
		CEnemyCastBar_Show("Info", "New CastBarStyle!", 10.0, "friendly");


	end
end

function CECB_GCInfo_OnUpdate()

	local GCTime = GetTime();

	if (not lastgcupdate or GCTime - lastgcupdate > 0.5) then
		lastgcupdate = GCTime;

		local cecbgc_now, cecbgc_max = gcinfo();

		if (not cecbgc_last or cecbgc_last > cecbgc_now) then
			cecbgc_last = cecbgc_now;
			cecbgc_min = cecbgc_now;
			cecbgc_minupdate = GCTime;
			lastgcdiffupdate = nil;
			cecbgc_purge30 = 0;
		end

		if (not lastgcdiffupdate or GCTime - lastgcdiffupdate > 5) then
			lastgcdiffupdate = GCTime;
	
			cecbgcdiff = (cecbgc_now - cecbgc_last) / 5;
			cecbgc_last = cecbgc_now;

			local GCPurgeCalcLength = 30;
			if ((GCTime - cecbgc_minupdate) > GCPurgeCalcLength) then
				if (cecbgc_min == cecbgc_now) then
					cecbgc_purge30 = 0;
				else
					cecbgc_purge30 = (cecbgc_max - cecbgc_now) * (GCTime - cecbgc_minupdate) / (cecbgc_now - cecbgc_min);
				end
				cecbgc_min = cecbgc_now;
				cecbgc_minupdate = GCTime;
			end

			if (cecbgc_min == cecbgc_now and cecbgc_purge30 == 0) then
				cecbgcpurge = "waiting...";
			else
				if (cecbgc_min == cecbgc_now) then
					cecbgcpurge = cecbgc_purge30;
				else
					if (GCTime - cecbgc_minupdate > GCPurgeCalcLength or cecbgc_purge30 == 0) then
						cecbgcpurge = (cecbgc_max - cecbgc_now) * (GCTime - cecbgc_minupdate) / (cecbgc_now - cecbgc_min);
					else
						cecbgcpurge = (cecbgc_purge30 * (GCPurgeCalcLength - (GCTime - cecbgc_minupdate)) / GCPurgeCalcLength) + (cecbgc_max - cecbgc_now) * (GCTime - cecbgc_minupdate) / (cecbgc_now - cecbgc_min) * (GCTime - cecbgc_minupdate) / GCPurgeCalcLength;
					end
				end

				if (cecbgcpurge >= 3600) then
					cecbgcpurge = string.format("%d:%02d (|cffffccccHour|r:|cffccffccMin|r)", cecbgcpurge / 3600, math.mod(cecbgcpurge / 60, 60));
				elseif (cecbgcpurge >= 60) then
					cecbgcpurge = string.format("%d:%02d (|cffccffccMin|r:|cffccccffSec|r)", cecbgcpurge / 60, math.mod(cecbgcpurge, 60));
				else
					cecbgcpurge = string.format("%d (|cffccccffSeconds|r)", cecbgcpurge);
				end
			end

		end

		local gctext1 = "|cffffff00This is a simple tool to observe the memory usage of all your addons!\n\n";
		local gctext2 = "|cffcccc00Estimated time until purge: |r"..cecbgcpurge.."\n\n";
		local gctext3 = "|cffccccffUsed Memory |r- |cffffccccGainRate |r- |cffccffccMaximum\n";
		local gctext4 = "|cff9999ff"..cecbgc_now.."|rkb - |cffff9999"..cecbgcdiff.."|rkb/s - |cff99ff99"..cecbgc_max.."|rkb";
		CECBGCFrameBGText:SetText(gctext1..gctext2..gctext3..gctext4, 0.8, 0.8, 0.8);

	end

end

function CEnemyCastBar_Validchar(msg) --validchar

	value = true;

	for i = 1, string.len(msg) do

		local ctable = string.byte(string.sub(msg,i,i));
		if ( not ( (ctable >= 48 and ctable <= 57) or (ctable >= 65 and ctable <= 90) or (ctable >= 97 and ctable <= 122) ) ) then
			value = false;
		end
	end

	return value;
end

function CEnemyCastBar_LoadDisabledSpells(msg) --loaddisabled

	DisabledSpells = { };

	local i = 1;
	while (CEnemyCastBar.tDisabledSpells[i]) do

			local spell = CEnemyCastBar.tDisabledSpells[i];
			if (CEnemyCastBar_Raids[spell]) then
				CEnemyCastBar_Raids[spell].disabled = true;
			end
	
			if (CEnemyCastBar_Spells[spell]) then
				CEnemyCastBar_Spells[spell].disabled = true;
			end
	
			if (CEnemyCastBar_Afflictions[spell]) then
				CEnemyCastBar_Afflictions[spell].disabled = true;
			end

		table.insert (DisabledSpells, CEnemyCastBar.tDisabledSpells[i]);
		i = i + 1;
	end

	if (not msg) then
		if (table.getn (DisabledSpells) == 0) then
			DSpells = "Nothing disabled found! |rEmpty table loaded.";
		else
			i = i - 1;
			DSpells = i.." |rDisabled Spells loaded. (see |cff00ff00/necb disabled|r)";
		end
		DEFAULT_CHAT_FRAME:AddMessage("|cffaaaaaaNECB:|cffffff00 "..DSpells);
	end

end