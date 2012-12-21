tinsert(UISpecialFrames, "CT_RA_ChangelogFrame");
CT_RACHANGES_HEIGHT = 500;
function CT_RAChanges_DisplayDialog()
	CT_RA_ChangelogFrame:SetHeight(CT_RACHANGES_HEIGHT+25);
	-- Initialize dialog
		-- Set title
	CT_RA_ChangelogFrameTitle:SetText(CT_RA_Changes["title"]);
	
		-- Show sections
	local section, totalHeight = 1, 0;
	while ( CT_RA_Changes["section" .. section] ) do
		local objSection = getglobal("CT_RA_ChangelogFrameScrollFrameSection" .. section);
		local part, partHeights = 1, 0;
		
			-- Show section
		objSection:Show();
		
			-- Set section title
		getglobal(objSection:GetName() .. "Title"):SetText(CT_RA_Changes["section" .. section]["title"]);
		
			-- Show parts
		while ( CT_RA_Changes["section" .. section][part] ) do
			local objPart = getglobal("CT_RA_ChangelogFrameScrollFrameSection" .. section .. "Part" .. part);
			
				-- Show part
			objPart:Show();
			
				-- Set part stuff
			getglobal(objPart:GetName() .. "Text"):SetText(CT_RA_Changes["section" .. section][part][2]);
			getglobal(objPart:GetName() .. "Text"):SetHeight(CT_RA_Changes["section" .. section][part][1]);
			objPart:SetHeight(CT_RA_Changes["section" .. section][part][1]);
			partHeights = partHeights + CT_RA_Changes["section" .. section][part][1];
			part = part + 1;
		end
		local addedHeight = ( CT_RA_Changes["section" .. section]["addedHeight"] or 0);
		objSection:SetHeight(partHeights+35+addedHeight);
		totalHeight = totalHeight + partHeights+35+addedHeight;
		section = section + 1;
	end
	CT_RA_ChangelogFrameScrollFrameSection:SetHeight(totalHeight);
	ShowUIPanel(CT_RA_ChangelogFrame);
	CT_RA_ChangelogFrameScrollFrame:UpdateScrollChildRect();
	local minVal, maxVal = CT_RA_ChangelogFrameScrollFrameScrollBar:GetMinMaxValues();
	if ( maxVal == 0 ) then
		CT_RA_ChangelogFrameScrollFrameScrollBar:Hide();
	else
		CT_RA_ChangelogFrameScrollFrameScrollBar:Show();
	end
	CT_RA_ChangelogFrameScrollFrame:SetHeight(CT_RACHANGES_HEIGHT-75);
end

-- Add slash command
CT_RA_RegisterSlashCmd("/ralog", "Shows the changelog for this version.", 15, "RALOG", CT_RAChanges_DisplayDialog, "/ralog");

