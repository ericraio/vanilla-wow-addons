--[[ SimpleTip (redux) v1.7 by Ayradyss
	Based on Skeeve of Proudmore's SimpleTip 1.2.4 and updated for new patches.
	Original mod can be found at http://www.curse-gaming.com/mod.php?addid=425 
	All credit for actual code should go to Skeeve.  ]]--
	
--[[ Modified by Nathanmx to include props tooltip lines ]]--

SimpleTipParms = {move=false, x=0, y=0, anchor="CENTER", PvP=true}
---------------------------------------------------
-- main tooltip adjuster function
function SimpleTip_TweakTip(unit)
	local linecount = GameTooltip:NumLines();
	local tmp = nil;
	local idx = nil;
	local level = nil;

	-- Player tooltip text
	if (UnitIsPlayer(unit)) then
		level = UnitLevel(unit);
		if(level < 0) then level = "??" end;
		GameTooltipTextLeft2:SetText(UnitRace(unit).." "..UnitClass(unit)..", "..LEVEL.." "..level, 1.0, 1.0, 1.0);
		tmp = GetGuildInfo(unit);
		if (tmp) then
			GameTooltip:AddLine("<"..tmp..">","", 1.0, 1.0, 1.0);
		else
		end
	end
	
	--[[	
	local oldTip = GameTooltipTextLeft2:GetText();
			if (oldTip) then
				local TargetClass = UnitClass("mouseover");
				if (TargetClass and UnitIsDeadOrGhost("mouseover") and UnitPlayerControlled("mouseover")) then
					GameTooltipTextLeft2:SetText(oldTip.." ("..TargetClass..")");
				end
	]]--
			
	--Configurable PvP line show/hide
	if (SimpleTipParms.PvP == false) then
		tmp = getglobal("GameTooltipTextLeft"..linecount);
		if (tmp) then
			if ((tmp:GetText()==PVP_ENABLED) or (tmp:GetText()==PVP_DISABLED)) then
				tmp:SetText(nil);
			end
		end
	end
		
	-- tooltip colors
	if (UnitExists(unit)) then
		local r, g, b = GameTooltip_UnitColor(unit);
		-- if they're *all* 1.0, then they're a friendly player; make it blue
		if (r*b*g == 1.0) then
			r=0.0; b=1.0; g=0.0;
		end
		if ((r ~= TOOLTIP_DEFAULT_BACKGROUND_COLOR.r) or
			(g ~= TOOLTIP_DEFAULT_BACKGROUND_COLOR.g) or
			(b ~= TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)) then
			GameTooltip:SetBackdropColor(r, g, b);
			GameTooltipTextLeft1:SetTextColor(1.0, 0.82, 0.0);
		end
	end
	
	local coder = PropsCoderTooltips[UnitName("mouseover")];
	if (coder) then
		GameTooltip:AddLine(coder,1.0,1.0,1.0);
	end

	GameTooltip:Show();
end

---------------------------------------------------
-- GameTooltip OnEvent() hook
function SimpleTip_OnEvent(event)
	if (event == "UPDATE_MOUSEOVER_UNIT") then
		if(UnitIsConnected("mouseover") or UnitIsPlayer("mouseover")) then 
			SimpleTip_TweakTip("mouseover");
		end
	end
end
	
---------------------------------------------------
-- UnitFrame OnEnter() hook
function SimpleTip_UnitFrame_OnEnter()
	SimpleTip_Old_UnitFrame_OnEnter();
	if (SHOW_NEWBIE_TIPS ~= "1") then
		SimpleTip_TweakTip(this.unit);
	end
end

---------------------------------------------------
-- GameTooltip SetDefaultAnchor() hook
function SimpleTip_GameTooltip_SetDefaultAnchor(tooltip, parent)
	if (SimpleTipParms.move) then
		if (SimpleTipParms.anchor == string.upper(SimpleTip_Pointer_Txt)) then
			tooltip:SetOwner(parent, "ANCHOR_CURSOR");
		else
			tooltip:SetOwner(parent, "ANCHOR_NONE");
			tooltip:SetPoint(SimpleTipParms.anchor, "UIParent", SimpleTipParms.anchor, SimpleTipParms.x, SimpleTipParms.y);
		end
	else
		SimpleTip_Old_GameTooltip_SetDefaultAnchor(tooltip, parent);
	end
end

