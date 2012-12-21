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
	["title"] = "CT_RaidAssist v1.5!",
	
	["section1"] = {
		["title"] = "General",
		{ 60, "|gNOTE: You must exit out of the game to install CT_RaidAssist 1.5.  You also need the additional mod CT_RABossMods (from http://www.ctmod.net) if you wish to use Boss Notifications.|eg" },
		{ 90, "CT_RaidAssist is now using a new format.  CTRA now consists of two folders, |bCT_RaidAssist|eb and |bCT_RABossMods|eb.  This means that all BossMods are a separate addon now, and will have to be downloaded in addition to CTRA if you want those.  Overwriting your old directory will not cause problems.  CT_RABossMods is dependant on CT_RaidAssist." },
		{ 60, "Another big change is the way CTRA now replaces the Blizzard raid frames.  Suggested and recommended by the Blizzard Devs, the default raid UI will no longer load or run in the background while CTRA is installed.  This should increase overall performance." }
	},
	["section2"] = {
		["title"] = "Major Additions",
		["addedHeight"] = 30,
		{ 175, "Added |bPlayerTargets|eb.  Similar to MTT's but client side.  Everyone can set up to 10 PlayerTargets which will only be seen by you.  Player targets function slightly different than MTT's and more similar to the way the Blizzard frames work.  Setting a PlayerTarget will add a box showing their hp/mana just like a normal CTRA frame, however if you enable showing Players Target's Target, you will get an expanded box (like MTT's) that shows you the players target to the right of their CTRA window.\n\n|bThis means anyone (not just leaders) can set targets for people you choose.  To do so, simply go to the CTRaid tab of the social window and right click the player you wish to set as a PTT.|eb" },
		{ 45, "Added the option to |bSort Groups Horizontally|eb instead of vertically; this option can be found on the General Options page of the control panel." },
		{ 30, "Added an |bExpand Groups Upward|eb option which allows you to place the groups on the bottom of your screen and expand going up." },
		{ 45, "Added the ability to |bprearrange groups without being in raid|eb.  To load the virtual groups, select 'Virtual' from the group sort dropdown on the General Options page of the control panel." },
		{ 45, "Added an |bAuto-Set Loot Type|eb option to the Raid tab.  Setting your preferred loot type will automatically set loot to that type when you form the raid." },
		{ 30, "Added the ability for a raid leader to |bAuto-Promote|eb people. Simply right click their name on the Raid tab while you are raid leader." },
		{ 30, "Added a |bRemove Spacing|eb option to condense groups further when border is hidden." },
		{ 30, "Added '|bDead Tank notifications|eb'. Enabling this option will send an alert when a person set as MT dies." }
	},
	["section3"] = {
		["title"] = "Minor Additions",
		["addedHeight"] = 25,
		{ 75, "Added |b/ravote|eb.  |b/ravote|eb allows you to take a poll of your raid group.  Using the format |b/ravote question?|eb will send your question to the raid.  For example, /ravote Do you have your Onyxia cloak on?  Raid members will have the option to select yes or no, and results will be provided for yes, no, and  did not vote." },
		{ 45, "Added |b/raquiet|eb or |b/rasquelch|eb.  Raid leaders can use |b/raquiet|eb to disable all chat in the raid channel.  This option will time out after 5 minutes or until disabled by the raid leader." },
		{ 60, "Added a raid leader text color option.  This option changes the raid leaders name in raid chat to make their messages stand out more.  Enabled by default, you can select the color or disable this option from the Misc. Options page." },
		{ 30, "Added showing of 'No CTRA found' to |b/raver|eb for users who do not have CTRA." },
		{ 30, "Added the option to disable mana conserve via a checkbox for easier enabling/disabling for fights like Vaelastrasz." },
		{ 45, "Added an option to allow you to set the number of Main Tank Targets you wish to view to the General Options page of the control panel." },
		{ 30, "Added a notification on CTRA windows for who has a soulstone or ankh available after death." },
		{ 15, "Added the option for Shadow of Ebonroc to send to /rs." }
	},
	["section4"] = {
		["title"] = "Changes & Updates",
		["addedHeight"] = 15,
		{ 45, "Changed the look of the Resurrection Monitor.  The text was changed a bit and the 'No Current Resurrections' line was removed." },
		{ 30, "Updated Hakkar boss mod to have a 45 second timer since it was changed." },
		{ 30, "Improved checking on mana conserve; it should function much more smoothly now." },
		{ 20, "Improved behavior of Resurrection Monitor." },
		{ 20, "Improved Chromaggus boss mod." },
		{ 20, "Changed MTT targets to reflect friendly or hostile colors." }
	},
	["section5"] = {
		["title"] = "Fixes",
		{ 30, "Fixed a typo where mana conserve on percent value said setting it to 0 turned it off; now reads setting it to 100% will disable it." },
		{ 20, "Fixed a translation in the French version for druid buffs." },
		{ 30, "Fixed a bug with RA Option Sets.  When you logged on it would show 'unsaved'." },
		{ 20, "Fixed a bug with CT_RATarget functions." },
		{ 30, "Fixed an uncommon bug some users experienced with TM not showing targets red which had more than one MT targeting them." },
		{ 30, "Fixed a bug with mana not regenning on MTT's unless hp was also down." },
		{ 30, "Fixed a bug where |b/raready|eb would show 'Everybody is ready' after listing people who are not ready or afk." },
		{ 30, "Fixed the scrollbar on |b/raresist|eb from covering arcane resist." },
		{ 30, "Fixed a bug with MTT's not showing up if you went ld or joined a raid after they were set." },
		{ 30, "Fixed up various translations for French and German versions of the game." }
	}
};
for k, v in CT_RA_Changes do
	if ( type(v) == "table" ) then
		for key, val in v do
			if ( type(val) == "table" ) then
				while ( string.find(val[2], "|[bg].-|e[bg]") ) do
					CT_RA_Changes[k][key][2] = string.gsub(val[2], "^(.*)|b(.-)|eb(.*)$", "%1|c00FFD100%2|r%3");
					CT_RA_Changes[k][key][2] = string.gsub(CT_RA_Changes[k][key][2], "^(.*)|g(.-)|eg(.*)$", "%1|c00FF0000%2|r%3");
				end
			end
		end
	end
end