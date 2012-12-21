CTA_MESSAGE					= "M";
CTA_GENERAL					= "I";
CTA_GROUP_UPDATE			= "G";
CTA_BLOCK					= "X";
CTA_SEARCH					= "S";

CTA_MESSAGE_COLOURS 		= {
	M = { r = 1,   b = 1,   g = 0.5 },
	I = { r = 1,   b = 0.5, g = 1   },
	G = { r = 0.5, b = 0.5, g = 1   },
	X = { r = 1,   b = 0.5, g = 0.5 },
	S = { r = 0.5, b = 1,   g = 0.5 }
};

CTA_Classes					= {
	init = function()
		if( UnitFactionGroup(CTA_PLAYER) == CTA_ALLIANCE ) then
			CTA_Classes[8] = "PALADIN";
		else
			CTA_Classes[8] = "SHAMAN";
		end			
	end
};

CTA_Classes[1] = "PRIEST";
CTA_Classes[2] = "MAGE";
CTA_Classes[3] = "WARLOCK";
CTA_Classes[4] = "DRUID";
CTA_Classes[5] = "HUNTER";
CTA_Classes[6] = "ROGUE";
CTA_Classes[7] = "WARRIOR";
CTA_Classes[8] = "PALADIN";

CTA_Classes[CTA_PRIEST] 	= { id=1, txMin=0.50, txMax=0.75, tyMin=0.25, tyMax=0.50 };
CTA_Classes[CTA_MAGE] 		= { id=2, txMin=0.25, txMax=0.50, tyMin=0.00, tyMax=0.25 };
CTA_Classes[CTA_WARLOCK] 	= { id=3, txMin=0.75, txMax=1.00, tyMin=0.25, tyMax=0.50 };
CTA_Classes[CTA_DRUID] 		= { id=4, txMin=0.75, txMax=1.00, tyMin=0.00, tyMax=0.25 };
CTA_Classes[CTA_HUNTER] 	= { id=5, txMin=0.00, txMax=0.25, tyMin=0.25, tyMax=0.50 };
CTA_Classes[CTA_ROGUE] 		= { id=6, txMin=0.50, txMax=0.75, tyMin=0.00, tyMax=0.25 };
CTA_Classes[CTA_WARRIOR] 	= { id=7, txMin=0.00, txMax=0.25, tyMin=0.00, tyMax=0.25 };
CTA_Classes[CTA_PALADIN] 	= { id=8, txMin=0.00, txMax=0.25, tyMin=0.50, tyMax=0.75 };
CTA_Classes[CTA_SHAMAN] 	= { id=8, txMin=0.25, txMax=0.50, tyMin=0.25, tyMax=0.50 };	

CTA_Classes["PRIEST"]	 	= { localName=CTA_PRIEST, 	id=1, txMin=0.50, txMax=0.75, tyMin=0.25, tyMax=0.50 };
CTA_Classes["MAGE"] 		= { localName=CTA_MAGE, 	id=2, txMin=0.25, txMax=0.50, tyMin=0.00, tyMax=0.25 };
CTA_Classes["WARLOCK"] 		= { localName=CTA_WARLOCK, 	id=3, txMin=0.75, txMax=1.00, tyMin=0.25, tyMax=0.50 };
CTA_Classes["DRUID"] 		= { localName=CTA_DRUID, 	id=4, txMin=0.75, txMax=1.00, tyMin=0.00, tyMax=0.25 };
CTA_Classes["HUNTER"] 		= { localName=CTA_HUNTER, 	id=5, txMin=0.00, txMax=0.25, tyMin=0.25, tyMax=0.50 };
CTA_Classes["ROGUE"] 		= { localName=CTA_ROGUE, 	id=6, txMin=0.50, txMax=0.75, tyMin=0.00, tyMax=0.25 };
CTA_Classes["WARRIOR"]	 	= { localName=CTA_WARRIOR, 	id=7, txMin=0.00, txMax=0.25, tyMin=0.00, tyMax=0.25 };
CTA_Classes["PALADIN"]	 	= { localName=CTA_PALADIN, 	id=8, txMin=0.00, txMax=0.25, tyMin=0.50, tyMax=0.75 };
CTA_Classes["SHAMAN"] 		= { localName=CTA_SHAMAN, 	id=8, txMin=0.25, txMax=0.50, tyMin=0.25, tyMax=0.50 };	


