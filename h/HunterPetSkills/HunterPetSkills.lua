--[[

	HunterPetSkills: Search an in-game database to find where the pet
		skill and rank you need is located. Type << /petskills >> for
		a list of commands. copyright 2005 by Jake Bolton (ninmonkey) ninmonkeys@gmail.com
	
	Author: Jake Bolton (ninmonkey) email: ninmonkeys@gmail.com
		(if you have any problems, or features you want added, email me)
		
	Usage:
		Type << /sk >> or << /petskills >> or << /hunterpetskills >>
		for a list of commands
		
	Examples:
		see the "HunterPetSkills_readme.txt" for examples and more
		details on the mod usage

	LastUpdate: 6/28/2005 (this isn't that accurate :P )

	Thanks To:
		-John Ruben	(Tulas), for helping improve the pet skill
			descriptions, and ideas for the mod in general.

		-I started with base info from The Good Intentions Guild
		( http://www.goodintentionsguild.info ), then updated my
		database with current info from hunters (ie: tulas) You can
		view the guilds pet page at: http://www.goodintentionsguild.info/hunters.html

	Version 0.2.1 (not made yet)
		
		-(todo) see todo for a list of what to do (ie: focus amount)
		-(todo) find levels for (?) beasts
		-(todo) change error when bad input for /sk <skill> <rank> <zone>
			-if zone does not match, output zone not found
			-allow partial zone name match


	Version 0.2.0 (Current Version)
		-updated TOC to version 1500 for blizzard patch
		-added skill sprint
		-added skill dive
		-"skill" is optional, meaning you can type "/sk bite 1" or "/sk skill bite 1"
		-added ingame help to show sprint/dive are availible skills
		-updated readme
		-help output shows "skill" is optional by using brackets: "[skill]", as well as in the readme

	Version 0.1.3
		-updated for new blizz patch was 4216 for 1300

	Version 0.1.2:
		-updated interface number for blizzard's patch
		-colored help
		-cleaned up and shortened skill output
		-skill output is colored
		
	Version 0.1.1:
		-new command shortcut /sk (/hunterpetskills, /petskills, or /sk all work)
		-strings changed in bite, claw, and cower
	
	(for full changelog, view readme)

	todo:
		-append to skill description focus etc? Or a special command
			that lists all skills with the tooltips?
			
			-skill list to append:
				-bite: 35 focus, instant, 10 seconds cooldown,
					range 5 yards
				-claw: 25 focus, instant, 5 yard range
				-dash: 20 focus, instant, 30 seconds cooldown
				-dive: 20 focus, instant, 30 seconds cooldown
				-growl:15 focus, instant, 5 seconds cooldown,
					5 yard range

			-append who can learn what:

				-bite: cannot be learned by:
					-crabs, scorpids, or owls

				-claw: cannot be learned by:
					-bats, boars, crocolisks, gorillas,
						hyenas, spiders, tall striders,
						turtles, wind serpents, or
						wolves/worgs
				
				-cower: can be learned by all
				-growl: can be learned by all
				
				-dash: cannot be learned by:
					-bears, crabs, crocolisks, gorillas,
						raptors, scorpids, spiders,
						turtles, or any flying beast

				-dive: cannot be learned by:
					-any land-based beast

		-fix /sk <skill_name> <skill_rank>

		-pet families
			-petFamilyArray
				-1 = claw, 2 = bite, 3 = both
		-show which families can/cannot learn claw/bite/sprint/dive
			-possible search, else output families
				-example:
				-cat: skill1, skill2, skill3
				-turtle: skill1, skill2
				-raptor: skill1, skill2, skill3, skill4

		-if search without zone name, first do a search with current zone name,
			if no results, then search all zones (save user time and typing)

		-disable if not hunter
			-- set pet arrays to nil?
			-- don't register events?

			-- do anything else?

			
	notes:
		-ToQuit
		-- local playerClass = UnitClass("player"); -- mage, warrior, etc..
		
		-for pet stats
		-- curXP, nextXP = GetPetExperience();
		-- creatureFamily = UnitCreatureFamily(unit);
			-- returns creature family, eg: bear, cat, crab, etc...					

Coming soon:	
	-View pet families
	-View pet families that can only learn claw
	-View pet families that can only learn bite
	-View pet families that can learn all skills	


]]

-----------------------------------
-- variables
-----------------------------------

-- mod version
HUNTERPETSKILLS_MOD_VERSION = "0.2.0";
HUNTERPETSKILLS_MOD_NAME = "|cffffff00HunterPetSkills "..HUNTERPETSKILLS_MOD_VERSION.."|r";

-- console command list
HUNTERPETSKILLS_COMMANDS = { help="help", skill="skill" };

HUNTERPETSKILLS_COLOR = { zone="447cbf", help="447cbf", helpheader="099779" };

-- displayed at /sk help 	-- "HunterPetSkills Help:",
HUNTERPETSKILLS_HELP_TEXT = {
	HUNTERPETSKILLS_MOD_NAME.." Help:",
	HUNTERPETSKILLS_COMMANDS["help"]..": Shows this help file.",
	"["..HUNTERPETSKILLS_COMMANDS["skill"].."] <skill_name> <skill_rank> [<zone>]: Lists beasts that have <skill_name>(bite|claw|growl|cower|dash|dive) with rank <skill_rank>(0-8). Optionally can try to search a zone.",
};

-- skill arrays

-- bite: rank = description, pet level, locations {zone_name=beast_list,
--	zone_name2=beast_list2,..}



local HUNTERPETSKILLS_DATA_BITE = {
	[1] = {"Bite the enemy, causing 9 to 11 damage", 1, locations = {
		DunMorogh="Snow Tracker Wolf (5-7), Winter Wolf (6-8)",
		Durotar="Dreadmaw Crocolisk (9-11)",
		Mulgore="Prairie Wolf (5-6)",
		Teldrassil="Webwood Venomfang (7-8)"
	}},
	
	[2] = {"Bite the enemy, causing 16 to 18 damage", 8, locations = {
		Barrens="Echeyakee (16), Savannah Huntress(12-13), Savannah Prowler(14-15), Oasis Snapjaw (15-16)",
		DunMorogh="Starving Winter Wolf (8-9), Timber (10)",
		ElwynnForest="Mother Fang (10), Prowler (9-10)",
		LochModan="Forest Lurker (13-14), Loch Crocolisk (14-15)",
		Mulgore="Prairie Wolf Alpha (9-10)",
		RedridgeMountains="Tarantula (15-16)",
		Teldrassil="Giant Webwood Spider (10-11), Lady Sathrah (12), Webwood Silkspinner (8-9)",
		TirisfalGlades="Worg (10-11)",
		Westfall="Coyote Packleader (11-12)"
	}},
	
	[3] = {"Bite the enemy, causing 24 to 28 damage", 16, locations = {
		Ashenvale="Ghost Paw Runner (19-20)",
		Duskwood="Green Recluse (21)",
		HillsbradFoothills="Forest Moss Creeper (20-21)",
		LochModan="Wood Lurker (17-18)",
		Redridge="Greater Tarantula (19-20)",
		SilverpineForest="Bloodsnout Worg (16-17)",
		StonetalonMountains="Besseleth (21+)",
		WailingCaverns="Deviate Crocolisk (18+-19+)"	
	}},
	
	[4] = {"Bite the enemy, causing 31 to 37 damage", 24, locations = {
		Ashenvale="Ghostpaw Alpha (27-28)",
		BlackfathomDeep="Ghamoo-Ra(25+)",
		Duskwood="Black Mastiff (25-26), Black Ravager (24-25), Naraxis(27)",
		HillsbradFoothills="Giant Moss Creeper (24), Elder Moss Creeper (27), Snapjaw (30)",
		Wetlands="Giant Wetlands Crocolisk(25-26)"
	}},
	
	[5] = {"Bite the enemy, causing 40 to 48 damage", 32, locations = {
		ArathiHighlands="Giant Plains Creeper(35-36), Plains Creeper (32-33)",
		Badlands="Crag Coyote (35-36)",
		DustwallowMarsh="Darkfang Lurker (36-37), Drywallow Crocolisk (35-36), Mudrock Tortoise (36-37)",
		ThousandNeedles="Sparkleshell Snapper (34-35)"	
	}},
	
	[6] = {"Bite the enemy, causing 49 to 59 damage", 40, locations = {
		Felwood="Felpaw Wolf (47-48)",
		Feralas="Longtooth Runner (40-41), Snarler (42), Wolves (41, 47)",
		Hinterlands="Witherbark Broodguard (44-45)",
		SwampOfSorrows="Deathstrike Tarantula (40-41)"	
	}},
	
	[7] = {"Bite the enemy, causing 66 to 80 damage", 48, locations = {
		Felwood="Felpaw Ravager (51-52)",
		Hinterlands="Saltwater Snapjaw (49-50), Vilebranch Raiding Wolf (51+-52+)",
		Stormwind="Sewer Beast (50+)",
		WesternPlagueland="Diseased Wolf(53-54), Plague Lurker (54-55)"
	}},
	
	[8] = {"Bite the enemy, causing 81 to 99 damage", 56, locations = {
		BlackrockSpires="Bloodaxe Warg (56-57) - spawns near Halycon"
	}},

};

-- claw: rank = description, pet level, locations {zone_name=beast_list,
--	zone_name2=beast_list2,..}

local HUNTERPETSKILLS_DATA_CLAW = {
	[1] = {"Claw the enemy, causing 4 to 6 damage", 1, locations = {
		DunMorogh="Ice Claw Bear (7-8)",
		Durotar="Pygmy Surf Crawler (5-6), Scorpid Workers (3)",
		Teldrassil="Strigid Owl (5-6)"
	}},
	
	[2] = {"Claw the enemy, causing 8 to 12 damage", 8, locations = {
		Darkshore="Thistle Bear (11-12)",
		DunMorogh="Bjarn (12), Mangeclaw (11)",
		Durotar="Death Flayer (11), Encrusted Surf Crawler (9-10), Venomtail Scorpid (9-10)",
		ElwynnForest="Young Forest Bear (8-9)",
		SilverpineForest="Giant Grizzled Bear (12-13)",
		Teldrassil="Strigid Hunter (8-9)"
	}},
	
	[3] = {"Claw the enemy, causing 12 to 16 damage", 16, locations = {
		Ashenvale="Ashenvale Bear (21-22), Clattering Crawler (19-20)",
		Darkshore="Den Mother (19)",
		HillsbradFoothills="Gray Bear (21-22)",
		LochModan="Black Bear Patriarch (16-17), Ol' Sooty (20+)",
		Westfall="Shore Crawler (17-18)"	
	}},
	
	[4] = {"Claw the enemy, causing 16 to 22 damage", 24, locations = {
		Ashenvale="Elder Ashenvale Bear (25-26)",
		Desolace="Scorpashi Snapper (30-31)",
		ThousandNeedles="Scorpid Reaver(31-32)"
	}},
	
	[5] = {"Claw the enemy, causing 21 to 29 damage", 32, locations = {
		Desolace="Scorpashi Lasher (34-35)"
	}},
	
	[6] = {"Claw the enemy, causing 26 to 36 damage", 40, locations = {
		Feralas="Ironfur Bear (41-42)",
		SwampOfSorrows="Silt Crawler (40-41)",
		Tanaris="Scorpid Hunter (40-41)"
	}},
	
	[7] = {"Claw the enemy, causing 35 to 49 damage", 48, locations = {
		BurningSteppes="Deathlash Scorpid (54-55)",
		Felwood="Angerclaw Mauler (49-50), Ironbeak Hunter (50-51)",
		Feralas="Ironfur Patriarch (48-49)",
		Winterspring="Shardtooth Bear (53-55), Winterspring Owl (54-56)"
	}},
	
	[8] = {"Claw the enemy, causing 43 to 59 damage", 56, locations = {
		WesternPlaguelands="Diseased Grizzly (55-56)",
		Winterspring="Elder Shardtooth (57-58), Winterspring Screecher (57-59)"		
	}}
};

-- cower: rank = pet level, locations {zone_name=beast_list,
--	zone_name2=beast_list2,..}

local HUNTERPETSKILLS_DATA_COWER = {
	[1] = {5, locations = {
		Barrens="Elder Plainstrider (8-9), Fleeting Plainstrider (12-13)",
		Darkshore="Foreststrider Fledging (11-13), Moonstalker Runt (10-11)",
		DunMorogh="Juvenile Snow Leopard (5-6)",
		Durotar="Durotar Tiger (7-8)",
		Mulgore="Elder Plainstrider (8-9), Flatland Cougar (7-8), Mazzranache (9)",
		Teldrassil="Mangy Nightsaber (2), Nightsaber (5-6)",
		TirisfalGlades="Greater Duskbat (6-7)"
	}},
	
	[2] = {15, locations = {
		Barrens="Ornery Plainstrider (16-17), Savannah Patriarch (15-16)",
		Darkshore="Giant Foreststrider (17-19), Moonstalker Sire (17-18)",
		HillsbradFoothills="Starving Mountain Lion (23-24)",
		StonetalonMountains="Panther, Twilight Runner (23-24)"
	}},
	
	[3] = {25, locations = {
		ArathiHighlands="Highland Strider (30-31)",
		HillsbradFoothills="Feral Mountain Lion (27-28)",
		RazorfenKraul="Blind Hunter (32), Kraul Bat (30+-31+)",
		StranglethornVale="Stranglethorn Tiger (32-33), Young Stranglethorn Panther (30-31), Young Stranglethorn Tiger (30-31)",
		ThousandNeedles="Crag Stalker (25-26)"	
	}},
	
	[4] = {35, locations = {
		Badlands="Ridge Huntress (38-39), Ridge Stalker (36-37)"	
	}},
	
	[5] = {45, locations = {
		EasternPlaguelands="Noxious Plaguebat (54-56)",
		StranglethornVale="Jaguero Stalker (50)"
	}},
	
	[6] = {55, locations = {
		EasternPlaguelands="Monstrous Plaguebat (57-58)",
		Winterspring="Frostsaber Cub (55-56)"	
	}},
};


-- dash: rank = description, pet level, locations {zone_name=beast_list,
--	zone_name2=beast_list2,..}

local HUNTERPETSKILLS_DATA_DASH = {
	[1] = {"Increases movement speed by 40 for 15 seconds", 30,
		locations = {
		Badlands="Crag Coyote (36), Elder Crag Wolf (?)",
		Desolace="Magram Bonepaw (37-38)",
		StranglethornVale="Stranglethorn Tigers (32-33)",
		SwampOfSorrows="Swamp Jaguar (37)"
	}},

	[2] = {"Increases movement speed by 60 for 15 seconds", 40,
		locations = {
		Badlands="Broken Tooth (37), Ridge Stalker Patriarch (?)",
		BlastedLands="Ashmane Boar (48)",
		Feralas="Longtooth Runner (40-41)",
		Hinterlands="Old Cliff Jumper (42), Silvermane Stalker (48)",
		StranglethornVale="BhagTera (elite 43), Elder Shadowmaw Panther (41-43)",
		Tanaris="Blisterpaw Hyena (41-42), Starving Blisterpaw (42)"
	}},

	[3] = {"Increases movement speed by 80 for 15 seconds", 50,
		locations = {
		BlackrockSpires="Bloodaxe Worg (56-57)",
		BlastedLands="Grunter (50), Hyena Ravage (elite (?))",
		BlackrockSpires="Blackrock Worg (54-55)",
		Hinterlands="Vilebranch Raiding Wolf (50-51)",
		Winterspring="Frostsaber Huntress (58-59), Frostsaber Stalker (60), RakShiri (rare blue frostsaber (?))"
	}},
};



-- dive: rank = description, pet level, locations {zone_name=beast_list,
--	zone_name2=beast_list2,..}

local HUNTERPETSKILLS_DATA_DIVE = {
	[1] = {"Increases movement speed by 40 for 15 seconds", 30,
		locations = {
		ArathiHighlands="Mesa Buzzard (35), Young Mesa Buzzard (31)",
		RazorfenKraul="Razorfen Kraul Bat (31)",
		Desolace="Dread Flyer (36-37)"
	}},

	[2] = {"Increases movement speed by 60 for 15 seconds", 40,
		locations = {
		Felwood="Ironbeak Owls (48-49)",
		Feralas="Rogue Vale Screecher (46), Wind Serpent (44)",
		Tanaris="Roc (42-43)"
	}},

	[3] = {"Increases movement speed by 80 for 15 seconds", 50,
		locations = {
		Badlands="Zaricotl (55)",
		BlastedLands="Spiteflayer (elite 52)",
		EasternPlaguelands="Plaguebat (54)",
		Felwood="Ironbeak Hunter (51), Ironbeak Screecher (53)",
		Winterspring="Winterspring Owl (55), Winterspring Screecher (59)"
	}},
};


-- growl: rank = pet level, learned from (and requirements), cost to buy

local HUNTERPETSKILLS_DATA_GROWL = {
	[1] = { 1, learn="Innate knowledge", cost="free" },
	[2] = { 10, learn="Innate knowledge", cost="free" },
	[3] = { 20, learn="Learned fom Pet Trainers, requires level 20", cost="30sp" },
	[4] = { 30, learn="Learned fom Pet Trainers, requires level 30, Growl 3", cost="1gp" },
	[5] = { 40, learn="Learned fom Pet Trainers, requires level 40, Growl 4", cost="2gp" },
	[6] = { 50, learn="Learned fom Pet Trainers, requires level 50, Growl 5", cost="4gp 70sp" },
	[7] = { 60, learn="Learned fom Pet Trainers, requires level 60, Growl 6", cost="5gp 90sp" }
};

-- const strings
local HUNTERPETSKILLS_DESC_COWER = "Cower, causing no damage but lowering your threat, making the enemy less likey to attack you";
local HUNTERPETSKILLS_DESC_GROWL = "Taunt the target, increasing the likelihood the creature will focus atacks on you";

-----------------------------------
-- local functions
-----------------------------------

local function print_error(msg)
    DEFAULT_CHAT_FRAME:AddMessage(msg.." Type /petskills or /sk help for a list of commands.");
end

local function print_msg(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end

local function print_debug(msg)
	DEFAULT_CHAT_FRAME:AddMessage("Debug: "..msg);
end

local function HelpColor()

	-- version:	v0.2
	-- last update: 2005


	--== notes ==--
	-- changed: regex is now "^(.-):(.*)$" (using non-greedy mode for first capture)
		
	-- output colorized help (keeps help strings clean of color codes)
	
	-- if first line, either color, or leave plain
	-- all other lines, start with color blue, end before character ":"
	-- color start: |cff, color end: |r
	
	local index;
    local value;
    for index, value in HUNTERPETSKILLS_HELP_TEXT do
    	local sText;
    	
    	if(index == 1) then    	
			
			-- header			
    		sText = "|cff"..HUNTERPETSKILLS_COLOR["helpheader"]..value.."|r";
    		print_msg(sText);    		    		
    	else    	
    		
			--color normally    		
    		local sStart, sEnd, sCmd, sDesc = string.find(value, "^(.-):(.*)$");
    		sText = "|cff"..HUNTERPETSKILLS_COLOR["help"]..sCmd.."|r:"..sDesc;
    		if( (sCmd == nil) or (sDesc == nil) ) then
    			-- if error in search, print non-colored string
    			print_msg(value);
    		end    		
    		-- print colored string
    		print_msg(sText);
    	end
    end
end

-----------------------------------
-- local command line functions
-----------------------------------

local function HunterPetSkills_PrintSkillList(ZoneName, BeastList)
	--output skill list so print code only needs to be changed in one place
	
	-- in color print: print_msg("<"..ZoneName.."> "..BeastList);
	print_msg("|cff"..HUNTERPETSKILLS_COLOR["zone"].."<"..ZoneName..">|r "..BeastList);

end

local function HunterPetSkills_Skill(SkillName, SkillRank, SkillZone)
	
	-- Search for the skill, format:
	-- description, pet level, locations {zone_name=beast_list, zone_name2=beast_list2,..}
	
	local index;
	local value;
	local bFilter = false;
	
	-- if not nil
	if( (SkillRank == nil) or (SkillName == nil) ) then
	    print_error("Error: Skill Name and Rank required!");
	    return;
	end
	
	-- make SkillName case-insensitive for compare
	SkillName = string.lower(SkillName);
	-- convert rank to number	
	SkillRank = tonumber(SkillRank);
	
	-- output skill name, rank, and zone
	if( SkillZone and (SkillZone ~= "" )) then
		-- lower and print
		SkillZone = string.lower(SkillZone);		
		print_msg(string.format("Skill: %s (Rank %i) Zone: %s", SkillName, SkillRank, SkillZone));
		
		-- get ready for filter, remove spaces				
		bFilter = true;
		SkillZone = string.gsub(SkillZone, "%s+", "");
	else
		-- no zone given, print none
		print_msg(string.format("Skill: %s (Rank %i) Zone: All", SkillName, SkillRank));
	end	
	
	if( SkillName == "bite" ) then
		
		-- check if inbounds
		if( tonumber(SkillRank) <= table.getn(HUNTERPETSKILLS_DATA_BITE) ) then
								
			-- print desc, pet level
			print_msg("Description: "..HUNTERPETSKILLS_DATA_BITE[SkillRank][1]);
			print_msg("Requires pet level: "..HUNTERPETSKILLS_DATA_BITE[SkillRank][2]);
			
			-- print locations {zone_name=beast_list, zone_name2=beast_list2,..}
			local ZoneName;
	        local BeastList;
	        for ZoneName, BeastList in HUNTERPETSKILLS_DATA_BITE[SkillRank]["locations"] do
	        	
				-- if filter, else regular
				if(bFilter) then
	        		if(string.lower(ZoneName) == SkillZone) then
	        			-- filtering, so make sure it matches
						-- (SkillZone was string.lower()'ed above)

						-- print filtered zone and beast list
	            		HunterPetSkills_PrintSkillList(ZoneName, BeastList);
	        		end
	        	else
	            	-- no filter, print all zones
	            	HunterPetSkills_PrintSkillList(ZoneName, BeastList);
	            end
	            
	        end
			
		else
			print_error("Error, invalid rank!");
		end

	elseif( SkillName == "dash" ) then
	
		-- check if inbounds
		if( tonumber(SkillRank) <= table.getn(HUNTERPETSKILLS_DATA_DASH) ) then
			
			-- print desc, pet level
			print_msg("Description: "..HUNTERPETSKILLS_DATA_DASH[SkillRank][1]);
			print_msg("Requires Pet Level: "..HUNTERPETSKILLS_DATA_DASH[SkillRank][2]);
			
			-- print locations {zone_name=beast_list, zone_name2=beast_list2, ...}
			local ZoneName;
			local BeastList;
			
			-- for each zone, print beast list and color zone name
			for ZoneName, BeastList in HUNTERPETSKILLS_DATA_DASH[SkillRank]["locations"] do
				
				-- if filter, else regular
				if(bFilter) then
					if(string.lower(ZoneName) == SkillZone) then
						-- filtered, and made a match
						-- SkillZone was string.lower()'ed above

						HunterPetSkills_PrintSkillList(ZoneName, BeastList);
					end
				else
					-- no filter, print all zones
					HunterPetSkills_PrintSkillList(ZoneName, BeastList);
				end
			end
		else
			-- first if failed
			print_error("Error, invalid rank!");
		end

	elseif( SkillName == "dive" ) then
	
		-- check if inbounds
		if( tonumber(SkillRank) <= table.getn(HUNTERPETSKILLS_DATA_DIVE) ) then
			
			-- print desc, pet level
			print_msg("Description: "..HUNTERPETSKILLS_DATA_DIVE[SkillRank][1]);
			print_msg("Requires Pet Level: "..HUNTERPETSKILLS_DATA_DIVE[SkillRank][2]);
			
			-- print locations {zone_name=beast_list, zone_name2=beast_list2, ...}
			local ZoneName;
			local BeastList;
			
			-- for each zone, print beast list and color zone name
			for ZoneName, BeastList in HUNTERPETSKILLS_DATA_DIVE[SkillRank]["locations"] do
				
				-- if filter, else regular
				if(bFilter) then
					if(string.lower(ZoneName) == SkillZone) then
						-- filtered, and made a match
						-- SkillZone was string.lower()'ed above

						HunterPetSkills_PrintSkillList(ZoneName, BeastList);
					end
				else
					-- no filter, print all zones
					HunterPetSkills_PrintSkillList(ZoneName, BeastList);
				end
			end
		else
			-- first if failed
			print_error("Error, invalid rank!");
		end
	
	elseif( SkillName == "claw" ) then

		-- check if inbounds
		if( tonumber(SkillRank) <= table.getn(HUNTERPETSKILLS_DATA_CLAW) ) then
								
			-- print desc, pet level
			print_msg("Description: "..HUNTERPETSKILLS_DATA_CLAW[SkillRank][1]);
			print_msg("Requires pet level: "..HUNTERPETSKILLS_DATA_CLAW[SkillRank][2]);
			
			-- print locations {zone_name=beast_list, zone_name2=beast_list2,..}
			local ZoneName;
	        local BeastList;
	        for ZoneName, BeastList in HUNTERPETSKILLS_DATA_CLAW[SkillRank]["locations"] do

				-- if filter, else regular
				if(bFilter) then
	        		if(string.lower(ZoneName) == SkillZone) then
	        			-- filtering, so make sure it matches
						-- (SkillZone was string.lower()'ed above)

						-- print filtered zone and beast list
	            		HunterPetSkills_PrintSkillList(ZoneName, BeastList);
	        		end
	        	else
	            	-- no filter, print all zones
	            	HunterPetSkills_PrintSkillList(ZoneName, BeastList);
	            end

	        end
			
		else
			print_error("Error, invalid rank!");
		end
		
	elseif( SkillName == "cower" ) then
		-- cower: pet level, locations {zone_name=beast_list, zone_name2=beast_list2,..}
		
		-- check if inbounds
		if( tonumber(SkillRank) <= table.getn(HUNTERPETSKILLS_DATA_COWER) ) then
								
			-- print desc, pet level
			print_msg("Description: "..HUNTERPETSKILLS_DESC_COWER);
			print_msg("Requires pet level: "..HUNTERPETSKILLS_DATA_COWER[SkillRank][1]);
			
			-- print locations {zone_name=beast_list, zone_name2=beast_list2,..}
			local ZoneName;
	        local BeastList;
	        for ZoneName, BeastList in HUNTERPETSKILLS_DATA_COWER[SkillRank]["locations"] do
	        
				-- if filter, else regular
				if(bFilter) then
	        		if(string.lower(ZoneName) == SkillZone) then
	        			-- filtering, so make sure it matches
						-- (SkillZone was string.lower()'ed above)

						-- print filtered zone and beast list
	            		HunterPetSkills_PrintSkillList(ZoneName, BeastList);
	        		end
	        	else
	        		-- no filter, print all zones
	            	HunterPetSkills_PrintSkillList(ZoneName, BeastList);
	            end	        
	        end
			
		else
			print_error("Error, invalid rank!");
		end
		
	elseif( SkillName == "growl" ) then
		-- growl: pet level, learned from (and requires), cost
		
		-- check if inbounds
		if( tonumber(SkillRank) <= table.getn(HUNTERPETSKILLS_DATA_GROWL) ) then
								
			-- print desc, pet level
			print_msg("Description: "..HUNTERPETSKILLS_DESC_GROWL);
			print_msg("Requires pet level: "..HUNTERPETSKILLS_DATA_GROWL[SkillRank][1]);
			
			-- print learned from, requires rank X, cost
			print_msg("Trained: "..HUNTERPETSKILLS_DATA_GROWL[SkillRank]["learn"]);
			print_msg("Cost: "..HUNTERPETSKILLS_DATA_GROWL[SkillRank]["cost"]);
			
		else
			print_error("Error, invalid rank!");
		end
		
	else
		-- invalid skill name
		print_error("Error: Invalid skill name!");
	end
	
end


-----------------------------------
-- slash commands
-----------------------------------

function HunterPetSkills_SlashCommandHandler(msg)

	if( msg ) then
		local command = string.lower(msg);

		if( command == "" or command == HUNTERPETSKILLS_COMMANDS["help"] ) then

  	        -- print out help
			HelpColor();

--[[
		-- old way that failed
	    	elseif( string.find(command, "^growl ") ) then
		    	-- find a skill name not prefixed by skill
		    	local sStart, sEnd, sRank, sZone = string.find(command,
				 "^growl%s+(%d+)%s*([%a%d%s%p]*)%s*$");
		    	HunterPetSkills_Skill("growl", sRank, sZone);
]]

		-- growl
		elseif( string.find(command, "^growl%s+(%d+)%s*([%a%d%s%p]*)%s*$") ) then
			-- found growl without "skill" in the command
			local sStart, sEnd, sRank, sZone = string.find(command,
				"^growl%s+(%d+)%s*([%a%d%s%p]*)%s*$");
			HunterPetSkills_Skill("growl", sRank, sZone);

		-- claw
		elseif( string.find(command, "^claw%s+(%d+)%s*([%a%d%s%p]*)%s*$") ) then
			-- found claw without "skill" in the command
			local sStart, sEnd, sRank, sZone = string.find(command,
				"^claw%s+(%d+)%s*([%a%d%s%p]*)%s*$");
			HunterPetSkills_Skill("claw", sRank, sZone);
		
		-- bite
		elseif( string.find(command, "^bite%s+(%d+)%s*([%a%d%s%p]*)%s*$") ) then
			-- found bite without "skill" in the command
			local sStart, sEnd, sRank, sZone = string.find(command,
				"^bite%s+(%d+)%s*([%a%d%s%p]*)%s*$");
			HunterPetSkills_Skill("bite", sRank, sZone);

		-- dash
		elseif( string.find(command, "^dash%s+(%d+)%s*([%a%d%s%p]*)%s*$") ) then
			-- found dash without "skill" in the command
			local sStart, sEnd, sRank, sZone = string.find(command,
				"^dash%s+(%d+)%s*([%a%d%s%p]*)%s*$");
			HunterPetSkills_Skill("dash", sRank, sZone);
		
		-- dive
		elseif( string.find(command, "^dive%s+(%d+)%s*([%a%d%s%p]*)%s*$") ) then
			-- found dive without "skill" in the command
			local sStart, sEnd, sRank, sZone = string.find(command,
				"^dive%s+(%d+)%s*([%a%d%s%p]*)%s*$");
			HunterPetSkills_Skill("dive", sRank, sZone);


		-- cower
		elseif( string.find(command, "^cower%s+(%d+)%s*([%a%d%s%p]*)%s*$") ) then
			-- found cower without "skill" in the command
			local sStart, sEnd, sRank, sZone = string.find(command,
				"^cower%s+(%d+)%s*([%a%d%s%p]*)%s*$");
			HunterPetSkills_Skill("cower", sRank, sZone);

		-- else they used "/sk skill <SkillName> <Rank> [<Zone>]
	    	elseif( string.find(command, "^"..HUNTERPETSKILLS_COMMANDS["skill"].." ") ) then

	        	-- search for a skill
				-- does %d equal [0-9], and does [%a%d] equal [%w] ?
	        		-- %a = all letters
	        		-- %d = all digits
	        		-- %p = all punctuation
	        		-- %s = all space
	        		-- %w = alphanumeric

	        	local sStart, sEnd, sSkill, sRank, sZone = string.find(command,
			        "^"..HUNTERPETSKILLS_COMMANDS["skill"].."%s+(%a+)%s+(%d+)%s*([%a%d%s%p]*)%s*$");

			-- print_debug(string.format("Skill: %s (Rank %s), [%s]", sSkill, sRank, sZone));
			HunterPetSkills_Skill(sSkill, sRank, sZone);

		else
		        -- invalid flag/command
		        print_error("CommandHandler: "..msg..": command not found!");
		end
	else
		-- no msg
		print_error("HunterPetSkills: CommandHandler: No command given!");
	end
end



------------------------------------
-- OnFoo functions
------------------------------------

function HunterPetSkills_OnEvent()
	if( event == "VARIABLES_LOADED" ) then
      
    	-- check if variables exist, if not create/set them     	
	end
end

function HunterPetSkills_OnLoad()
  
  -- Register events  
  this:RegisterEvent("VARIABLES_LOADED");
     
  -- Register slash command
  SLASH_HUNTERPETSKILLS1 = "/hunterpetskills";
  SLASH_HUNTERPETSKILLS2 = "/petskills";
  SLASH_HUNTERPETSKILLS3 = "/sk";
  
  SlashCmdList["HUNTERPETSKILLS"] = function(msg)
      HunterPetSkills_SlashCommandHandler(msg);
  end  

  -- loaded okay so show loaded text
  -- show on defualt chat window
  if( DEFAULT_CHAT_FRAME ) then
      DEFAULT_CHAT_FRAME:AddMessage("ninmonkey's "..HUNTERPETSKILLS_MOD_NAME.." loaded!");
  end

  -- show pop-up text like an error
  UIErrorsFrame:AddMessage("ninmonkey's "..HUNTERPETSKILLS_MOD_NAME.." loaded!", 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
  
end
