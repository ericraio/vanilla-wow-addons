--[[
  ****************************************************************
	Scrolling Combat Text 5.0
	Event Config File
	****************************************************************
	
	PLEASE NOTE:
		As of 4.1, There is now a new section at the bottom of this file.
		It contains a list of various chat events used by WoW. Please see
		the section before it for more details
		
	Description:
		This file is used to setup custom events for use in SCT. Most 
		of the old limitations have been removed, so you can now check
		for custom events on most chat log messages. You can now also
		perform captures on the text and display the data in a 
		customized format. for each event you must setup three required 
		settings. for captured events you must setup one required
		setting. All events can also have one optional setting:
			
			  name:		This is basically the text you want SCT to display 
						 		whenever the event occurs. for captured data you
						 		use *n where n is the index of the captured data in 
						 		the order of the search. (see examples) 
						 		
			search:		This is the EXACT text SCT will search for to know
								when to display the event. You will most likley
								need to watch your combat chat log in game and see
								what text is displayed when the buff/talent/proc
								goes off. You can now use normal LUA expressions 
								to capture data. The order of these expressions is 
								what should be used in determining how to display 
								them in the name field. (see examples)
								
		argcount: 	this is required when you are wanting to use 
								captured data. This tells SCT how many captured 
								fields you want to replace in the name field. Keeping 
								this accurate helps improve SCT performance. If its 
								lower then you need some captured fields will not be 
								displayed, if its higher it just wastes loops 
								looking for data that is not there. 

							
			r, g, b:	These are the color settings used to select the
								color you want the event to display in. r = red,
								g = green, b = blue. Some common colors:
								
								Red:  			r=256/256, 	g=0/256, 		b=0/256
								Green:			r=0/256, 		g=256/256, 	b=0/256
								Blue:				r=0/256, 		g=0/256, 		b=256/256
								Yellow:			r=256/256, 	g=256/256, 	b=0/256
								Magenta:		r=256/256, 	g=0/256, 		b=256/256
								Cyan:				r=0/256, 		g=256/256, 	b=256/256
								
			iscrit:  	this will make the event appear as a crit event, 
								so it will be sticky or large font. You only need
								to set this if you want it used. iscrit=1
								
			 ismsg:  	this will make the event appear as a message.
			 					You only need to set this if you want it used. ismsg=1
								
			 class:   This allows you to filter events by class. Put only 
			 					the classes you want to see the even here. They must 
			 					be in LUA table format. 
			 					
			 					Examples:
			 					
			 					Warrior only: 				class={"Warrior"}
			 					Warrior and Shaman:		class={"Warrior", "Shaman"}
			 					
		 anitype:		this allows you to specify the type of animation to
		 						use for an event.
		 						
		 						1 - Vertical
		 						2 - Rainbow
		 						3 - Horizontal
		 						4 - Angled Down
		 						
		 		sound:	(advanced users only)
		 						plays a sound built into WoW. Please see here for a
		 						list of values: http://www.wowwiki.com/API_PlaySound
		 						
		 						Examples:
		 						sound="TellMessage"
		 						sound="GnomeExploration"
		 						
		soundwave:	(advanced users only)
								plays a wave file in the path you choose. You can use
								in game ones if you know the path, or custom ones you
								put it in an addon folder.
								
								Examples:
								In game:			soundwave="Sound\\Spells\\ShaysBell.wav"
								Custom:				soundwave="Interface\\AddOns\\MyAddOn\\mysound.wav"
								
	Note:
		Make sure you increase the key count ([1], [2], etc...) for 
		each new event you add. Feel free to delete any of the already
		provided events if you know you will never need them or you
		dont want them to display. You may also place -- in front
		of any of them to comment them out.
		
	Problems:
		if the event you are wanting to add is not being displayed by
		SCT make sure you double check the search text. Any space,
		comma, or period out of place will cause it to fail.
	****************************************************************]]

local sct_Event_Config = {

-- To remove an event, simply add -- in front of the line.
-- Example : to remove "Windfury!" do :
-- [1] = {name="Windfury!", search="You gain Windfury", r=256/256, g=256/256, b=0/256},

[1] = {name="Clearcast!", search="You gain Clearcast", r=256/256, g=256/256, b=0/256},
[2] = {name="Flurry!", search="You gain Flurry", r=128/256, g=0/256, b=0/256},
[3] = {name="Lightning Shield!", search="You gain Lightning Shield", r=0/256, g=0/256, b=256/256},
[4] = {name="Nightfall!", search="You gain Shadow Trance", r=0/256, g=128/256, b=128/256},
[5] = {name="Overpower!", search="You attack. (.+) dodges.", r=256/256, g=256/256, b=0/256, iscrit=1, class={"Warrior"}},
[6] = {name="Overpower!", search="Your (.+) was dodged", r=256/256, g=256/256, b=0/256, iscrit=1, class={"Warrior"}},
[7] = {name="Enraged!", search="You gain Enrage", r=128/256, g=256/256, b=128/256, iscrit=1, class={"Warrior"}},
[8] = {name="Crusader!", search="You gain Holy Strength", r=128/256, g=128/256, b=256/256, iscrit=1},

--Captured data examples. Remove, change, or comment out the ones you don't want.

--Spam Stoppers
--[9] = {name="", search="Your Bloodthirst heals you", r=0/256, g=256/256, b=0/256, class={"Warrior"}},
--[10] = {name="", search="Your Vampiric Embrace", r=0/256, g=0/256, b=0/256, class={"Priest"}},

};