local trim;
local getOps;
local recursiveSearch; 
local cloneTable;

trim = function( s )
	if( not s ) then return nil; end
	return( string.gsub(s, "^%s*(.-)%s*$", "%1") or s );
end

getOps = function( source )
	local operatorFound = nil;
	local bracketCount = 0;
	local inQuote = 0;
	local pos = 0;
	
	local currentChar;
	local prevChar = "x";
	while( pos < string.len( source ) ) do
		currentChar = string.sub( source, pos, pos );
		if( ( currentChar == "+" or currentChar == "/" ) and bracketCount == 0 and inQuote == 0 ) then
			operatorFound = 1;
			break;
		elseif( currentChar == "(" ) then
			bracketCount = bracketCount + 1;
		elseif( currentChar == ")" ) then
			bracketCount = bracketCount - 1;
		elseif( currentChar == "\"" ) then
			inQuote = 1 - inQuote;
		else
			if( prevChar == " " and bracketCount == 0 and inQuote == 0 ) then
				operatorFound = 2;
				pos = pos - 1;
				break;
			end
		end
		prevChar = currentChar;
		pos = pos + 1;
	end
	if( operatorFound == 2 ) then	
		return "/", string.sub( source, 1, pos - 1 ), string.sub( source, pos + 1 );
	end
	if( operatorFound ) then	
		return currentChar, string.sub( source, 1, pos - 1 ), string.sub( source, pos + 1 );
	end
end

recursiveSearch = function( source, search ) 
	if( not ( source and search ) ) then
		return nil;
	end
	local s = trim( search );
	local operator, op1, op2 = getOps( s );
	
	if( operator ) then
		local op1Res = recursiveSearch( source, op1 );		
		if( not op1Res ) then
			return 0;
		elseif( op1Res > 0 and operator == "/" ) then
			return 1;
		elseif( op1Res == 0 and operator == "+" ) then
			return 0;
		end
		
		local op2Res = recursiveSearch( source, op2, verbose );
		if( not op2Res ) then
			return 0;
		elseif( op2Res > 0 and ( op1Res > 0 or operator == "/" ) ) then
			return 1;
		end
		return 0;
	else
		local literal;			
		if( string.sub( s, 1, 1 ) == "-" ) then
			return( 1 - recursiveSearch( source, trim( string.sub( s, 2 ) ) ) );
		elseif( string.sub( s, 1, 1 ) == "(" and string.sub( s, string.len( s ) ) == ")" ) then
			return recursiveSearch( source, trim( string.sub( s, 2, string.len( s ) - 1 ) ) );
		elseif( string.sub( s, 1, 1 ) == "\"" and string.sub( s, string.len( s ) ) == "\"" ) then
			s = trim( string.sub( s, 2, string.len( s ) - 1 ) );
			literal = 1;
		end
		if( literal ) then
			if( string.find( source, s ) ) then
				return 1;
			else
				return 0;
			end
		else
			if( string.find( source, s ) ) then
				return 1;
			else
				for word in string.gfind( s, "%w+" ) do
					if( string.find( source, "%s+"..word.."%s+" ) ) then
						return 1;
					elseif( string.find( source, "^"..word.."%s+" ) ) then
						return 1;
					elseif( string.find( source, "%s+"..word.."$" ) ) then
						return 1;
					end
				end
				return 0;
			end
		end
	end
end

cloneTable = function( t )
  local new = {};          
  local i, v;  
  for i, v in t do
  	if ( type(v)=="table" ) then 
   	   new[i] = cloneTable(v);
  	else
 	   new[i] = v;
  	end
  end
  return new;
end



--[[
	The CTA_Util table holds several utility functions.
	========================================================================================================================
--]]

CTA_Util = {};