---------------------------------------------------
-- dump message into chat window
function SimpleTip_ChatMsg(msg)
	if (msg) then
		-- tags
		local white = "<white>";
		local grey = "<grey>";
		local yellow = "<yellow>";
		-- syntax highlighting for help
		msg = string.gsub(msg, "/", white.."/");
		msg = string.gsub(msg, "{", yellow.."{"..grey);
		msg = string.gsub(msg, "}", yellow.."}"..grey);
		msg = string.gsub(msg, "|", yellow.."||"..grey);
		-- go to yellow at the start by default
		msg = yellow .. msg;
		-- switch out color tags for actual codes
		msg = string.gsub(msg, white, "|cffffffff");
		msg = string.gsub(msg, grey, "|ccccccccc");
		msg = string.gsub(msg, yellow, "|cffffd100");
		-- add message to chat frame
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end
end

---------------------------------------------------
-- check an array for a given value
function contains(t, item)
	for key, value	in t do
		if (item == value) then
			return true;
		end
	end
	return false;
end

---------------------------------------------------
-- handler for /simpletip commands
function SimpleTip_SlashHandler(msg)
	local OffsetX = {TOPLEFT=10, TOP=0, TOPRIGHT=-10,
			LEFT=10, CENTER=0, RIGHT=-10,
			BOTTOMLEFT=10, BOTTOM=0, BOTTOMRIGHT=10};
	local OffsetY = {TOPLEFT=-10, TOP=-10, TOPRIGHT=-10,
			LEFT=0, CENTER=0, RIGHT=0,
			BOTTOMLEFT=20, BOTTOM=20, BOTTOMRIGHT=20};
	local argv = {};
	for arg in string.gfind(string.lower(msg), '[%a%d%-%.]+') do
		table.insert(argv, arg);
	end

	-- if an anchor point is given as the command, we'll accept that :)
	if (contains(SimpleTip_Pos_Anchor, argv[1])) then
		argv[2] = argv[1];
		argv[1] = SimpleTip_Cmd_MoveTo[1];
	end

	if (contains(SimpleTip_Cmd_About, argv[1])) then -- "/simpletip about"
		SimpleTip_ChatMsg(SimpleTip_Credits1_Txt);
		SimpleTip_ChatMsg(SimpleTip_Credits2_Txt);
		SimpleTip_ChatMsg(SimpleTip_Credits3_Txt);
		SimpleTip_ChatMsg(SimpleTip_Credits4_Txt);		
		SimpleTip_ChatMsg(SimpleTip_Credits5_Txt);


	elseif (contains(SimpleTip_Cmd_NoMove, argv[1])) then -- "/simpletip nomove"
		SimpleTipParms.move = false;
		SimpleTipParms.anchor = "CENTER";
		SimpleTipParms.x = 0;
		SimpleTipParms.y = 0;
		SimpleTip_ChatMsg(SimpleTip_NoMove_Txt);

	elseif (contains(SimpleTip_Cmd_MoveTo, argv[1])) then -- "/simpletip moveto ..."
		-- relocate tooltip to anchor points
		if (contains(SimpleTip_Pos_Anchor, argv[2])) then
			SimpleTipParms.move = true;
			SimpleTipParms.anchor = string.upper(argv[2]);
			SimpleTipParms.x = OffsetX[SimpleTipParms.anchor];
			SimpleTipParms.y = OffsetY[SimpleTipParms.anchor];
			SimpleTip_ChatMsg(string.format(SimpleTip_MoveTo_Txt, string.lower(SimpleTipParms.anchor)));
			SimpleTip_ChatMsg(string.format(SimpleTip_Offset_Txt, SimpleTipParms.x, SimpleTipParms.y));
		-- relocate tooltip to mouse
		elseif (contains(SimpleTip_Pos_Pointer, argv[2])) then
			SimpleTipParms.move = true;
			SimpleTipParms.anchor = string.upper(SimpleTip_Pointer_Txt);
			SimpleTipParms.x = 0;
			SimpleTipParms.y = 0;
			SimpleTip_ChatMsg(string.format(SimpleTip_MoveTo_Txt, string.lower(SimpleTipParms.anchor)));
		-- display movement help
		else
			SimpleTip_ChatMsg(SimpleTip_MoveToHelp_Txt);
			SimpleTip_ChatMsg(SimpleTip_NoMoveHelp_Txt);
		end

	elseif (contains(SimpleTip_Cmd_Offset, argv[1])) then -- "/simpletip offset"
		if (SimpleTipParms.anchor ~= SimpleTip_Pos_Mouse) then
			-- set tooltip x,y offset
			local x=tonumber(argv[2]);
			local y=tonumber(argv[3]);
			if (x and y) then
				SimpleTipParms.x = x;
				SimpleTipParms.y = y;
				SimpleTip_ChatMsg(string.format(SimpleTip_Offset_Txt, SimpleTipParms.x, SimpleTipParms.y));
			else -- display offset help
				SimpleTip_ChatMsg(SimpleTip_OffsetHelp_Txt);
				SimpleTip_ChatMsg(SimpleTip_OffsetHelp2_Txt);
			end
		else -- display mouseoffset message
			SimpleTip_ChatMsg(SimpleTip_PointerOffset_Txt);
		end

	elseif (contains(SimpleTip_Cmd_Status, argv[1])) then -- "/simpletip status"
		if (SimpleTipParms.move) then
			SimpleTip_ChatMsg(string.format(SimpleTip_MoveTo_Txt, string.lower(SimpleTipParms.anchor)));
			SimpleTip_ChatMsg(string.format(SimpleTip_Offset_Txt, SimpleTipParms.x, SimpleTipParms.y));
		else
			SimpleTip_ChatMsg(SimpleTip_NoMove_Txt);
		end

	elseif (contains(SimpleTip_Cmd_Help, argv[1])) then -- "/simpletip help"
		SimpleTip_ChatMsg(SimpleTip_Help_Txt);
		SimpleTip_ChatMsg(SimpleTip_MoveToHelp_Txt);
		SimpleTip_ChatMsg(SimpleTip_NoMoveHelp_Txt);
		SimpleTip_ChatMsg(SimpleTip_OffsetHelp_Txt);
		SimpleTip_ChatMsg(SimpleTip_OffsetHelp2_Txt);

	elseif(contains(SimpleTip_Cmd_PvP, argv[1])) then
		if(argv[2]) then
			if (argv[2] == "show") then 
				SimpleTipParms.PvP = true;
			elseif (argv[2] == "hide") then
				SimpleTipParms.PvP = false;
			else
				SimpleTip_ChatMsg(SimpleTip_PvP_Help);
			end
		end
		if(SimpleTipParms.PvP) then 
			SimpleTip_ChatMsg(string.format(SimpleTip_PvP_Status, "Showing"));
		else
			SimpleTip_ChatMsg(string.format(SimpleTip_PvP_Status, "Hiding"));
		end
						
	else -- "/simpletip help" (or anything else)
		SimpleTip_ChatMsg(SimpleTip_Help_Txt);
	end
