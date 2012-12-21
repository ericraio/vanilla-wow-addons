-- these are used for KeyBindings:
BINDING_HEADER_TRADEDISPENSER=tD_Loc.KeyBindings.header;
BINDING_NAME_TRADEDISPENSER1=tD_Loc.KeyBindings[1];
BINDING_NAME_TRADEDISPENSER2=tD_Loc.KeyBindings[2];
BINDING_NAME_TRADEDISPENSER3=tD_Loc.KeyBindings[3];
BINDING_NAME_TRADEDISPENSER4=tD_Loc.KeyBindings[4];


-- these blocks are used to initialize tradeDispenser. 
if (not tradeDispenserProfileColors) then
	tradeDispenserProfileColors	= {								-- used to colorize the select-profile-buttons
		[1]		= {		["r"] = 1,	["g"] = 1,	["b"] = 1,  	},		-- all classes = white
		[2] 	= {		["r"] = 0.5,["g"] = 0.5,["b"] = 1,		},		-- classes  = light blue
		[3] 	= {		["r"] = 0.5,["g"] = 0.5,["b"] = 1,		},
		[4] 	= {		["r"] = 0.5,["g"] = 0.5,["b"] = 1,		},
		[5] 	= {		["r"] = 0.5,["g"] = 0.5,["b"] = 1,		},
		[6] 	= {		["r"] = 0.5,["g"] = 0.5,["b"] = 1,		},
		[7] 	= {		["r"] = 0.5,["g"] = 0.5,["b"] = 1,		},
		[8] 	= {		["r"] = 0.5,["g"] = 0.5,["b"] = 1,		},
		[9] 	= {		["r"] = 0.5,["g"] = 0.5,["b"] = 1,		},
		[10] 	= {		["r"] = 1,	["g"] = 0.6,["b"] = 0,		},		-- groups = orange
		[11] 	= {		["r"] = 1,	["g"] = 0.6,["b"] = 0,		},
		[12] 	= {		["r"] = 1,	["g"] = 0.6,["b"] = 0,		},
	}
end

if (not tradeDispenserRackColor) then 
	tradeDispenserRackColor = {
		[1] =  {
			["text"] = "|cFF00FF00",
			["r"] = 0.65,		["g"]= 1,	["b"] = 0.65,
		},
		[2] = {
			["text"] = "|cFFFFFF33",
			["r"] = 1,		["g"]= 1,	["b"] = 0.33,
		},
		[3] = {
			["text"] = "|cFFFF1100",
			["r"] = 1,		["g"]= 0.7,	["b"] = 0.7,
		},
	}
end


if (not tradeDispenserChannelColors) then 
	tradeDispenserChannelColors = {
		[1] = {		["r"] = 1,  	["g"] = 1,		["b"]=1,		["text"]=tD_Loc.channel.say	},
		[2] = {		["r"] = 1,  	["g"] = 0,		["b"]=0,		["text"]=tD_Loc.channel.yell	},
		[3] = {		["r"] = 1,  	["g"] = 0.5,	["b"]=0,		["text"]=tD_Loc.channel.raid	},
		[4] = {		["r"] = 0.4, 	["g"] = 0.4,	["b"]=1,		["text"]=tD_Loc.channel.party	},
		[5] = {		["r"] = 0.1,  	["g"] = 1,		["b"]=0.1,		["text"]=tD_Loc.channel.guild	},
	}
end

tradeDispenser_MaxBroadcastLength = 30;		-- minutes



if (not tD_Temp) then
	tD_Temp = {}		-- this datafield is used to store all the temporary datas - they should be erased after relog / logout / reloadui
	tD_Temp.Slot = {
		[1]=nil, [2]=nil, [3]=nil, [4]=nil, [5]=nil, [6]=nil
	}
	tD_Temp.Scroll = {	}
	tD_Temp.Scroll.start = 1;
	tD_Temp.RegUser = { 
		[0] = { ["name"]="empty",  ["trades"]=0 }  
	};			
end


if (not tD_GlobalDatas) then 
	tD_GlobalDatas = {}		-- defines an empty datafield
	tD_CharDatas = {}
	tD_CharDatas.OSD={}	
end



