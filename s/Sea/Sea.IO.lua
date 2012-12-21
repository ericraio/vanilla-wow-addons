--[[
--
--	Sea.IO
--
--	Common Input/Output Functions for WoW
--
--	$LastChangedBy: karlkfi $
--	$Rev: 3616 $
--	$Date: 2006-05-30 12:45:23 -0500 (Tue, 30 May 2006) $
--]]

--Compatible with the following Mini-Libs
Sea.versions.SeaString = 0.12;

-- Globals
SEA_DEBUG = false;
SEA_ERROR = false;

Sea.IO = {
	-- Default chat frame set to ChatFrame1
	DEFAULT_PRINT_FRAME = ChatFrame1;

	-- Default error frame set to ChatFrame1
	DEFAULT_ERROR_FRAME = ChatFrame1;

	-- Default banner frame
	DEFAULT_BANNER_FRAME = UIErrorsFrame;

	-- Default color scheme
	DEFAULT_ERROR_COLOR = RED_FONT_COLOR;
	DEFAULT_PRINT_COLOR = NORMAL_FONT_COLOR;

	-- Default Debug Tag
	debugKey = "SEA_DEBUG";

	-- Default Error Tag
	errorKey = "SEA_ERROR";
	
	-- Recursive check
	recursed = false;
	
--[[ Standard Prints ]]--
	
	--
	-- print ( ... )
	--
	-- Arguments
	-- 	() arg
	-- 	arg - the values to be printed
	--
	-- Returns
	-- 	(nil)
	--
	print = function(...) 
		Sea.IO.printf(nil, unpack(arg));
	end;

	--
	-- banner ( ... )
	--
	-- Arguments
	-- 	() arg
	-- 	arg - the values to be printed
	--
	-- Returns
	-- 	(nil)
	--
	banner = function(...) 
		Sea.IO.printf(Sea.IO.DEFAULT_BANNER_FRAME, unpack(arg));
	end;	

	--
	-- error (...)
	--
	-- 	prints just like Sea.IO.print, except as an error
	--
	-- Arguments:
	-- 	()  arg
	-- 	arg - contains all error output
	--
	error = function(...)
		Sea.IO.errorfc(nil, nil, unpack(arg) );
	end;

	--
	-- dprint (string debugkey, ...)
	--
	-- 	prints a message when getglobal(debugkey) is true
	--
	-- Arguments:
	-- 	(string debugkey) arg
	--
	dprint = function ( debugKey, ... )
		Sea.IO.dprintf(debugKey, Sea.IO.DEFAULT_PRINT_FRAME, unpack(arg));
	end;


	--
	-- dprintc (string debugkey, Table[r,g,b] color, ...)
	--
	-- 	prints a message when getglobal(debugkey) is true
	-- 	in the color specified by color
	--
	-- Arguments:
	-- 	(string debugkey, Table[r,g,b] color) arg
	--
	dprintc = function ( debugKey, color, ... )
		Sea.IO.dprintfc(debugKey, Sea.IO.DEFAULT_PRINT_FRAME, color,  unpack(arg));
	end;

	--
	-- derror (string errorKey, ...)
	--
	-- 	prints an error when getglobal(errorKey) is true
	--
	-- Arguments:
	-- 	(string errorKey) arg
	--
	derror = function ( errorKey, ... )
		Sea.IO.derrorf(errorKey, Sea.IO.DEFAULT_ERROR_FRAME, unpack(arg));
	end;

	--
	-- derrorf (string errorKey, MessageFrame frame, ...)
	--
	-- 	prints an error when getglobal(errorKey) is true
	--
	-- Arguments:
	-- 	(string errorKey, MessageFrame frame) arg
	--
	derrorf = function ( errorKey, frame, ... )
		Sea.IO.derrorfc(errorKey, frame, Sea.IO.DEFAULT_ERROR_COLOR, unpack(arg));
	end;
	
	--
	-- derrorc (string errorKey, Table[r,g,b] color, ...)
	--
	-- 	prints an error when getglobal(errorKey) is true
	-- 	in the color specified by color
	--
	-- Arguments:
	-- 	(string errorKey, Table[r,g,b] color) arg
	--
	derrorc = function ( errorKey, color, ... )
		Sea.IO.derrorfc(errorKey, Sea.IO.DEFAULT_ERROR_FRAME, color, unpack(arg));
	end;

	--
	-- derrorfc (string errorKey, MessageFrame frame, Table[r,g,b] color, ...)
	--
	-- 	prints an error when getglobal(errorKey) is true
	-- 	in the frame specified, in the color specified
	--
	-- Arguments:
	-- 	(string errorKey, MessageFrame frame, Table[r,g,b] color) arg
	-- 	
	--
	derrorfc = function ( errorKey, frame, color, ... )
		if ( type(errorKey) ~= "string" ) then
			if ( type(errorKey) == "nil" ) then 
				errorKey = Sea.IO.errorKey;
			else
				--Sea.IO.error("Invalid error key. Type: ", type(errorKey));
			end
		end
		if ( getglobal(errorKey) == true ) then 
			Sea.IO.errorfc(frame, color, unpack(arg));
		end
	end;
	
	
	--
	-- dbanner (string debugkey, ...)
	--
	-- 	prints a banner when getglobal(debugkey) is true
	--
	-- Arguments:
	-- 	(string debugkey) arg
	--
	dbanner = function ( debugKey, ... )
		Sea.IO.dprintf(debugKey, Sea.IO.DEFAULT_BANNER_FRAME, unpack(arg));
	end;
	
	--
	-- dbannerc (string debugkey, Table[r,g,b] ...)
	--
	-- 	prints a banner when getglobal(debugkey) is true
	-- 	in the color specified by color
	--
	-- Arguments:
	-- 	(string debugkey, Table[r,g,b] color) arg
	--
	dbannerc = function ( debugKey, color, ... )
		Sea.IO.dprintfc(debugKey, Sea.IO.DEFAULT_BANNER_FRAME, color, unpack(arg));
	end;	

	--
	-- printf (MessageFrame frame, ...)
	--	
	--	prints a message in a message frame
	--
	-- Arguments:
	-- 	(MessageFrame frame) arg
	--
	-- 	frame - the object with AddMessage(self, string)
	-- 	arg - the string to be composed
	--
	-- Returns
	-- 	(nil)
	--
	
	printf = function (frame, ... )
		Sea.IO.printfc(frame, nil, unpack(arg));
	end;

	--
	-- dprintf (string debugkey, MessageFrame frame, ...)
	--
	-- 	prints a message when getglobal(debugkey) is true
	-- 	also decodes | and characters
	--
	-- Arguments:
	-- 	(string debugkey, MessageFrame frame) arg
	-- 	debugkey - string debug key
	-- 	frame - debug target frame
	--
	dprintf = function ( debugKey, frame, ... )
		Sea.IO.dprintfc(debugKey, frame, nil, unpack(arg));
	end;	


	--
	-- dprintfc (string debugkey, MessageFrame frame, Table[r,g,b] color, ...)
	--
	-- 	prints a message when getglobal(debugkey) is true
	-- 	also decodes | and characters, using the specified color
	-- 	
	-- Arguments:
	-- 	(string debugkey, MessageFrame frame) arg
	-- 	debugkey - string/boolean debug key
	--	 if nil, then "getglobal(Sea.IO.debugKey)" is used;
	--	 if string, then "getglobal(debugKey)" is used;
	--	 if boolean or non-string it is evaluated to print using "if (debugKey) then";
	-- 	frame - debug target frame
	-- 	color - table of colors
	--
	dprintfc = function ( debugKey, frame, color, ... )
		if ( type(debugKey) == "string" ) then
			debugKey = getglobal(debugKey);
		elseif ( debugKey == nil ) then 
			debugKey = getglobal(Sea.IO.debugKey);
		end

		local msg = Sea.util.join(arg,"");
		msg = string.gsub(msg,"|","<pipe>");
		msg = string.gsub(msg,"([^%w%s%a%p])",Sea.string.byte);

		if ( debugKey ) then 
			Sea.IO.printfc(frame, color, unpack(arg));

			if IsAddOnLoaded( "!ImprovedErrorFrame" ) then
				ImprovedErrorFrame.newErrorMessage(Sea.util.join(arg, ""), this:GetName())
			end
		end
	end;	



	--
	-- errorc (Table[r,g,b] color, ...)
	--
	-- 	prints just like Sea.IO.print, except as an error with the color
	--
	-- Arguments:
	-- 	(Table[r,g,b] color)  arg
	-- 	color - the specified color
	-- 	arg - contains all error output
	--
	errorc = function(color, ...)
		Sea.IO.errorfc(Sea.IO.DEFAULT_ERROR_FRAME, color, unpack(arg) );
	end;	

	--
	-- errorf (MessageFrame frame, ...)
	--	
	--	prints a message in an error message frame
	--
	-- Arguments:
	-- 	(MessageFrame frame) arg
	--
	-- 	frame - the object with AddMessage(self, string)
	-- 	arg - the string to be composed
	--
	-- Returns
	-- 	(nil)
	--
	
	errorf = function (frame, ... )
		Sea.IO.errorfc(frame, nil, unpack(arg));
	end;

	--
	-- errorfc (MessageFrame frame, Table[r,g,b] color, ...)
	--	
	--	prints a message in an error message frame with the color
	--
	-- Arguments:
	-- 	(MessageFrame frame, Table[r,g,b] color) arg
	--
	-- 	frame - the object with AddMessage(self, string)
	-- 	color - table containing the colors
	-- 	arg - the string to be composed
	--
	-- Returns
	-- 	(nil)
	--
	
	errorfc = function (frame, color, ... )
		if ( frame == nil ) then
			frame = Sea.IO.DEFAULT_ERROR_FRAME;
		end
		if ( color == nil ) then
			color = Sea.IO.DEFAULT_ERROR_COLOR;
		end
		
		Sea.IO.printfc(frame, color, unpack(arg));		
	end;
	--
	-- printc ( ColorTable[r,g,b] color, ... )
	--	
	--	prints a message in the default frame with a 
	--	specified color
	--
	-- Arguments:
	-- 	color - the color
	-- 	arg - the message
	-- 
	printc = function ( color, ... ) 
		Sea.IO.printfc(nil, color, unpack(arg));
	end;

	--
	-- bannerc ( ColorTable[r,g,b] color, ... )
	--	
	--	prints a banner message with a 
	--	specified color
	--
	-- Arguments:
	-- 	color - the color
	-- 	arg - the message
	-- 
	bannerc = function ( color, ... ) 
		if ( color == nil ) then 
			color = Sea.IO.DEFAULT_PRINT_COLOR;
		end

		Sea.IO.printfc(Sea.IO.DEFAULT_BANNER_FRAME, color, unpack(arg));
	end;
		
	--
	-- printfc (MessageFrame frame, ColorTable[r,g,b] color, ... )
	--
	-- 	prints a message in a frame with a specified color
	--
	-- Arguments
	-- 	frame - the frame
	-- 	color - a table with .r .g and .b values
	-- 	arg - the message objects
	--
	printfc = function (frame, color, ... ) 
		if ( frame == nil ) then 
			frame = Sea.IO.DEFAULT_PRINT_FRAME;
		end
		if ( color == nil ) then 
			color = Sea.IO.DEFAULT_PRINT_COLOR;
		end

		if ( Sea.IO.recursed == false ) then 
			Sea.IO.recursed = true;
			if ( frame == Sea.IO.DEFAULT_BANNER_FRAME ) then
				frame:AddMessage(Sea.util.join(arg,""), color.r, color.g, color.b, 1.0, UIERRORS_HOLD_TIME);
			else
				frame:AddMessage(Sea.util.join(arg,""), color.r, color.g, color.b);
			end
			Sea.IO.recursed = false;
		else
			if ( frame == Sea.IO.DEFAULT_BANNER_FRAME ) then
				frame:AddMessage(arg[1], color.r, color.g, color.b, 1.0, UIERRORS_HOLD_TIME);
			else
				frame:AddMessage(arg[1], color.r, color.g, color.b);
			end
		end			
	end;

	--[[ End of Standard Prints ]]--
	
	--[[ Beginning of Special Prints ]]--
	
	--
	-- printComma (...)
	--
	--	Prints the arguments separated by commas
	--
	printComma = function(...)
		Sea.IO.print(Sea.util.join(arg,","));
	end;
	
	--
	-- printTable (table, [rowname, level])
	--
	-- 	Recursively prints a table
	--
	-- Args:
	-- 	table - table to be printed
	-- 	rowname - row's name
	-- 	level - level of depth
	--
	printTable = function (table, rowname, level) 
		if ( level == nil ) then level = 1; end

		if ( type(rowname) == "nil" ) then rowname = "ROOT"; 
		elseif ( type(rowname) == "string" ) then 
			rowname = "\""..rowname.."\"";
		elseif ( type(rowname) ~= "number" ) then
			rowname = "*"..type(rowname).."*";
		end

		local msg = "";
		for i=1,level, 1 do 
			msg = msg .. "  ";	
		end

		if ( table == nil ) then 
			Sea.IO.print(msg,"[",rowname,"] := nil "); return 
		end
		if ( type(table) == "table" ) then
			Sea.IO.print (msg,rowname," { ");
			for k,v in table do
				Sea.io.printTable(v,k,level+1);
			end
			Sea.IO.print(msg,"}");
		elseif (type(table) == "function" ) then 
			Sea.IO.print(msg,"[",rowname,"] => {{FunctionPtr*}}");
		elseif (type(table) == "userdata" ) then 
			Sea.IO.print(msg,"[",rowname,"] => {{UserData}}");
		elseif (type(table) == "boolean" ) then 
			local value = "true";
			if ( not table ) then
				value = "false";
			end
			Sea.IO.print(msg,"[",rowname,"] => ",value);
		else	
			Sea.IO.print(msg,"[",rowname,"] => ",table);
		end
	end
};

-- Aliases:
Sea.io = Sea.IO;