--[[
	****************************************************************
	This list of Wow Events are used for searching custom events. 
	They are only events that are not normally used by SCT. 
	By default they are commented out. To enable an event to be 
	searched by SCT, remove the "--" before the event, save, and 
	then reload/relog. if for some reason you do not see the event 
	you need here, you can find a full list of them here:
	http://www.wowwiki.com/Events_%28API%29
	
	To figure out what event a chat message is, set SCT_Event_Debug 
	to true. You will now get a chat message saying what event is 
	being fired for every event.
	****************************************************************]]	

local sct_Event_Debug = false;

local sct_Event_List = {

--self events
--"CHAT_MSG_COMBAT_SELF_MISSES",

--pet events
--"CHAT_MSG_COMBAT_PET_HITS",
--"CHAT_MSG_COMBAT_PET_MISSES",
--"CHAT_MSG_SPELL_PET_DAMAGE",
--"CHAT_MSG_SPELL_PET_BUFF",

--party events
--"CHAT_MSG_COMBAT_PARTY_HITS",
--"CHAT_MSG_COMBAT_PARTY_MISSES",
--"CHAT_MSG_SPELL_PARTY_DAMAGE",
--"CHAT_MSG_SPELL_PARTY_BUFF",

--realm events
--"CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS",
--"CHAT_MSG_COMBAT_FRIENDLYPLAYER_MISSES",
--"CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE",
--"CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF",

--mob events
--"CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS",
--"CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES",
--"CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS",
--"CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_MISSES",
--"CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE",
--"CHAT_MSG_SPELL_CREATURE_VS_PARTY_BUFF",
--"CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE",
--"CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF",

--damage shields
--"CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF",
--"CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS",

--spell auras
--"CHAT_MSG_SPELL_AURA_GONE_PARTY",
--"CHAT_MSG_SPELL_AURA_GONE_OTHER",
--"CHAT_MSG_SPELL_BREAK_AURA",

--item enchants
--"CHAT_MSG_SPELL_ITEM_ENCHANTMENTS",

--periodic effects
--"CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE",
--"CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE",
--"CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE",
--"CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS",

--deaths
--"CHAT_MSG_COMBAT_FRIENDLY_DEATH",
--"CHAT_MSG_COMBAT_HOSTILE_DEATH",

--experience
--"CHAT_MSG_COMBAT_XP_GAIN",

--trade skills
--"CHAT_MSG_SPELL_TRADESKILLS",

--monster emotes
--"CHAT_MSG_MONSTER_EMOTE",
--"CHAT_MSG_MONSTER_SAY",
--"CHAT_MSG_MONSTER_WHISPER",
--"CHAT_MSG_MONSTER_YELL",

--chat channels
--"CHAT_MSG_DND",
--"CHAT_MSG_EMOTE",
--"CHAT_MSG_GUILD",
--"CHAT_MSG_IGNORED",
--"CHAT_MSG_LOOT",
--"CHAT_MSG_OFFICER",
--"CHAT_MSG_PARTY",
--"CHAT_MSG_RAID",
--"CHAT_MSG_SAY",
--"CHAT_MSG_SYSTEM",
--"CHAT_MSG_TEXT_EMOTE",
--"CHAT_MSG_WHISPER",
--"CHAT_MSG_WHISPER_INFORM",
--"CHAT_MSG_YELL",

--battlegrounds
--"CHAT_MSG_BG_SYSTEM_ALLIANCE",
--"CHAT_MSG_BG_SYSTEM_HORDE",
--"CHAT_MSG_BG_SYSTEM_NEUTRAL",

--misc
--"CHAT_MSG_COMBAT_ERROR",
--"CHAT_MSG_COMBAT_MISC_INFO",
--"CHAT_MSG_SPELL_FAILED_LOCALPLAYER",
}

--Don't mess with these =)
SCT.EventConfig = sct_Event_Config;
SCT.EventDebug = sct_Event_Debug;
SCT.EventList = sct_Event_List;