function tradeDispenser_OnVariablesLoaded()
	local tD_Name=UnitName("player").." of "..GetRealmName();
	if (tD_Datas~=nil) then
		if (tD_Datas[tD_Name]~=nil) then
			tD_CharDatas = tD_Datas[tD_Name];
			tD_Datas[tD_Name]=nil;
		end
		if (tD_Datas.Verbose~=nil) then 
			tD_GlobalDatas.Verbose = tD_Datas.Verbose;
			tD_Datas.Verbose=nil;
		end
		if (tD_Datas.Bannlist~=nil) then 
			tD_GlobalDatas.Bannlist = tD_Datas.Bannlist;
			tD_Datas.Bannlist=nil;
		end
		if (tD_Datas.whisper~=nil) then 
			tD_GlobalDatas.whisper = tD_Datas.whisper;
			tD_Datas.whisper=nil;
		end
	end
	if (tD_GlobalDatas.dataVersion ~= configDataVersion) then tD_GlobalDatas.dataVersion=configDataVersion; end
	if (not tD_GlobalDatas.Verbose) then tD_GlobalDatas.Verbose=0 end
	if (not tD_GlobalDatas.Bannlist) then tD_GlobalDatas.Bannlist = { } end
	
	if (tD_CharDatas.profile and tD_CharDatas.profile[1] and tD_CharDatas.profile[1]["Charge"]) then
		local i, temp;
		temp = {}
		for i=1,12 do
			temp[i] = {
				["Charge"] = 0,
				[1] = {}, [2] = {},  [3]= {},  [4]={}, [5]={}, [6]={}
			}
		end	
		tD_CharDatas.profile = {
			[1] = tD_CharDatas.profile,
			[2] = temp,
			[3] = temp,
		}
	end
	
		
	if (tD_CharDatas.OSD.g==nil) then
		tD_CharDatas = {}			
		-- set DEFAULT settings
		
		tD_CharDatas.ChannelID=1;
		tD_CharDatas.OSD = {
			["scale"]		= 1,
			["alpha"]		= 1,
			["r"]			= 0,
			["g"]			= 0,
			["b"]			= 0,
			["isEnabled"]	= true,
			["border"]		= true,
			["horiz"]		= false,
			["locked"]		= false,
		};
		tD_CharDatas.TimelimitCheck=true;
		tD_CharDatas.Timelimit = 20;
		tD_CharDatas.BanlistActive=false;
		tD_CharDatas.Raid=true;
		tD_CharDatas.Guild=true;
		tD_CharDatas.Free4Guild=true;
		tD_CharDatas.AutoAccept=true;
		tD_CharDatas.ClientInfos=true;
		tD_CharDatas.LevelCheck=true;
		tD_CharDatas.LevelValue=55;
		tD_CharDatas.RegisterCheck=true;
		tD_CharDatas.RegisterValue=1;
		tD_CharDatas.broadcastSlice=math.floor(tradeDispenser_MaxBroadcastLength/2)*60;
		tD_CharDatas.Random=1;
		tD_CharDatas.ActualProfile=1;
		tD_CharDatas.profile = {};
		local i,j;
		for j=1,3 do
			tD_CharDatas.profile[j]={}
			for i=1,12 do
				tD_CharDatas.profile[j][i] = {
					["Charge"] = 0,
					[1] = {}, [2] = {},  [3]= {},  [4]={}, [5]={}, [6]={}
				}
			end			
		end
		
		tD_CharDatas.RndText = {
			[1] = tD_Loc.Broadcast[1],		[2] = tD_Loc.Broadcast[2],
			[3] = tD_Loc.Broadcast[3],		[4] = tD_Loc.Broadcast[4],
			[5] = tD_Loc.Broadcast[4],		[6] = tD_Loc.Broadcast[4],
			[7] = tD_Loc.Broadcast[4],		[8] = tD_Loc.Broadcast[4],
		};
	end
	--for users with Version 0.60 - 0.70
	if (not tD_CharDatas.TimelimitCheck or not tD_CharDatas.Timelimit) then
		tD_CharDatas.TimelimitCheck=false;
		tD_CharDatas.Timelimit = 20;
		tD_CharDatas.BanlistActive=false;
	end
	if (not tD_CharDatas.ActualRack) then tD_CharDatas.ActualRack=1 end
	
	tradeDispenserSettingsOSDscale:SetValue(tD_CharDatas.OSD.scale);
	tradeDispenserSettingsOSDCheck:SetChecked(tD_CharDatas.OSD.isEnabled);
	tradeDispenserSettingsOSDborder:SetChecked(tD_CharDatas.OSD.border);
	tradeDispenserSettingsOSDhoriz:SetChecked(tD_CharDatas.OSD.horiz);
	tradeDispenserSettingsRandom:SetValue(tD_CharDatas.Random);
	tD_CharDatas.OnBroadcastText=nil;
	
	tD_Temp.isEnabled = false;
	tradeDispenserUpdate();
	tradeDispenserSettings_OnUpdate();
	tradeDispenserOSD_OnUpdate();
	tradeDispenser_TradeControl_Update();
	tradeDispenser_EditBoxUpdate();		

	if (not tD_GlobalDatas.whisper) then
		tD_GlobalDatas.whisper={};
		local i;
		for i=1,11 do
			tD_GlobalDatas.whisper[i]=tD_Loc.whisper[i].default;
		end
	end
end
	