--[[
	------------------------------------------------------------------------------------------------------------------------
	Time	
	------------------------------------------------------------------------------------------------------------------------
--]]

CTA_Util.getTime = function()
	local hour, minute = GetGameTime();
	if( hour < 10 ) then hour = "0"..hour; end
	if( minute < 10 ) then minute = "0"..minute; end
	return hour..":"..minute;
end

--[[
	------------------------------------------------------------------------------------------------------------------------
	Searching
	------------------------------------------------------------------------------------------------------------------------
--]]

CTA_Util.search = function ( s, q )
	local source =  string.lower( string.gsub( s, "|c(%w+)|H(%w+):(.+)|h(.+)|h|r", "%4" ) );	
	return recursiveSearch( source, string.lower( q ) ), source;
end

--[[
	------------------------------------------------------------------------------------------------------------------------
	Showing and filtering lists
	------------------------------------------------------------------------------------------------------------------------
--]]

CTA_Util.updateList = function ( list, first, UIListName, maxResults, offset, showResultItem, size )

	while( size <= offset ) do
		offset = offset - maxResults;
	end
	if( offset < 0 ) then offset = 0; end	

	local pos = 0;
	local current = first;
	while( current ~= 0 and pos < offset ) do
		pos = pos + 1;
		current = list[current].next;
	end
	pos = 0;
	while( current ~= 0 and pos < maxResults ) do
		pos = pos + 1;
		showResultItem( getglobal( UIListName..pos ), current );
		current = list[current].next;
	end
	while( pos < maxResults ) do
		pos = pos + 1;
		getglobal( UIListName..pos ):Hide();
	end
end

CTA_Util.filterList = function ( list, satisfiesFilter )
	local size = 0;
	local first = 0;
	local prev = 0;
	for key, data in list do
		if( not satisfiesFilter or satisfiesFilter( key ) ) then
			size = size + 1;
			if( first ~= 0 ) then
				list[prev].next = key;
			else
				first = key;
			end
			prev = key;
		end
		data.next = 0;	
	end
	return first, size;
end

--[[
	------------------------------------------------------------------------------------------------------------------------
	Output to chat, log and minimap
	------------------------------------------------------------------------------------------------------------------------
--]]
		
CTA_Util.errorPrintln = function ( s )
	UIErrorsFrame:AddMessage(s, 0.75, 0.75, 1.0, 1.0, UIERRORS_HOLD_TIME);
end

CTA_Util.chatPrintln = function ( s )
	DEFAULT_CHAT_FRAME:AddMessage( "CTA: "..( s or "nil" ), 1, 0.75, 0.0);
end

CTA_Util.iconPrintln = function ( s, t )
	if( not t ) then
		CTA_MinimapMessageFrame:AddMessage( ( s or "nil" ), 1.0, 1.0, 0.5, 1.0, UIERRORS_HOLD_TIME);
	else
		local r = CTA_MESSAGE_COLOURS[t].r;
		local g = CTA_MESSAGE_COLOURS[t].g;
		local b = CTA_MESSAGE_COLOURS[t].b;
		CTA_MinimapMessageFrame:AddMessage( ( s or "nil" ), r, g, b, 1.0, UIERRORS_HOLD_TIME);
	end
end

CTA_Util.logPrintln = function ( s, t )
	local m = s;
	if( not m ) then
		m = "nil";
	end
	m = "["..CTA_Util.getTime().."] "..( m or "nil" );
	
	if( not t ) then
		CTA_Log:AddMessage( m, 1.0, 1.0, 0.5 );	
	else
		local r = CTA_MESSAGE_COLOURS[t].r;
		local g = CTA_MESSAGE_COLOURS[t].g;
		local b = CTA_MESSAGE_COLOURS[t].b;
		CTA_Log:AddMessage( m, r, g, b );	
	end
end

--[[
	------------------------------------------------------------------------------------------------------------------------
	Communication
	------------------------------------------------------------------------------------------------------------------------
--]]