end

---------------------------------------------------
-- init stuff
function SimpleTip_OnLoad()
ThisRealmName = GetCVar("realmName");
if( ThisRealmName == "Arthas" ) then
	PropsCoderTooltips = {
		["Dakken"] = "Headmaster";
		["Zris"] = "Ascendant Evincar";
	};
elseif( ThisRealmName == "Lightning's Blade" ) then
	PropsCoderTooltips = {
		["Dakkan"] = "Descendant Taskmaster";
		["Zeeg"] = "zeeg pwns hard.";
	};
elseif( ThisRealmName == "Wildhammer" ) then
	PropsCoderTooltips = {
		["Archess"] = "Creator of Ultimate UI";
		["Archiess"] = "Warlock Headmaster";
		["Pwnataur"] = "My name is so original...";
		["Looloo"] = "Don\'t get any funny ideas "..UnitName("Player").."...";
		["Callindra"] = "Celestial of Atonement";
		["Cyno"] = "Nice hair...";
		["Chronicc"] = "BAM!";
		["Hosebeast"] = "Rogues do it from behind";
		["Conway"] = "OMG STFU CONWAY";
		["Laced"] = "           ... peanut butter...";
		["Lyon"] = "Rogues do it from behind";
		["Rorix"] = "I\'m holy spec LOL";
		["Hinatta"] = "If you see me, you're already dead.";
		["Borealis"] = "This... is... my... BOOMSTICK!";
		["Sillie"] = "Inspect me baby, one more time";
	};
elseif( ThisRealmName == "Nathrezim" ) then
	PropsCoderTooltips = {
		["Dakkan"] = "Deathstalker Overlord";
		["Arch"] = "Hey "..UnitName("Player").."!";
		["Exodius"] = "Elite Horde Champion";
		["Archen"] = "Mage Headmaster";
		["Archera"] = "This... is... my... BOOMSTICK!!!";
		["Nightcrawlor"] = "For the End Of The World spell,\n press ctrl-alt-delete.";
		["Aparition"] = "You can't kill me, I\'m already dead.";
		["Kilah"] = "nice pull... ROFL";
		["Lucrend"] = "I have bad breathren...";
		["Canarn"] = "I\'m a Canadian Treasure.";
		["Corleone"] = "I wont roll on any hunter drops LOL";
		["Corlepwn"] = "If you see this, you're dead.";
	};