CT_RA_Changes = {
	["title"] = "CT_RaidAssist v1.4!",
	
	["section1"] = {
		["title"] = "General",
		{ 45, "Added an in-game changelog which users can refer to to check the changes made in the latest version.  It will display the first time you load the new version, and later be accessible via /ralog." },
		{ 30, "Added a slash commands list, typing /rahelp will open a window detailing the various slash commands found in CT_RaidAssist." }
	},
	["section2"] = {
		["title"] = "Major Additions",
		["addedHeight"] = 10,
		{ 115, "Added the |bTarget Management|eb system. Usable via |b/tm|eb or by clicking Target Management from the minimap icon. The Target Management System allows you to assign up to 10 'Main Tanks' and issue them all a unique target with ease. When assigning a target to a tank they will be prompted to assist for your target, or if they are using CTRA 1.4+, a button will pop up making assisting easy. If a tank loses a target, it's easy to tell, and easy to reassign theirs." },
		{ 30, "Added Zul'Gurub boss mod section which includes alerts for the first 4 bosses." },
		{ 60, "Added |b/raitem|eb. Usable via |b/raitem ItemName|eb or |b/raitem [Item Link]|eb; allowing for you to type in or shift+click a link to see everyone in raid who has the item listed. (Very useful to do |b/raitem Aqual Quintessence|eb to see who came to MC prepared)." },
		{ 60, "Added |b/raresist|eb. |b/raresist|eb displays a Resist Check which allows you to see resists for members of your raid, very helpful to ensure no one forgot to throw their FR gear on right before Ragnaros or Vaelastrasz." },
		{ 70, "Added |b/razone|eb. |b/razone|eb tells you who in your raid is not in the same zone as you. Note:  In order to allow this command to work wihout sending a chat message, it shows sub-zones, so 'Fire Plume Ridge' instead of simply Un'Goro Crater." }
	},
	["section3"] = {
		["title"] = "Minor Additions",
		["addedHeight"] = 20,
		{ 20, "Added Ankhs and Symbols of Divinity to /rareg." },
		{ 20, "Added Ignite Mana to debuff curing as a preset sample." },
		{ 30, "Added a sound to |b/raready|eb, also added a |b/raid|eb note so it shows '<Player> has performed a ready check'." },
		{ 30, "Added key bindings for targeting MTT 1-5, in addition to assist keybinds." },
		{ 60, "Added the ability to ctrl+click a buff icon to recast targeted buff. Also made it so if you ctrl+click a debuff icon you can cure, it will cast the appropriate cure spell. Note: this is only for buff icons, not the colored frames." },
		{ 45, "Emergency Monitor has been improved to allow specific group settings. Accessible via the right click menu, you can now select which groups you would like EM to report for." }
	},
	["section4"] = {
		["title"] = "Major Changes",
		{ 85, "Buffs and Debuffs are no longer sent through the channel. This should reduce the number of messages sent to the channel by a large number, as well as increase functionality for those who don't use it. We're also hoping this fixes the crash bug some players experienced in Warsong Gulch. However while making this chage, the option to remove short duration debuffs had to be removed." },
		{ 45, "Mana Conserve has been changed to use actual hp values instead of percentages. Make sure you look at your mana conserve options and set them to be to your liking." }
	},
	["section5"] = {
		["title"] = "Minor Changes",
		["addedHeight"] = 15,
		{ 30, "Changed |b/raidassist broadcast|eb and |b/raidassist update|eb to |b/rabroadcast|eb and |b/raupdate|eb to make them a bit easier to use." },
		{ 75, "Dreamless Sleep potions and Mind Vision added a non-negative debuff to players that could be cured by CTRA's debuff curing system. We have removed both Dreamless Sleep and Mind vision from showing up as negative debuffs on players in your raid, so they should no longer be accidentally dispelled." },
		{ 60, "When inviting via |b/rakeyword|eb, if a person is in a group when they send a tell, you will automatically reply with 'You are currently grouped.' If the raid is full, you will reply with'The group is currently full.'" },
		{ 20, "|b/rareg|eb now sorts by classes on open, instead of by name." },
		{ 45, "With the addition of |b/raitem|eb, we've added an option to disallow raid queries that will allow you to block |b/raitem|eb, |b/rareg|eb, and |b/raresist|eb queries if you feel they are intrusive." },
		{ 45, "A change has been made for Mind Control spells that should make them easier to cure now. However since it now uses UnitIsFriend, debuff curing will check your target in a duel instead of yourself." }
	},
	["section6"] = {
		["title"] = "Bug Fixes",
		["addedHeight"] = 10,
		{ 90, "Resizing the Emergency Monitor was causing a very odd unexpected shift across the screen, and sometimes off screen for many users. Also opening some options windows or locking/unlocking frames via the minimap icon would cause a shift. Both of these have been fixed, and the Emergency Monitor should function more smoothly." },
		{ 45, "When the Emergency Monitor was up showing people not at full health, and you left raid, EM was not hiding as it should if the option was not checked, this has been fixed." },
		{ 30, "Buff Recasting has been fixed; previously it targeted the person but didn't recast the buff." },
		{ 30, "When someone dies, it no longer says to recast buffs if you have buff recasting enabled." },
		{ 60, "When a user comes back from LD and does a status request, their buffs/debuffs/etc. will be reset. This will fix the bug where players who went LD while debuffed would come back with those debuffs stuck showing." },
		{ 20, "Fixed an issue where boss mods would not save their on/off state." },
		{ 30, "Fixed a bug in the Vaelastrasz boss mod if the person reporting to raid got hit with Burning Adrenaline." }
	};

};
for k, v in CT_RA_Changes do
	if ( type(v) == "table" ) then
		for key, val in v do
			if ( type(val) == "table" ) then
				while ( string.find(val[2], "|b.-|eb") ) do
					CT_RA_Changes[k][key][2] = string.gsub(val[2], "^(.*)|b(.-)|eb(.*)$", "%1|c00FFD100%2|r%3");
				end
			end
		end
	end
end