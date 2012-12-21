-- version
SMARTHEAL_CURRENT_VERSION = "1.26";

SmartHeal={};

SmartHeal.Events= {
			-- basic events
			"VARIABLES_LOADED",
			"PLAYER_LOGIN",

			-- alert competitive heal event
			"CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF",

			-- alert excessive heal event
			"SPELLCAST_START",
			"SPELLCAST_CHANNEL_UPDATE",

			-- resume attack events
			"PLAYER_ENTER_COMBAT",
			"PLAYER_LEAVE_COMBAT",
			"SPELLCAST_STOP",
			"SPELLCAST_FAILED",
			"SPELLCAST_INTERRUPTED",
			"SPELLCAST_CHANNEL_STOP",

		}

SmartHeal.updateInterval=1; -- 1 sec to update
SmartHeal.SpellIsCasting=false
SmartHeal.SpellIsChanneling=false
SmartHeal.timer=0;
SmartHeal.active=0;
SmartHeal.selfCast=nil;
SmartHeal.spellList={};
SmartHeal.playerClass='';
SmartHeal.InitializeSave=nil;
SmartHeal.Attacking=false;
SmartHeal.ResumeAttack=false;

-- default values
SmartHeal.default={}
SmartHeal.default['enable']=1;
SmartHeal.default['overheal']=120;
SmartHeal.default['override']=1;
SmartHeal.default['altselfcast']=false;
SmartHeal.default['autoselfcast']=1;
SmartHeal.default['alert']=1;
SmartHeal.default['excesshealalert']=1;
SmartHeal.default['excesshealalerttrigger']=100;
SmartHeal.default['RClickHotKeySelfCast']=false
SmartHeal.default['minimapbutton']={

		name= "SmartHeal";
		icon = "Interface\\Icons\\Spell_Holy_Renew",
		position = -45,
		drag = "CIRCLE",
		tooltip = "",
		enabled = 1

	}

	
-- stored variables
SmartHeal_Config={};
SmartHeal_DebugMsg={};

-- hook original use action function
local SMARTHEAL_ORIG_USEACTION;