elseif( ThisRealmName == "Mal'Ganis" ) then
	PropsCoderTooltips = {
		["Zariz"] = "Rogues do it from Behind";
	};
elseif( ThisRealmName == "Medivh" ) then
	PropsCoderTooltips = {
		["Wizbang"] = "Devious Degenerate, Defender of the Devil";
	};
elseif( ThisRealmName == "Destromath" ) then
	PropsCoderTooltips = {
		["Alliyah"] = "High Priestess of the Alliance";
		["Brix"] = "Queen of Stealth";
	};
elseif( ThisRealmName == "Khaz'goroth" ) then
	PropsCoderTooltips = {
		["Nightslayer"] = "Member of the Demonhunters";
	};
elseif( ThisRealmName == "Chromaggus" ) then
	PropsCoderTooltips = {
		["Chillakilla"] = "The Dark Master";
		["Mindrot"] = "Son of Cenarius";
		["Whispy"] = "worst. player. ever.";
		["Jolin"] = "MASTER FARMER";
		["Mageyalook"] = "STOP LOOKING LOL";
		["Ilovelepards"] = "Master of the Hunter";
		["Kutter"] = "I cut...";
		["Jezzy"] = "HOTTIE ALERT!";
		["Nathen"] = "Creator of Ultimate UI";
		["Halcazod"] = "If you see me, you're already dead.";
		["Deadzone"] = "Beg for mercy, and maybe I will kill you fast...";
		["Dakkon"] = "LFG! - BAMM INVITES FLY WHOAAA hehehehaha";
		["Dakken"] = "Creator of Ultimate UI";
		["Raxle"] = "Evening, bitches.";
		["Hatchet"] = "Tinkerbell, the Fairy Princess";
		["Xenobia"] = "Y OU L OSE";
		["Yulia"] = "OK LISTEN THE FUCK UP!";
		["Sinathus"] = "COOKIES?";
		["Fast"] = "PEW PEW LAZERS";
		["Belmai"] = "\"Gramps\"";
		["Archfiend"] = "best healer evur";
		["Comegetsome"] = "CUM GET SOME";
		["Sik"] = "Rogues do it from behind.";
		["Smokinggun"] = "BAM! *dies*";
		["Cythe"] = "nathen is a better rogue than me!";
		["Drabus"] = "If you see me, you\'re already dead.";
		["Slichter"] = "wtf does my name mean anyways...";
		["Rokoh"] = "Gangasta druid.";
		["Realkillah"] = "Owes nathen 80g lol";
		["Stryke"] = "In and out...";
		["Crazyska"] = "Chicken Nuggets anyone?";
		["Pet"] = "I love "..UnitName("Player").."...";
	};
elseif( ThisRealmName == "Smolderthorn" ) then
	PropsCoderTooltips = {
		["Blaen"] = "Lord of Nozdormu";
	};
elseif( ThisRealmName == "Cenarius" ) then
	PropsCoderTooltips = {
		["Nuurelin"] = "Queen of Azeroth";
	};
else
		PropsCoderTooltips = { };
end

PropsTooltips = { };

	SimpleTip_Old_GameTooltip_OnEvent = GameTooltip_OnEvent;
	GameTooltip_OnEvent = SimpleTip_GameTooltip_OnEvent;
	
	SimpleTip_Old_UnitFrame_OnEnter = UnitFrame_OnEnter;
	UnitFrame_OnEnter = SimpleTip_UnitFrame_OnEnter;

	SimpleTip_Old_GameTooltip_SetDefaultAnchor = GameTooltip_SetDefaultAnchor;
	GameTooltip_SetDefaultAnchor = SimpleTip_GameTooltip_SetDefaultAnchor;

	SlashCmdList["SIMPLETIPCOMMAND"] = SimpleTip_SlashHandler;
	SLASH_SIMPLETIPCOMMAND1 = "/simpletip";
	SLASH_SIMPLETIPCOMMAND2 = "/stip";
	
	this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");

	-- SimpleTip_ChatMsg(SimpleTip_Load_Txt);
	if(SimpleTipParms.PvP == nil) then SimpleTipParms.PvP = true end;
end