CTA_Util.joinChannel = function( channel )
	JoinChannelByName( channel );
	RemoveChatWindowChannel( DEFAULT_CHAT_FRAME:GetID(), channel );
	CTA_Util.logPrintln( CTA_CALL_TO_ARMS_LOADED );
	CTA_Util.logPrintln( "Joined "..channel );
	return 1;
end

CTA_Util.sendChatMessage = function( message, messageType, channel, hidden ) 
	local language = CTA_COMMON;
	if( UnitFactionGroup(CTA_PLAYER) ~= CTA_ALLIANCE ) then
		language = CTA_ORCISH;
	end
	if( not hidden ) then
		SendChatMessage( string.gsub( message, "|c(%w+)|H(%w+):(.+)|h(.+)|h|r", "%4" ), messageType, language, channel );
	elseif( hidden == 1 ) then
		SendChatMessage( "[CTA] "..string.gsub( message, "|c(%w+)|H(%w+):(.+)|h(.+)|h|r", "%4" ), messageType, language, channel );
	else
		SendChatMessage( "<CTA> "..string.gsub( message, "|c(%w+)|H(%w+):(.+)|h(.+)|h|r", "%4" ), messageType, language, channel );
	end
end

--[[
	------------------------------------------------------------------------------------------------------------------------
	Group
	------------------------------------------------------------------------------------------------------------------------
--]]

CTA_Util.getGroupMemberInfo = function( index )
	local name, rank, subgroup, level, class, fileName, zone, online, isDead;
	if ( IsRaidLeader() and GetNumRaidMembers() > 0 ) then
		name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(index);	
	elseif ( IsPartyLeader() and GetNumPartyMembers() > 0 ) then
		local target = CTA_PLAYER;
		if( index > 1 and index < 6 ) then
			target = "PARTY"..(index-1);
		end
		name = UnitName(target);
		level = UnitLevel(target);
		class = UnitClass(target);
	elseif( GetNumRaidMembers() == 0  and GetNumPartyMembers() == 0 and index == 1 ) then
		local target = CTA_PLAYER;
		name = UnitName(target);
		level = UnitLevel(target);
		class = UnitClass(target);
	end
	return name, level, class;
end

CTA_Util.getNumGroupMembers = function()
	if( GetNumRaidMembers() > 0 ) then
		return GetNumRaidMembers();
	elseif( GetNumPartyMembers() > 0 ) then
		return GetNumPartyMembers() + 1;
	else
		return 1;
	end
end

--[[
	------------------------------------------------------------------------------------------------------------------------
	Table functions
	------------------------------------------------------------------------------------------------------------------------
--]]

CTA_Util.getn = function( list ) 
	local c = 0;
	for i, j in list do
		c = c + 1;
	end
	return c;
end

CTA_Util.cloneTable = function( t )
  return cloneTable( t );
end

--[[
	------------------------------------------------------------------------------------------------------------------------
	Class codec functions
	------------------------------------------------------------------------------------------------------------------------
--]]

CTA_Util.getClassCode = function( className )
	return CTA_Classes[className].id;
end

CTA_Util.getClassString = function( classSet )
	local b = "";
	local c = classSet;
	
	while( c > 0 ) do
		local d = mod(c, 2);
		b = d..b;
		c = floor(c/2);
	end
	while(string.len(b) < 8 ) do
		b = "0"..b;
	end
	
	local pos = 8;
	local t = "";
	while( pos > 0 ) do
		if( string.sub(b, pos, pos) == "1" ) then 	
			t = t..CTA_Classes[ CTA_Classes[9-pos] ].localName.." ";
		end
		pos = pos - 1;
	end
	return t;
end

--[[
	------------------------------------------------------------------------------------------------------------------------
	Player information retrieval
	------------------------------------------------------------------------------------------------------------------------
--]]

CTA_Util.getWhoInfo = function( playerName )
	local numWhos, totalCount = GetNumWhoResults();
	local name, guild, level, race, class, zone, group;
	for i=1, totalCount do
		name, guild, level, race, class, zone, group = GetWhoInfo(i);
		if( name == playerName ) then
			return name, guild, level, race, class, zone, group;
		end
	end
end
