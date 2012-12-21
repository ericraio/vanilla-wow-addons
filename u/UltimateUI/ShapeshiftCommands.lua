--[[
	This is a simple text file to allow players to change stance
	via the chat. 

	By Alexander Brazie	
  ]]

UltimateUI_ShapeshiftList = {
	-- Stances
	["Battle Stance"] = 1;
	["Defensive Stance"] = 2;
	["Beserker Stance"] = 3;

	-- Rogue Stealth
	["Stealth"] = 1;

	-- Shapeshifts
	["Bear Form"] = 1;
	["Water Form"] = 2;
	["Cat Form"] = 3;
	["Travel Form"] = 4;

	-- Aliases

	-- Stances
	["battle"] = 1;
	["btl"] = 1;
	["defensive"] = 2;
	["def"] = 2;
	["beserk"] = 3;
	["bzrk"] = 3;

	-- Rogue Stealth
	["stl"] = 1;

	-- Shapeshifts
	["bear"] = 1;
	["seal"] = 2;
	["cat"] = 3;
	["travel"] = 4;
};

UltimateUI_ShapeshiftList_ByClass = {
	
	["Druid"] = {
		-- Shapeshifts
		["bear form"] = 1,
		["water form"] = 2,
		["cat form"] = 3,
		["travel form"] = 4,

		-- Aliases

		["bear"] = 1,
		["seal"] = 2,
		["cat"] = 3,
		["travel"] = 4,

		["tank"] = 1,
		["aqua"] = 2,
		["dps"] = 3;
	},
	
	["Rogue"] = {
		-- Rogue Stealth
		["stealth"] = 1,
	
		-- Aliases

		["stl"] = 1;
	},
	
	["Warrior"] = {
		-- Stances
		["battle stance"] = 1,
		["defensive stance"] = 2,
		["beserker stance"] = 3,

		-- Aliases
	
		["battle"] = 1,
		["btl"] = 1,
		["defensive"] = 2,
		["def"] = 2,
		["beserk"] = 3,
		["bzrk"] = 3;
	}
	
};


function ShapeshiftByNumber(id) 
	CastShapeshiftForm(id);
end

function ShapeshiftByName(name)
	local list = UltimateUI_ShapeshiftList_ByClass[UnitClass("player")];
	
	if ( not list ) then
		return false;
	end
	
	if ( not name ) then
		return false;
	end
	local text = string.lower(name);
	if ( not text ) then
		return false;
	end
	
	for k,v in list do
		if (text == v) then
			ShapeshiftByNumber(v);
			return true;
		end
	end
	for k,v in list do
		if (string.find(text,v) ~= nil) then
			ShapeshiftByNumber(v);
			return true;
		end
	end
	return false;
end

function ShapeshiftByChat(text)
	local shapeshiftId = tonumber(text);
	if ( shapeshiftId ) then
		ShapeshiftByNumber(text); 
	else
		ShapeshiftByName(text);
	end
	
end	

function ShapeshiftStealth()
	ShapeshiftByNumber(1);
end

function ShapeshiftCommands_Register()
	-- Register the chat bindings
	UltimateUI_RegisterChatCommand(
		"SSC_STANCE", 
		SHAPE_COMM1, 
		ShapeshiftByChat,
		SHAPE_COMM1_INFO,
		CSM_CHAINNONE
	);
	UltimateUI_RegisterChatCommand(
		"SSC_STEALTH", 
		SHAPE_COMM2, 
		ShapeshiftStealth,
		SHAPE_COMM2_INFO,
		CSM_CHAINNONE
	);
	UltimateUI_RegisterChatCommand(
		"SSC_SHAPESHIFT", 
		SHAPE_COMM3, 
		ShapeshiftByChat,
		SHAPE_COMM3_INFO,
		CSM_CHAINNONE
	);
		
end
