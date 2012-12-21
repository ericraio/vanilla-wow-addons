--[[
	MCom
	 	A set of utility functions to simplify addon creation
	
	By: Mugendai
	Contact: mugekun@gmail.com
	
	MCom provides several functions designed to lower the amount of code
	required to make an addon be configurable.  It helps to handle the
	things that need to go on to handle user input, either via console
	or via some GUI(like Cosmos or Khaos).
	
	It aims mainly at tasks that are repeated in multiple places in every addon.
	Any addon that wants to have chat commands needs a chat handler, and functions
	for each command it can accept.  It also needs functions for updating
	the variables that have to do with configuration.  Addons may also need
	wrapper functions for a GUI interface.  They may also need to have multiple
	registers to support multiple GUIs, such as Cosmos and Khaos.
	
	These things are all handled by MCom either by registering with it for such
	functions, or by calling functions that do the repetative part.
	
	$Id: MCom.lua 2641 2005-10-17 09:26:21Z mugendai $
	$Rev: 2641 $
	$LastChangedBy: mugendai $
	$Date: 2005-10-17 04:26:21 -0500 (Mon, 17 Oct 2005) $
]]--

--If we should update/declare MCom, then do so now
if (MCom_Update) then

	if (not Khaos) then
		-- Provide Khaos config keywords for MCom mods for when Khaos isn't around
		K_TEXT = "text";
		K_CHECKBOX = "text"; -- Not a typo. Checkboxes use the "text" type to describe their right-side
		K_BUTTON = "button";
		K_SLIDER = "slider";
		K_EDITBOX = "editbox";
		K_PULLDOWN = "pulldown";
		K_COLORPICKER = "colorpicker";
		K_HEADER = "separator";
	end
	
	if (not myAddOnsList) then
		MYADDONS_CATEGORY_BARS = "Bars";
		MYADDONS_CATEGORY_CHAT = "Chat";
		MYADDONS_CATEGORY_CLASS = "Class";
		MYADDONS_CATEGORY_COMBAT = "Combat";
		MYADDONS_CATEGORY_COMPILATIONS = "Compilations";
		MYADDONS_CATEGORY_GUILD = "Guild";
		MYADDONS_CATEGORY_INVENTORY = "Inventory";
		MYADDONS_CATEGORY_MAP = "Map";
		MYADDONS_CATEGORY_OTHERS = "Others";
		MYADDONS_CATEGORY_PROFESSIONS = "Professions";
		MYADDONS_CATEGORY_QUESTS = "Quests";
		MYADDONS_CATEGORY_RAID = "Raid";
	end

	--------------------------------------------------
	--
	-- Public Library Functions
	--
	--------------------------------------------------
	--[[
	 	registerSmart ( {reglist} )
		 	A single function that can register a chat command, and a UI variable at the same time.
		 	You pass only the data you need to, and it will do anything it can with that data.
		 	If you pass enough data to register a UI command and callback, a slash command, a super slash command,
		 	and a sub slash command, this will do all of those things.
		
		Args:
		 	reglist - the table of options, some options will be listed more than once to show when they are needed, but only set them once
		 	 	{
		 	 	Data required to register a Cosmos or Khaos command:
		 	 	 	(string) uivar - the name of the UI variable
		 	 	 	(string) uitype - the type of UI variable
		 	 	 	(string) uilabel - the label of the UI variable
		 	 	 	
		 	 	Data required to register a Khaos command:
		 	 		(string) uisec - the ID of the Khaos set to put the option in
		 	 	 	
		 	 	Optional data for Cosmos or Khaos options:
		 	 		(function) func -	the function to call when this variable changes, see addSlashCommand for further details on the function
		 	 	 										if this is not passed, a generic callback will be provided for you
		 	 	 	(string) varbool - the name of the boolean variable to use in the generic setter
		 	 	 	(string) varnum - the name of the number variable to use in the generic setter
		 	 	 	(string) varstring - the name of the editbox variable to use in the generic setter
		 	 	 	(string) varchoice - the name of the pulldown variable to use in the generic setter
		 	 	 	(string) varcolor - the name of the color variable to use in the generic setter
		 	 	 	(function) update - this function will be called when using the generic setter, and the variable is updated
		 	 	 	(function) noupdate - this function will be called when using the generic setter, and the variable is not updated
		 	 	 	(function) anyupdate - this function will be called when using the generic setter, whether the variable is updated or not
		 	 	 	(boolean) hasbool - set to true if this option has a checkbox in it
		 	 	 	
		 	 	 	(table) uioption -	this can either be a table in the form of a Cosmos registration, or a KhaosOption.  If it is passed
		 	 	 											then it will be used to pull as much data as MCom can make use of out of it.  This can allow you to
		 	 	 											pass a Cosmos style option, that registers a Khaos option, for instance.  It also allows you to set
		 	 	 											anything in the Khaos option that MCom doesn't have an argument for.
		 	 	 											If this is a Khaos option, it can include an entry called mcopts, which is a table of MCom options to set
		 	 	 											for the option
		 	 	 	(string) uisec -	the ID of the section/set to put the option in, if the section/set already exists, the option wil be
		 	 	 										added to it, if it doesn't exist, it will be created
		 	 	 	(string) uiseclabel - the name of the section/set to put the option in
		 	 	 	(string) uisecdesc - the description of the section/set to put the option in
		 	 	 		NOTE: Once passed, the uisec variables will be stored as defaults for further commands
		 	 	 	(string) uisep -	the ID of the separator/header to put the option in, if the separator/header already exists, then the
		 	 	 										option will be added after it, if it doesn't exist, it will be created
		 	 	 		NOTE: Once passed, the uisep variable will be stored as default for further commands
		 	 	 	(string) uiseplabel - the name of the separator/header to put the option in
		 	 	 	(string) uisepdesc - the description of the separator/header to put the option in
		 	 	 	(string) uidesc - the description of the UI variable
		 	 	 	(number) uicheck - the default value for a checkbox, 1 or 0
		 	 	 	(number) uislider - the default value for a slider
		 	 	 	(number) uimin - the minimum value for a slider
		 	 	 	(number) uimax - the maximum value for a slider
		 	 	 	(string) uitext - the text to show on a UI control
		 	 	 	(number) uistep - the increment to use for a slider
		 	 	 	(number) uitexton - whether to show the text for the control or not, 1 or 0
		 	 	 	(string) uisuffix - the suffix to show at the end of the slider text
		 	 	 	(number) uimul - how much to multiple the slider value by when displaying it

		 	 	Optional data for Khaos only options:
		 	 		(table)	uiset - this can be an entire KhaosSet, and if it is, the whole thing will be MCom registered
		 	 		(string) uifolder - the Khaos folder to put the option in, if you don't pass this, and uicat is passed with a compatible type, uicat will be used
		 	 			NOTE: Once passed, the uifolder variable will be stored as default for further commands
		 	 		(string) uisecdiff - the difficulty of the set to put the option in
		 	 		(string) uiseccall - the callback of the set to put the option in
		 	 		(string) uisecdef - the default of the set to put the option in
		 	 		(string) uiseccom - the commands list of the set to put the option in
		 	 			NOTE: Once passed, the uisec variables will be stored as defaults for further commands
		 	 		(string) uisepdiff - the difficulty of the header to put the option in
		 	 		(string) uisepcall - the callback of the header to put the option in
		 	 		(string) uisepdef - the default of the header to put the option in
		 	 		(string) uikey - the key to use for the option
		 	 		(string) uivalue - the value to use for the option
		 	 		(number) uidiff - the difficulty of the option
		 	 		{ key = { value = requirement } } uidep -	A table listing what key's in a Khaos option set need to have what value set to what requirement
																										for the option to be enabled
		 	 		(boolean) uiradio - set to true if the option has a radio control
		 	 		(function) uifeedback - the function to call to show feedback data
		 	 		(table) uisetup - the control setup structure
		 	 		(string) uisliderlow - the text to show on the lower potion of the slider control
		 	 		(string) uisliderhigh - the text to show on the higher potion of the slider control
		 	 		(function) uisliderfunc - the function to use to setup the text to show on the slider
		 	 		{	string = value, ... } choices -	A list of choices and values to use when using a pulldown, string is the string shown in the pulldown
																						and value is the value that should be associated with that string.
					(boolean) multichoice - set to true if more than one option can be selected in a pulldown
					(boolean) hasopacity - set to true if a colorpicker should also have an opacity slider
					(color) uicolor - the default color to use in a color picker
					(string/table) uichoice - the default option(s) to be selected in a pulldown
					(string) uistring - the default string to be set in a textbox
					(table) uicallon - the default string to be set in a textbox
					(boolean) uidischeck - the value of a checkbox when the option set is disabled
					(number) uidisslider - the value of a slider when the option set is disabled
					(color) uidiscolor - the value of a color picker when the option set is disabled
					(string/table) uidischoice - the value of a pulldown when the option set is disabled
					(string) uidisstring - the value of a text box when the option set is disabled
						NOTE: Disabled options will use default settings, if they are not passed or nil
					
				Data required to register with myAddOns
					NOTE: You do not have to wait for VARIABLES_LOADED to register for myAddOns via MCom
								Also, if you have set any section info for a Khaos or Cosmos section, that will be used with myAddOns
					(string) addonname - This must be the exact same as the title in the toc file.  Defaults to uisec.
						or
					(string) uisec -	Where to place the addon in the myAddOnsList, defaults to uiseclabel
						or
					(string) uiseclabel - The name to show in myAddOns, defaults to uisec
					
				Optional data for registering with myAddOns
					(string) uisec -	Where to place the addon in the myAddOnsList, defaults to uiseclabel
		 	 	 	(string) uiseclabel - The name to show in myAddOns, defaults to uisec
		 	 	 	(string) uisecdesc - NO LONGER USED BY myAddOns - The description to show in myAddOns, defaults to uiseclabel
		 	 	 	(string or number) uiver - The version to show in the UI
		 	 	 	(string) uidate - The date this version of the addon was released
		 	 	 	(string) uiauthor - The name of the author of the addon
		 	 	 	(string) uiwww - The website the addon can be found at, if any
		 	 	 	(string) uimail - The email address the author can be reached at
		 	 	 	(string) uicat - The category to place the addon in, if you don't pass this, and uifolder is passed with a compatible type, uifolder will be used
		 	 	 	(string) uiframe - NO LONGER USED BY myAddOns - The name of the frame used to detect if your addon is loaded
		 	 	 	(string) uioptionsframe -	The name of the frame to show when the myAddOns options button is pressed for this Addon.  If this is not passed, and
		 	 	 														you are registering a Cosmos or Khaos option at the same time as this, then Cosmos or Khaos will be set as the options frame.
		 	 	 														This will also add the frame to UIPanelWindows
		 	 	 	( string or {string} ) uihelp - The help text to display in myAddOns and in slash command, and Khaos help.  If it is a table, each entry is a page.

				Data required to register a standard slash command:
					(string) command - the name of the slash command Ex: "/command", or {"/command", "/com"}
					(string) comtype -	[Required if uitype is not passed, takes precidence over uitype]
															the type of data you are expecting from this slash command
									 						MCOM_BOOLT - Expects boolean data, an on, off, 1, or 0
									 						MCOM_NUMT - Expects a number value
									 						MCOM_MULTIT -	Expects a boolean and then a number value, Ex: "/command on 3", this has been surplanted via simply
									 													using hasbool with MCOM_NUMT
									 						MCOM_STRINGT - Expects any string
									 						MCOM_COLORT - Expects a color setup, and optionally opacity
									 						MCOM_CHOICET - Expects a choice from a list of choices, or optionaly multiple choices
									 						MCOM_SIMPLET - No input needed, just calls the function
					
				Optional data for a standard slash command, or sub command:
					(function) func -	the function to call when this variable changes, see addSlashCommand for further details on the function
		 	 	 										if this is not passed, a generic callback will be provided for you
		 	 	 	(boolean) hasbool - set to true if this option has a boolean portion
		 	 	 	(string) varbool - the name of the boolean variable to use in the generic setter
		 	 	 	(string) varnum - the name of the number variable to use in the generic setter
		 	 	 	(string) varstring - the name of the string variable to use in the generic setter
		 	 	 	(string) varchoice - the name of the choice variable to use in the generic setter
		 	 	 	(string) varcolor - the name of the color variable to use in the generic setter
		 	 	 	(number) varmin -	the minimum value the number variable can be set to when using the generic setter
		 	 	 										if not passed, and uimin is passed, uimin will be used
		 	 	 	(number) varmax -	the maximum value the number variable can be set to when using the generic setter
		 	 	 										if not passed, and uimax is passed, uimax will be used
		 	 	 	(function) update - this function will be called when using the generic setter, and the variable is updated
		 	 	 	(function) noupdate - this function will be called when using the generic setter, and the variable is not updated
		 	 	 	(function) anyupdate - this function will be called when using the generic setter, whether the variable is updated or not
		 	 	 	(string) textname -	specifies the name of the option to display when printing status changes without a UI, only used if
		 	 	 											textbool/num/string/choice/color aren't
		 	 	 	(string) textbool, textnum, textstring, textchoice, textcolor -	the string to print for the corrisponding portion, when not using a UI,
		 	 	 																																	and the variable has been updated in the generic setter.  If this string
		 	 	 																																	contains a %s, then it will be replaced with the value its updated to.
		 	 	 	(boolean) textshow - if this is true, then the text will be printed on update, whether or not a UI is around(when using the generic setter)
		 	 	 	(number) commul - the value to multiply the number by when showing it's status
		 	 	 	(number) cominmul - the value to multiply the number by when it is passed in by the user
					(string) comaction -	The action to perform, see Sky documentation for further details
		 			(number) comsticky -	Whether the command is sticky or not(1 or 0), see Sky documentation for further details
		 			(boolean) multichoice - set to true if more than one option can be selected in an MCOM_CHOICET
		 			(boolean) hasopacity - set to true if an MCOM_COLORT should also have an opacity setting
		 		
		 		Optional data for a standard slash command only:
		 			(string) comhelp -	What message to display as help in Sky for this command, see Sky documentation for further details
		 			({string}) extrahelp -	A table of extra help messages to display, each line in the table is a separate line when printed.
					
				Data required to register a super slash command:
					(string) supercom - the name of the super slash command Ex: "/command", or {"/command", "/com"}
					
				Optional data for a super slash command:
					(string) comaction -	The action to perform, see Sky documentation for further details
		 			(number) comsticky -	Whether the command is sticky or not(1 or 0), see Sky documentation for further details
		 			(string) comhelp -	What message to display as help in Sky for this command, see Sky documentation for further details
		 			({string}) extrahelp -	A table of extra help messages to display, each line in the table is a separate line when printed.
					
				Data required to register a sub slash command:
					(string) supercom - the name of the super slash command to use for this sub slash command Ex: "/command", or {"/command", "/com"}
					(string) subcom - the name of the sub command, Ex: "command", or {"command", "com"}
					
					(string) comtype -	[Required if uitype is not passed], see above for details

				Optional data for a sub command only:
					(string) subhelp -	What message to display next to the sub command when listing sub commands in the help output.
															NOTE: if this is an MCOM_CHOICET then if you put a %s in this string, it will be replaced with a list of
															the choices you passed.
					
				Data required for a slash command to update a Cosmos or Khaos variable:
					(string) uivar -	The UI variable that should be updated

				Data required for a slash command to update a Cosmos or Khaos variable, if func does not return a value:
		 			(string) varbool -	The variable that the UI variable should be set by
		 												This should be a string containing the name of the variable to update, this can include .'s for tables, Ex: "Something.Value"
		 												When type is MULTI, this specifies the bool variable
		 			(string) varnum - The same as comnum, but used to specify the number variable when type is MULTI, only used for MULTI type
				
				Data required for a slash command to update a Khaos variable:
					(string) uisec - The option set ID that the uivar is found in	
				
				Data required for a slash command to when type is MCOM_CHOICET:
					{	string = value, ... } choices -	A list of choices and values to use when using a MCOM_CHOICET, string is the string passed in from the console
																						and value is the value that should be associated with that string.
				
				Data required for help window:
					( string or {string} ) infotext -	If this is passed the text will be shown in a help window then the slash command help is used, or when the help button
																						is pressed in Khaos or Cosmos, this is also used for myAddOns help if uihelp was not passed.  If it is a table, each
																						entry is a page.
				
				Optional data for help window:
					(string) name - Sets the name to refer to the addon as in the help window
					(string) infotitle - Sets the title of the help window, if not passed, then name is used with a default string, Ex. "AddonName Help"
		 	 	}
	]]--
	MCom.registerSmart = function ( inreglist )
		--Get a copy of the registration table
		local reglist;
		if ( type(inreglist) == "table" ) then
			reglist = MCom.table.copy(inreglist);
		end
		--Make sure reglist is here, and a table
		if (type(reglist) == "table") then
			--Register the Khaos options set if it has been passed
			if ( type(reglist.uiset) == "table" ) then
				MCom.uisec = reglist.uiset.id;
				MCom.uiseclabel = reglist.uiset.text;
				MCom.uisecdesc = reglist.uiset.helptext;
				MCom.uisecdiff = reglist.uiset.difficulty;
				MCom.uisecdef = reglist.uiset.default;
				MCom.uiseccall = reglist.uiset.callback;
				MCom.uiseccom = reglist.uiset.commands;
				--Register each option in the list
				if ( type(reglist.uiset.options) == "table" ) then
					for curOption = 1, getn(reglist.uiset.options) do
						local newMComSet = MCom.table.copy(reglist);
						newMComSet.uiset = nil;
						newMComSet.uioption = reglist.uiset.options[curOption];
						MCom.registerSmart( newMComSet );
					end
				end
			end
			
			--Support for old sytax variables
			if (reglist.comvar) then
				reglist.varbool = reglist.comvar;
			end
			if (reglist.comvarmulti) then
				reglist.varnum = reglist.comvarmulti;
			end
			
			--This will be set to true if we find that uioption is in Khaos format.
			local isKhaosOption = nil;
			
			--If option data has been passed use any of it, as needed
			if ( type(reglist.uioption) == "table" ) then
				--If the option data seems to be Khaos style, then parse it as such
				if (	(reglist.uioption.id ~= nil) or (reglist.uioption.key ~= nil) or (reglist.uioption.value ~= nil) or 
							(reglist.uioption.text ~= nil) or (reglist.uioption.diificulty ~= nil) or (reglist.uioption.helptext ~= nil) or 
							(reglist.uioption.callback ~= nil) or (reglist.uioption.feedback ~= nil) or (reglist.uioption.check ~= nil) or 
							(reglist.uioption.radio ~= nil) or (reglist.uioption.type ~= nil) or (reglist.uioption.setup ~= nil) or 
							(reglist.uioption.default ~= nil) or (reglist.uioption.disabled ~= nil) or (reglist.uioption.dependencies ~= nil) or
							(reglist.uioption.mcopts ~= nil)
				) then
					isKhaosOption = true;
					if (reglist.uivar == nil) then
						reglist.uivar = reglist.uioption.id;
					end
					if (reglist.uikey == nil) then
						reglist.uikey = reglist.uioption.key;
					end
					if (reglist.uivalue == nil) then
						reglist.uivalue = reglist.uioption.value;
					end
					if (reglist.uilabel == nil) then
						reglist.uilabel = reglist.uioption.text;
					end
					if (reglist.uidiff == nil) then
						reglist.uidiff = reglist.uioption.difficulty;
					end
					if (reglist.uidesc == nil) then
						reglist.uidesc = reglist.uioption.helptext;
					end
					if (reglist.uifunc == nil) then
						reglist.uifunc = reglist.uioption.callback;
						--If this is a Khaos style function, going into Cosmos, then convert the values to Cosmos style
						if ((not Khaos) and CosmosMaster_Init and reglist.uifunc) then
							reglist.uifunc = function (check, value) reglist.uioption.callback({ checked = (check == 1); slider = value; }); end;
						end
					end
					if (reglist.hasbool == nil) then
						reglist.hasbool = reglist.uioption.check;
					end
					if (reglist.uiradio == nil) then
						reglist.uiradio = reglist.uioption.radio;
					end
					if (reglist.uitype == nil) then
						reglist.uitype = reglist.uioption.type;
					end
					if ( type(reglist.uioption.setup) == "table" ) then
						if (reglist.uisetup == nil) then
							reglist.uisetup = reglist.uioption.setup;
						end
						if (reglist.uitext == nil) then
							if ( (reglist.uitype == K_BUTTON) or (reglist.uitype == "BUTTON") ) then
								reglist.uitext = reglist.uioption.setup.buttonText;
							elseif ( (reglist.uitype == K_SLIDER) or (reglist.uitype == "SLIDER") or (reglist.uitype == "BOTH") ) then
								reglist.uitext = reglist.uioption.setup.sliderText;
							end
						end
						if (reglist.uimin == nil) then
							reglist.uimin = reglist.uioption.setup.sliderMin;
						end
						if (reglist.uimax == nil) then
							reglist.uimax = reglist.uioption.setup.sliderMax;
						end
						if (reglist.uistep == nil) then
							reglist.uistep = reglist.uioption.setup.sliderStep;
						end
						if (reglist.uisliderlow == nil) then
							reglist.uisliderlow = reglist.uioption.setup.sliderLowText;
						end
						if (reglist.uisliderhigh == nil) then
							reglist.uisliderhigh = reglist.uioption.setup.sliderHighText;
						end
						if (reglist.uisliderfunc == nil) then
							reglist.uisliderfunc = reglist.uioption.setup.sliderDisplayFunc;
						end
						if (reglist.choices == nil) then
							reglist.choices = reglist.uioption.setup.options;
						end
						if (reglist.multichoice == nil) then
							reglist.multichoice = reglist.uioption.setup.multiSelect;
						end
						if (reglist.hasopacity == nil) then
							reglist.hasopacity = reglist.uioption.setup.hasOpacity;
						end
						if (reglist.uicallon == nil) then
							reglist.uicallon = reglist.uioption.setup.callOn;
						end
					end
					if (reglist.uifeedback == nil) then
						reglist.uifeedback = reglist.uioption.feedback;
					end
					if ( type(reglist.uioption.default) == "table" ) then
						if (reglist.uicheck == nil) then
							reglist.uicheck = reglist.uioption.default.checked;
							if (reglist.uicheck) then
								reglist.uicheck = 1;
							else
								reglist.uicheck = 0;
							end
						end
						if (reglist.uislider == nil) then
							reglist.uislider = reglist.uioption.default.slider;
						end
						if (reglist.uicolor == nil) then
							reglist.uicolor = reglist.uioption.default.color;
						end
						if (reglist.uitype == K_EDITBOX) then
							if (reglist.uistring == nil) then
								reglist.uistring = reglist.uioption.default.value;
							end
						end
						if (reglist.uitype == K_PULLDOWN) then
							if (reglist.uichoice == nil) then
								reglist.uichoice = reglist.uioption.default.value;
							end
						end
					end
					if ( type(reglist.uioption.disabled) == "table" ) then
						if (reglist.uidischeck == nil) then
							reglist.uidischeck = reglist.uioption.disabled.checked;
							if (reglist.uidischeck) then
								reglist.uidischeck = 1;
							else
								reglist.uidischeck = 0;
							end
						end
						if (reglist.uidisslider == nil) then
							reglist.uidisslider = reglist.uioption.disabled.slider;
						end
						if (reglist.uidiscolor == nil) then
							reglist.uidiscolor = reglist.uioption.disabled.color;
						end
						if (reglist.uitype == K_EDITBOX) then
							if (reglist.uidisstring == nil) then
								reglist.uidisstring = reglist.uioption.disabled.value;
							end
						end
						if (reglist.uitype == K_PULLDOWN) then
							if (reglist.uidischoice == nil) then
								reglist.uidischoice = reglist.uioption.disabled.value;
							end
						end
					end
					if (reglist.uidep == nil) then
						reglist.uidep = reglist.uioption.dependencies;
					end

					--If an MCom option set is in here, then use it
					if ( type(reglist.uioption.mcopts) == "table" ) then
						for curOpt in reglist.uioption.mcopts do
							reglist[curOpt] = reglist.uioption.mcopts[curOpt];
						end
					end
				else
					--If it's not Khaos style, we treat it as Cosmos style
					if (reglist.uivar == nil) then
						reglist.uivar = reglist.uioption[1];
					end
					if (reglist.uitype == nil) then
						reglist.uitype = reglist.uioption[2];
					end
					if (reglist.uilabel == nil) then
						reglist.uilabel = reglist.uioption[3];
					end
					if (reglist.uidesc == nil) then
						reglist.uidesc = reglist.uioption[4];
					end
					if (reglist.uifunc == nil) then
						reglist.uifunc = reglist.uioption[5];
						--If it's a Cosmos style function, being used in Khaos then convert the arguments to match
						if (Khaos and (not CosmosMaster_Init) and reglist.uifunc) then
							local checkFunc = function (check)
								if (check) then
									return 1;
								else
									return 0;
								end
							end
							reglist.uifunc = function (state) reglist.uioption[5]( checkFunc(state.checked) , state.slider); end;
							if ( reglist.func == nil ) then
								if (reglist.uitype == "SLIDER") then
									reglist.func = function (value) reglist.uioption[5](0,value); end;
								else
									reglist.func = function (bool, value) reglist.uioption[5](bool,value); end;
								end
							end
						end
					end
					if (reglist.uicheck == nil) then
						reglist.uicheck = reglist.uioption[6];
					end
					if (reglist.uislider == nil) then
						reglist.uislider = reglist.uioption[7];
					end
					if (reglist.uimin == nil) then
						reglist.uimin = reglist.uioption[8];
					end
					if (reglist.uimax == nil) then
						reglist.uimax = reglist.uioption[9];
					end
					if (reglist.uitext == nil) then
						reglist.uitext = reglist.uioption[10];
					end
					if (reglist.uistep == nil) then
						reglist.uistep = reglist.uioption[11];
					end
					if (reglist.uitexton == nil) then
						reglist.uitexton = reglist.uioption[12];
					end
					if (reglist.uisuffix == nil) then
						reglist.uisuffix = reglist.uioption[13];
					end
					if (reglist.uimul == nil) then
						reglist.uimul = reglist.uioption[14];
					end
				end
			end
			
			--Default our regtype to nil
			local regtype = nil;
			--If we have uitype, then figure out the MCOM type for it
			if (reglist.uitype) then
				--If we are doing Khaos, then use it's types, and convert Cosmos types
				--to Khaos types
				if (Khaos) then
						if ( reglist.uitype == K_TEXT ) then
							if (reglist.hasbool == true) then
								regtype = MCOM_BOOLT;
							end
						elseif ( reglist.uitype == K_SLIDER ) then
							regtype = MCOM_NUMT;
						elseif ( reglist.uitype == K_EDITBOX ) then
							regtype = MCOM_STRINGT;
						elseif ( reglist.uitype == K_BUTTON ) then
							regtype = MCOM_SIMPLET;
						elseif ( reglist.uitype == K_PULLDOWN ) then
							regtype = MCOM_CHOICET;
						elseif ( reglist.uitype == K_COLORPICKER ) then
							regtype = MCOM_COLORT;
						elseif (reglist.uitype == "CHECKBOX") then
							reglist.uitype = K_TEXT;
							regtype = MCOM_BOOLT;
							reglist.hasbool = true;
						elseif (reglist.uitype == "SLIDER") then
							reglist.uitype = K_SLIDER;
							regtype = MCOM_NUMT;
						elseif (reglist.uitype == "BOTH") then
							reglist.uitype = K_SLIDER;
							reglist.hasbool = true;
							regtype = MCOM_MULTIT;
						elseif (reglist.uitype == "BUTTON") then
							reglist.uitype = K_BUTTON;
							regtype = MCOM_SIMPLET;
						elseif (reglist.uitype == "SEPARATOR") then
							reglist.uitype = K_HEADER;
						end
				else
					--If we are doing Cosmos, then use it's types, and convert Khaos types
					--to Cosmos types
					if ( reglist.uitype == K_TEXT ) then
						if (reglist.hasbool == true) then
							regtype = MCOM_BOOLT;
							reglist.uitype = "CHECKBOX";
						end
					elseif ( reglist.uitype == K_SLIDER ) then
						regtype = MCOM_NUMT;
						reglist.uitype = "SLIDER";
						if (reglist.hasbool == true) then
							reglist.uitype = "BOTH";
						end
					elseif ( reglist.uitype == K_EDITBOX ) then
						regtype = MCOM_STRINGT;
					elseif ( reglist.uitype == K_BUTTON ) then
						regtype = MCOM_SIMPLET;
						reglist.uitype = "BUTTON";
					elseif ( reglist.uitype == K_PULLDOWN ) then
						regtype = MCOM_CHOICET;
					elseif ( reglist.uitype == K_COLORPICKER ) then
						regtype = MCOM_COLORT;
					elseif (reglist.uitype == K_HEADER) then
							reglist.uitype = "SEPARATOR";
					elseif (reglist.uitype == "CHECKBOX") then
						regtype = MCOM_BOOLT;
						reglist.hasbool = true;
					elseif (reglist.uitype == "SLIDER") then
						regtype = MCOM_NUMT;
					elseif (reglist.uitype == "BOTH") then
						regtype = MCOM_MULTIT;
					elseif (reglist.uitype == "BUTTON") then
						regtype = MCOM_SIMPLET;
					end
				end
			end
			--If we have the comtype, use it instead of the uitype
			if (reglist.comtype) then
				regtype = reglist.comtype;
			end
			
			--If regtype is not set, and we have check set, then set type is BOOLT.
			if ( (regtype == nil) and (reglist.hasbool == true) ) then
				regtype = MCOM_BOOLT;
			end
			--If regtype is BOOLT, and we dont have check set, then set it.
			if ( (regtype == MCOM_BOOLT) and (not reglist.hasbool) ) then
				reglist.hasbool = true;
			end
			--If regtype is MULTIT, and we dont have check set, then set it.
			if ( (regtype == MCOM_MULTIT) and (not reglist.hasbool) ) then
				reglist.hasbool = true;
			end
			
			--If no min, max, or mul were provided for the setter, but was provided for the UI, then use the ui values
			--and visa versa
			if ( reglist.uimin and (not reglist.varmin) ) then
				reglist.varmin = reglist.uimin;
			elseif ( reglist.varmin and (not reglist.uimin) ) then
				reglist.uimin = reglist.varmin;
			end
			if ( reglist.uimax and (not reglist.varmax) ) then
				reglist.varmax = reglist.uimax;
			elseif ( reglist.varmax and (not reglist.uimax) ) then
				reglist.uimax = reglist.varmax;
			end
			if ( reglist.uimul and (not reglist.commul) ) then
				reglist.commul = reglist.uimul;
			elseif ( reglist.commul and (not reglist.uimul) ) then
				reglist.uimul = reglist.commul;
			end
			if ( not reglist.uimul ) then
				reglist.uimul = 1;
			end
			if ( reglist.commul and ( not reglist.cominmul ) ) then
				reglist.cominmul = 1 / reglist.commul;
			end
			if ( not reglist.commul ) then
				reglist.commul = 1;
			end
			if ( not reglist.cominmul ) then
				reglist.cominmul = 1;
			end
			
			if (not reglist.func) then
				if (reglist.uifunc) then
					--If there was no function passed, but a ui func was passed, use the uifunc
					reglist.func = reglist.uifunc;
				else
					--If textname wasn't passed, try and make it from other data
					if (not reglist.textname) then
						reglist.textname = reglist.uilabel;
					end
					if (not reglist.textname) then
						if ( type(reglist.subcom) == "table" ) then
							reglist.textname = reglist.subcom[1];
						else
							reglist.textname = reglist.subcom;
						end
					end
					if (not reglist.textname) then
						if ( type(reglist.command) == "table" ) then
							reglist.textname = reglist.command[1];
						else
							reglist.textname = reglist.command;
						end
					end
					
					--Generate defaults for the text strings if none are passed
					if (reglist.textname) then
						if (not reglist.textbool) then
							reglist.textbool = string.format(MCOM_CHAT_STATUS_B, reglist.textname);
						end
						if (not reglist.textnum) then
							reglist.textnum = string.format(MCOM_CHAT_STATUS_N, reglist.textname);
						end
						if (not reglist.textstring) then
							reglist.textstring = string.format(MCOM_CHAT_STATUS_S, reglist.textname);
						end
						if (not reglist.textchoice) then
							reglist.textchoice = string.format(MCOM_CHAT_STATUS_C, reglist.textname);
						end
						if (not reglist.textcolor) then
							reglist.textcolor = string.format(MCOM_CHAT_STATUS_K, reglist.textname);
						end
					end
					
					--If there was no function passed, then provide our own generic function
					if ((regtype == MCOM_BOOLT) and reglist.varbool) then
						reglist.func =	function (checked)
															if (MCom.updateVar(reglist.varbool, checked, MCOM_BOOLT)) then
																--If there is a function to run on an update, call it
																if (reglist.update and (type(reglist.update) == "function")) then
																	reglist.update(reglist.varbool);
																end

																if (reglist.textbool) then
																	--Print output to let the player know the command succeeded, if there is no UI
																	MCom.printStatus(reglist.textbool, MCom.getStringVar(reglist.varbool), true, reglist.textshow);
																end
															else
																--If there is a function to run on an attempted update, that resulted in no change, then run it
																if (reglist.noupdate and (type(reglist.noupdate) == "function")) then
																	reglist.noupdate(reglist.varbool);
																end
															end
															--If there is a function to run on any update, then run it
															if (reglist.anyupdate and (type(reglist.anyupdate) == "function")) then
																reglist.anyupdate(reglist.varbool);
															end
														end;
					elseif ( ( (regtype == MCOM_NUMT) and (not reglist.hasbool) ) and reglist.varnum ) then
						reglist.func =	function (value)
															if (MCom.updateVar(reglist.varnum, value, MCOM_NUMT, reglist.varmin, reglist.varmax)) then
																--If there is a function to run on an update, call it
																if (reglist.update and (type(reglist.update) == "function")) then
																	reglist.update(reglist.varnum);
																end

																if (reglist.textnum) then
																	--Print output to let the player know the command succeeded, if there is no UI
																	if (value and reglist.commul and MCom.getStringVar(reglist.varnum)) then
																		value = MCom.math.round( ( MCom.getStringVar(reglist.varnum) * reglist.commul ) * 100 ) / 100;
																	else
																		value = MCom.getStringVar(reglist.varnum);
																	end
																	MCom.printStatus(reglist.textnum, value, nil, reglist.textshow);
																end
															else
																--If there is a function to run on an attempted update, that resulted in no change, then run it
																if (reglist.noupdate and (type(reglist.noupdate) == "function")) then
																	reglist.noupdate(reglist.varnum);
																end
															end
															--If there is a function to run on any update, then run it
															if (reglist.anyupdate and (type(reglist.anyupdate) == "function")) then
																reglist.anyupdate(reglist.varnum);
															end
														end;
					elseif ( ( (regtype == MCOM_STRINGT) and (not reglist.hasbool) ) and reglist.varstring ) then
						reglist.func =	function (value)
															if (MCom.updateVar(reglist.varstring, value, MCOM_STRINGT)) then
																--If there is a function to run on an update, call it
																if (reglist.update and (type(reglist.update) == "function")) then
																	reglist.update(reglist.varstring);
																end
																
																if (reglist.textstring) then
																	--Print output to let the player know the command succeeded, if there is no UI
																	MCom.printStatus(reglist.textstring, MCom.getStringVar(reglist.varstring), nil, reglist.textshow);
																end
															else
																--If there is a function to run on an attempted update, that resulted in no change, then run it
																if (reglist.noupdate and (type(reglist.noupdate) == "function")) then
																	reglist.noupdate(reglist.varstring);
																end
															end
															--If there is a function to run on any update, then run it
															if (reglist.anyupdate and (type(reglist.anyupdate) == "function")) then
																reglist.anyupdate(reglist.varstring);
															end
														end;
					elseif ( ( (regtype == MCOM_CHOICET) and (not reglist.hasbool) ) and reglist.varchoice ) then
						reglist.func =	function (value, name)
															if (MCom.updateVar(reglist.varchoice, value, MCOM_CHOICET)) then
																--If there is a function to run on an update, call it
																if (reglist.update and (type(reglist.update) == "function")) then
																	reglist.update(reglist.varchoice);
																end
																
																if (reglist.textchoice) then
																	--Print output to let the player know the command succeeded, if there is no UI
																	MCom.printStatus(reglist.textchoice, name, nil, reglist.textshow);
																end
															else
																--If there is a function to run on an attempted update, that resulted in no change, then run it
																if (reglist.noupdate and (type(reglist.noupdate) == "function")) then
																	reglist.noupdate(reglist.varchoice);
																end
															end
															--If there is a function to run on any update, then run it
															if (reglist.anyupdate and (type(reglist.anyupdate) == "function")) then
																reglist.anyupdate(reglist.varchoice);
															end
														end;
					elseif ( ( (regtype == MCOM_COLORT) and (not reglist.hasbool) ) and reglist.varcolor ) then
						reglist.func =	function (value)
															if (MCom.updateVar(reglist.varcolor, value, MCOM_COLORT)) then
																--If there is a function to run on an update, call it
																if (reglist.update and (type(reglist.update) == "function")) then
																	reglist.update(reglist.varcolor);
																end
																
																if (reglist.textcolor) then
																	--Build a color string
																	local curColor = MCom.getStringVar(reglist.varstring);
																	local curColString = "";
																	if ( type(curColor) == "table" ) then
																		if (curColor.r) then
																			curColString = string.format(MCOM_CHAT_COM_K_R, MCom.math.round(curColor.r * 100));
																		end
																		if (curColor.g) then
																			if ( curColString ~= "" ) then
																				curColString = curColString..", ";
																			end
																			curColString = curColString..string.format(MCOM_CHAT_COM_K_G, MCom.math.round(curColor.g * 100));
																		end
																		if (curColor.b) then
																			if ( curColString ~= "" ) then
																				curColString = curColString..", ";
																			end
																			curColString = curColString..string.format(MCOM_CHAT_COM_K_B, MCom.math.round(curColor.b * 100));
																		end
																		if (reglist.hasopacity) then
																			local displayOpacity = 1;
																			if (curColor.opacity) then
																				displayOpacity = curColor.opacity;
																			end
																			if ( curColString ~= "" ) then
																				curColString = curColString..", ";
																			end
																			curColString = curColString..string.format(MCOM_CHAT_COM_K_O, MCom.math.round(displayOpacity * 100));
																		end
																	end
																	--Print output to let the player know the command succeeded, if there is no UI
																	MCom.printStatus(reglist.textcolor, curColString, nil, reglist.textshow);
																end
															else
																--If there is a function to run on an attempted update, that resulted in no change, then run it
																if (reglist.noupdate and (type(reglist.noupdate) == "function")) then
																	reglist.noupdate(reglist.varcolor);
																end
															end
															--If there is a function to run on any update, then run it
															if (reglist.anyupdate and (type(reglist.anyupdate) == "function")) then
																reglist.anyupdate(reglist.varcolor);
															end
														end;
					elseif ( ( (regtype == MCOM_MULTIT) or ( (regtype == MCOM_NUMT) and reglist.hasbool ) ) and reglist.varbool and reglist.varnum ) then
						reglist.func =	function (checked, value)
															if (MCom.updateVar(reglist.varbool, checked, MCOM_BOOLT)) then
																--If there is a function to run on an update, call it
																if (reglist.update and (type(reglist.update) == "function")) then
																	reglist.update(reglist.varbool);
																end
																
																if (reglist.textbool) then
																	--Print output to let the player know the command succeeded, if there is no UI
																	MCom.printStatus(reglist.textbool, MCom.getStringVar(reglist.varbool), true, reglist.textshow);
																end
															else
																--If there is a function to run on an attempted update, that resulted in no change, then run it
																if (reglist.noupdate and (type(reglist.noupdate) == "function")) then
																	reglist.noupdate(reglist.varbool);
																end
															end
															--If there is a function to run on any update, then run it
															if (reglist.anyupdate and (type(reglist.anyupdate) == "function")) then
																reglist.anyupdate(reglist.varbool);
															end
															
															--If no value was passed, then don't set it
															if (value) then
																if (MCom.updateVar(reglist.varnum, value, MCOM_NUMT, reglist.varmin, reglist.varmax)) then
																	--If there is a function to run on an update, call it
																	if (reglist.update and (type(reglist.update) == "function")) then
																		reglist.update(reglist.varnum);
																	end
																	
																	if (reglist.textnum) then
																		--Print output to let the player know the command succeeded, if there is no UI
																		if (value and reglist.commul and MCom.getStringVar(reglist.varnum)) then
																			value = MCom.math.round( ( MCom.getStringVar(reglist.varnum) * reglist.commul ) * 100 ) / 100;
																		else
																			value = MCom.getStringVar(reglist.varnum);
																		end
																		MCom.printStatus(reglist.textnum, value, nil, reglist.textshow);
																	end
																else
																	--If there is a function to run on an attempted update, that resulted in no change, then run it
																	if (reglist.noupdate and (type(reglist.noupdate) == "function")) then
																		reglist.noupdate(reglist.varnum);
																	end
																end
															end
															--If there is a function to run on any update, then run it
															if (reglist.anyupdate and (type(reglist.anyupdate) == "function")) then
																reglist.anyupdate(reglist.varnum);
															end
														end;
					elseif ( ( ( (regtype == MCOM_STRINGT) and reglist.hasbool ) ) and reglist.varbool and reglist.varstring ) then
						reglist.func =	function (checked, value)
															if (MCom.updateVar(reglist.varbool, checked, MCOM_BOOLT)) then
																--If there is a function to run on an update, call it
																if (reglist.update and (type(reglist.update) == "function")) then
																	reglist.update(reglist.varbool);
																end
																
																if (reglist.textbool) then
																	--Print output to let the player know the command succeeded, if there is no UI
																	MCom.printStatus(reglist.textbool, MCom.getStringVar(reglist.varbool), true, reglist.textshow);
																end
															else
																--If there is a function to run on an attempted update, that resulted in no change, then run it
																if (reglist.noupdate and (type(reglist.noupdate) == "function")) then
																	reglist.noupdate(reglist.varbool);
																end
															end
															--If there is a function to run on any update, then run it
															if (reglist.anyupdate and (type(reglist.anyupdate) == "function")) then
																reglist.anyupdate(reglist.varbool);
															end
															
															--If no value was passed, then don't set it
															if (value) then
																if (MCom.updateVar(reglist.varstring, value, MCOM_STRINGT)) then
																	--If there is a function to run on an update, call it
																	if (reglist.update and (type(reglist.update) == "function")) then
																		reglist.update(reglist.varstring);
																	end
																	
																	if (reglist.textstring) then
																		--Print output to let the player know the command succeeded, if there is no UI
																		MCom.printStatus(reglist.textstring, MCom.getStringVar(reglist.varstring), nil, reglist.textshow);
																	end
																else
																	--If there is a function to run on an attempted update, that resulted in no change, then run it
																	if (reglist.noupdate and (type(reglist.noupdate) == "function")) then
																		reglist.noupdate(reglist.varstring);
																	end
																end
															end
															--If there is a function to run on any update, then run it
															if (reglist.anyupdate and (type(reglist.anyupdate) == "function")) then
																reglist.anyupdate(reglist.varstring);
															end
														end;
					elseif ( ( ( (regtype == MCOM_CHOICET) and reglist.hasbool ) ) and reglist.varbool and reglist.varchoice ) then
						reglist.func =	function (checked, value, name)
															if (MCom.updateVar(reglist.varbool, checked, MCOM_BOOLT)) then
																--If there is a function to run on an update, call it
																if (reglist.update and (type(reglist.update) == "function")) then
																	reglist.update(reglist.varbool);
																end
																
																if (reglist.textbool) then
																	--Print output to let the player know the command succeeded, if there is no UI
																	MCom.printStatus(reglist.textbool, MCom.getStringVar(reglist.varbool), true, reglist.textshow);
																end
															else
																--If there is a function to run on an attempted update, that resulted in no change, then run it
																if (reglist.noupdate and (type(reglist.noupdate) == "function")) then
																	reglist.noupdate(reglist.varbool);
																end
															end
															--If there is a function to run on any update, then run it
															if (reglist.anyupdate and (type(reglist.anyupdate) == "function")) then
																reglist.anyupdate(reglist.varbool);
															end
															
															--If no value was passed, then don't set it
															if (value) then
																if (MCom.updateVar(reglist.varchoice, value, MCOM_CHOICET)) then
																	--If there is a function to run on an update, call it
																	if (reglist.update and (type(reglist.update) == "function")) then
																		reglist.update(reglist.varchoice);
																	end
																	
																	if (reglist.textchoice) then
																		--Print output to let the player know the command succeeded, if there is no UI
																		MCom.printStatus(reglist.textchoice, name, nil, reglist.textshow);
																	end
																else
																	--If there is a function to run on an attempted update, that resulted in no change, then run it
																	if (reglist.noupdate and (type(reglist.noupdate) == "function")) then
																		reglist.noupdate(reglist.varchoice);
																	end
																end
															end
															--If there is a function to run on any update, then run it
															if (reglist.anyupdate and (type(reglist.anyupdate) == "function")) then
																reglist.anyupdate(reglist.varchoice);
															end
														end;
					elseif ( ( ( (regtype == MCOM_COLORT) and reglist.hasbool ) ) and reglist.varbool and reglist.varcolor ) then
						reglist.func =	function (checked, value)
															if (MCom.updateVar(reglist.varbool, checked, MCOM_BOOLT)) then
																--If there is a function to run on an update, call it
																if (reglist.update and (type(reglist.update) == "function")) then
																	reglist.update(reglist.varbool);
																end
																
																if (reglist.textbool) then
																	--Print output to let the player know the command succeeded, if there is no UI
																	MCom.printStatus(reglist.textbool, MCom.getStringVar(reglist.varbool), true, reglist.textshow);
																end
															else
																--If there is a function to run on an attempted update, that resulted in no change, then run it
																if (reglist.noupdate and (type(reglist.noupdate) == "function")) then
																	reglist.noupdate(reglist.varbool);
																end
															end
															--If there is a function to run on any update, then run it
															if (reglist.anyupdate and (type(reglist.anyupdate) == "function")) then
																reglist.anyupdate(reglist.varbool);
															end
															
															--If no value was passed, then don't set it
															if (value) then
																if (MCom.updateVar(reglist.varcolor, value, MCOM_COLORT)) then
																	--If there is a function to run on an update, call it
																	if (reglist.update and (type(reglist.update) == "function")) then
																		reglist.update(reglist.varcolor);
																	end
																	
																	if (reglist.textcolor) then
																		--Build a color string
																		local curColor = MCom.getStringVar(reglist.varstring);
																		local curColString = "";
																		if ( type(curColor) == "table" ) then
																			if (curColor.r) then
																				curColString = string.format(MCOM_CHAT_COM_K_R, MCom.math.round(curColor.r * 100));
																			end
																			if (curColor.g) then
																				if ( curColString ~= "" ) then
																					curColString = curColString..", ";
																				end
																				curColString = curColString..string.format(MCOM_CHAT_COM_K_G, MCom.math.round(curColor.g * 100));
																			end
																			if (curColor.b) then
																				if ( curColString ~= "" ) then
																					curColString = curColString..", ";
																				end
																				curColString = curColString..string.format(MCOM_CHAT_COM_K_B, MCom.math.round(curColor.b * 100));
																			end
																			if (reglist.hasopacity) then
																				local displayOpacity = 1;
																				if (curColor.opacity) then
																					displayOpacity = curColor.opacity;
																				end
																				if ( curColString ~= "" ) then
																					curColString = curColString..", ";
																				end
																				curColString = curColString..string.format(MCOM_CHAT_COM_K_O, MCom.math.round(displayOpacity * 100));
																			end
																		end
																		--Print output to let the player know the command succeeded, if there is no UI
																		MCom.printStatus(reglist.textcolor, curColString, nil, reglist.textshow);
																	end
																else
																	--If there is a function to run on an attempted update, that resulted in no change, then run it
																	if (reglist.noupdate and (type(reglist.noupdate) == "function")) then
																		reglist.noupdate(reglist.varcolor);
																	end
																end
															end
															--If there is a function to run on any update, then run it
															if (reglist.anyupdate and (type(reglist.anyupdate) == "function")) then
																reglist.anyupdate(reglist.varcolor);
															end
														end;
					end
				end
			end

			--If uifolder was not passed, see if there is a compatable uicat for it
			if (not reglist.uifolder) then
				if (reglist.uicat == MYADDONS_CATEGORY_BARS) then
					reglist.uifolder = "bars";
				elseif (reglist.uicat == MYADDONS_CATEGORY_CHAT) then
					reglist.uifolder = "chat";
				elseif (reglist.uicat == MYADDONS_CATEGORY_COMBAT) then
					reglist.uifolder = "combat";
				elseif (reglist.uicat == MYADDONS_CATEGORY_INVENTORY) then
					reglist.uifolder = "inventory";
				elseif (reglist.uicat == MYADDONS_CATEGORY_QUESTS) then
					reglist.uifolder = "quest";
				end
			end

			if (reglist.uitype == "SECTION") then
				--If a Cosmos section has been passed, then we need to store it's data so that
				--when we are ready to register an option, we can then create the option set
				--based on the section data
				MCom.uifolder = reglist.uifolder;
				MCom.uisec = reglist.uisec;
				MCom.uisecabel = reglist.uiseclabel;
				MCom.uisecdesc = reglist.uisecdesc;
				MCom.uisecdiff = reglist.uisecdiff;
				MCom.uiseccall = reglist.uiseccall;
				MCom.uisecdef = reglist.uisecdef;
				MCom.uiseccom = reglist.uiseccom;
				if (not reglist.uisec) then
					reglist.uisec = reglist.uivar;
					MCom.uisec = reglist.uivar;
				end
				if (not reglist.uiseclabel) then
					MCom.uiseclabel = reglist.uilabel;
				end
				if (not reglist.uisecdesc) then
					MCom.uisecdesc = reglist.uidesc;
				end
			end
			
			--If no set was passed, then use the previously stored one
			if (not reglist.uisec) then
				reglist.uisec = MCom.uisec;
			end

			--If the previously stored set exists, and is the same as the one passed, then pull
			--the data from it
			if ( MCom.uisec and (MCom.uisec == reglist.uisec) ) then
				if (not reglist.uiseclabel) then
					reglist.uiseclabel = MCom.uiseclabel;
				end
				if (not reglist.uisecdesc) then
					reglist.uisecdesc = MCom.uisecdesc;
				end
				if (not reglist.uisecdiff) then
					reglist.uisecdiff = MCom.uisecdiff;
				end
				if (not reglist.uiseccall) then
					reglist.uiseccall = MCom.uiseccall;
				end
				if (not reglist.uisecdef) then
					reglist.uisecdef = MCom.uisecdef;
				end
				if (not reglist.uiseccom) then
					reglist.uiseccom = MCom.uiseccom;
				end
			end
			
			--Setup stored set with current data
			MCom.uisec = reglist.uisec;
			MCom.uiseclabel = reglist.uiseclabel;
			MCom.uisecdesc = reglist.uisecdesc;
			MCom.uisecdiff = reglist.uisecdiff;
			MCom.uiseccall = reglist.uiseccall;
			MCom.uisecdef = reglist.uisecdef;
			MCom.uiseccom = reglist.uiseccom;

			--If MyAddOns is loaded, then try to register with it
			if ( myAddOnsList and (MCom.uisec or MCom.uiseclabel or reglist.addonname) ) then
				--Figure out an entry, label, and description
				local addonEntry = MCom.uisec;
				if (not addonEntry) then
					addonEntry = reglist.addonname;
				end
				if (not addonEntry) then
					addonEntry = MCom.uilabel;
				end
				local addonName = reglist.addonname;
				if (not addonName) then
					addonName = addonEntry;
				end
				if (not addonName) then
					addonName = reglist.uiseclabel;
				end
				if ( (not myAddOnsFrame_Register) and MCom.uiseclabel ) then
					addonName = MCom.uiseclabel;
				end
				local addonDesc = reglist.uisecdesc;
				if (not addonDesc) then
					addonDesc = addonName;
				end
				if (not MCom.MyAddOnsList) then
					MCom.MyAddOnsList = {};
				end

				--Default the addon list to an internal one that MCom keeps, until loading is done
				local addonList = MCom.MyAddOnsList;
				--If we have finished loading MyAddOns, then go ahead and use its list
				if (MCom.MyAddOnsLoaded) then
					addonList = myAddOnsList;
				elseif (not MCom.MyAddonsHooked) then
					--If variables haven't loaded yet, then store the registered addons in a temporary list
					--that will will use to add to the real list once variables have loaded
					MCom.MyAddonsHooked = true;
					--Hook the MyAddOns event function so we know when variables have loaded
					MCom.util.hook("myAddOnsFrame_OnEvent", "MCom.myAddOnsFrame_OnEvent", "after");
				end

				--Only add this to the list if it isn't already there
				if ( not addonList[addonEntry] ) then
					--If category wasn't passed see if a compatable folder was passed
					if (not reglist.uicat) then
						if (reglist.uifolder == "bars") then
							reglist.uicat = MYADDONS_CATEGORY_BARS;
						elseif (reglist.uifolder == "chat") then
							reglist.uicat = MYADDONS_CATEGORY_CHAT;
						elseif (reglist.uifolder == "combat") then
							reglist.uicat = MYADDONS_CATEGORY_COMBAT;
						elseif (reglist.uifolder == "inventory") then
							reglist.uicat = MYADDONS_CATEGORY_INVENTORY;
						elseif (reglist.uifolder == "quest") then
							reglist.uicat = MYADDONS_CATEGORY_QUESTS;
						else
							reglist.uicat = MYADDONS_CATEGORY_OTHERS;
						end
					end

					--If no options frame was passed, and this is a Cosmos or Khaos registration, then set
					--the options frame to be the Khaos or Cosmos options frame
					if (not reglist.uioptionsframe) then
						if (Khaos and reglist.uivar and reglist.uitype and reglist.uilabel) then
							reglist.uioptionsframe = "KhaosFrame";
						elseif (CosmosMaster_Init and reglist.uivar and reglist.uitype and reglist.uilabel ) then
							reglist.uioptionsframe = "CosmosMasterFrame";
						end
					end
					--If an options frame was passed, and it isn't in the UIPanel's list, then add it
					if (reglist.uioptionsframe and ( not UIPanelWindows[reglist.uioptionsframe] ) ) then
						UIPanelWindows[reglist.uioptionsframe] = {area = "center", pushable = 0};
					end
					--If uihelp wasn't passed, use infotext
					if (not reglist.uihelp) then
						reglist.uihelp = reglist.infotext;
					end
					--Make usre uihelp is a table or boolean
					if (reglist.uihelp and (type(reglist.uihelp) ~= "table") and (type(reglist.uihelp) ~= "boolean") ) then
						reglist.uihelp = { reglist.uihelp };
					end
					--Add the addon to the list
					addonList[addonEntry] = {
						details = {
							name = addonName;
							description = addonDesc;
							version = reglist.uiver;
							releaseDate = reglist.uidate,
							author = reglist.uiauthor,
							email = reglist.uimail,
							website = reglist.uiwww,
							category = reglist.uicat;
							frame = reglist.uiframe;
							optionsframe = reglist.uioptionsframe;
						};
						help = reglist.uihelp;
						supercom = reglist.supercom;
					};
				end
			end
			
			--If the variable name is not prefixed with COS_ and cosmos is the UI then put it on there
			if ( reglist.uivar and CosmosMaster_Init and (not Khaos) ) then
				if ( (string.len(reglist.uivar) < 4) or (string.sub(reglist.uivar, 1, 4) ~= "COS_") ) then
					reglist.uivar = "COS_"..reglist.uivar;
				end
			end

			if (Khaos and reglist.uivar and reglist.uitype and reglist.uilabel) then
				--If we have Khaos and the data needed to register with it, then try to work that out
				if (reglist.uitype ~= "SECTION") then
					--Only work with valid Khaos types
					if (	(reglist.uitype == K_HEADER) or (reglist.uitype == K_TEXT) or (reglist.uitype == K_CHECKBOX) or
								(reglist.uitype == K_BUTTON) or (reglist.uitype == K_SLIDER) or (reglist.uitype == K_EDITBOX) or
								(reglist.uitype == K_PULLDOWN) or (reglist.uitype == K_COLORPICKER)	) then
						--We have now go through the proccess of preparing a Khaos option, then we will register it
						--If a folder has been passed then store it for use now, and for future registers
						if (reglist.uifolder) then
							MCom.uifolder = reglist.uifolder;
						end
						--If a separator has been passed then store it for use now, and for future registers
						if (reglist.uisep) then
							MCom.uisep = reglist.uisep;
						end
						if (reglist.uitype == K_HEADER) then
							MCom.uisep = reglist.uivar;
						end
					
						--If we don't have a uifunc yet, then wrap the func
						if ( (not reglist.uifunc) and reglist.func ) then
							--Wrap it for Khaos
							reglist.uifunc = function (state, keypressed) MCom.SetFromKUI(reglist.uivar, state, keypressed, reglist.choices); end;
							--Add the function to the list of callback functions
							if (reglist.uitype) then
								--Only do this for UI elements that have options
								if ((reglist.uitype == K_SLIDER) or (reglist.uitype == K_PULLDOWN) or (reglist.uitype == K_EDITBOX) or (reglist.uitype == K_COLORPICKER) or (reglist.uitype == K_BUTTON) or ( (reglist.uitype == K_TEXT) and (reglist.hasbool) ) ) then
									--If there is no function list yet, then make it
									if (not MCom.UIFuncList) then
										MCom.UIFuncList = {};
									end
									--If this function is not yet in the list, then make it
									if (not MCom.UIFuncList[reglist.uivar]) then
										MCom.UIFuncList[reglist.uivar] = {};
									end
									MCom.UIFuncList[reglist.uivar].func = reglist.func;
									MCom.UIFuncList[reglist.uivar].uitype = reglist.uitype;
									MCom.UIFuncList[reglist.uivar].hasbool = reglist.hasbool;
								end
							end
						end
						
						--Make our option structure
						local kOption = {};
						--If uioption is a Khaos style option, use it as our option structure
						if (isKhaosOption) then
							kOption = reglist.uioption;
						end
						
						--Setup the varying parts of the option with MCom data
						kOption.id = reglist.uivar;
						kOption.key = reglist.uikey;
						kOption.value = reglist.uivalue;
						kOption.text = reglist.uilabel;
						kOption.difficulty = reglist.uidiff;
						kOption.helptext = reglist.uidesc;
						kOption.callback = reglist.uifunc;
						if ( reglist.hasbool == nil ) then
							if ( (regtype == MCOM_BOOLT) or (regtype == MCOM_MULTIT) ) then
								reglist.hasbool = true;
							end
						end
						kOption.check = reglist.hasbool;
						kOption.radio = reglist.uiradio;
						kOption.type = reglist.uitype;
						--Setup the setup structure
						if ( type(reglist.uisetup) == "table" ) then
							kOption.setup = reglist.uisetup;
						else
							kOption.setup = {};
						end
						if (reglist.uitype == K_BUTTON) then
							kOption.setup.buttonText = reglist.uitext;
						end

						--Setup the slider
						if (reglist.uitype == K_SLIDER) then
							kOption.setup.sliderMin = reglist.uimin;
							kOption.setup.sliderMax = reglist.uimax;
							kOption.setup.sliderStep = reglist.uistep;
							--If no slider display func has been passed, then make a generic one, that behaves the same
							--as the one in Cosmos
							kOption.setup.sliderLowText = reglist.uisliderlow;
							kOption.setup.sliderHighText = reglist.uisliderhigh;
							kOption.setup.sliderText = reglist.text;
							if (not reglist.uisuffix) then
								reglist.uisuffix = "";
							end
							sliderDisplayFunc = reglist.uisliderfunc;
							if (sliderDisplayFunc == nil) then
								kOption.setup.sliderDisplayFunc = function ( value ) return ( MCom.math.round( ( value * reglist.uimul ) * 100 ) / 100 )..reglist.uisuffix;  end;
							end
						end
						kOption.setup.options = reglist.choices;
						kOption.setup.multiSelect = reglist.multichoice;
						kOption.setup.hasOpacity = reglist.hasopacity;
						kOption.setup.callOn = reglist.uicallon;

						kOption.feedback = reglist.uifeedback;
						--If no feedback has been passed, then make a generic feedback function
						if (not kOption.feedback) then
							if ( reglist.uitype ~= K_HEADER and reglist.uitype ~= K_BUTTON ) then 
								kOption.feedback = function(state)
									local retString;	--The string to return
									--If it is has a check or radio then set the return string up for that
									if (kOption.check ) then
										if ( state.checked ) then
											retString = string.format(MCOM_FEEDBACK_CHECK, kOption.text, MCOM_CHAT_ENABLED);
										else
											retString = string.format(MCOM_FEEDBACK_CHECK, kOption.text, MCOM_CHAT_DISABLED);
										end
									elseif (kOption.radio ) then
										if ( state.value ) then
											retString = string.format(MCOM_FEEDBACK_RADIO, kOption.text, state.value);
										end
									end
									--If it has a slider then set the string up for that
									if (reglist.uitype == K_SLIDER) then
										if ( state.slider ) then
											if (not retString) then
												retString = string.format(MCOM_FEEDBACK_SLIDER, kOption.text, kOption.setup.sliderDisplayFunc(state.slider) );
											else
												--If we also have a check or radio, then use a version that displays both that, and this
												retString = string.format(MCOM_FEEDBACK_SLIDER_M, retString, kOption.setup.sliderDisplayFunc(state.slider) );
											end
										end
									end
									if (reglist.uitype == K_EDITBOX) then
										if ( state.value ) then
											if (not retString) then
												retString = string.format(MCOM_FEEDBACK_EDITBOX, kOption.text, state.value);
											else
												--If we also have a check or radio, then use a version that displays both that, and this
												retString = string.format(MCOM_FEEDBACK_EDITBOX_M, retString, state.value);
											end
										end
									end
									if (reglist.uitype == K_COLORPICKER) then
										if ( state.color ) then
											if (not retString) then
												retString = string.format(MCOM_FEEDBACK_COLOR, MCom.string.colorToString(state.color), kOption.text);
											else
												--If we also have a check or radio, then use a version that displays both that, and this
												retString = string.format(MCOM_FEEDBACK_COLOR_M, MCom.string.colorToString(state.color), retString);
											end
										end
									end
									if (reglist.uitype == K_CHOICE) then
										if ( state.value ) then
											--Create a text list of options
											local options;
											if ( type(state.value) == "table" ) then
												for curOption = 1, table.getn(state.value) do
													if (options) then
														options = options..", "..state.value[curOption];
													else
														options = state.value[curOption];
													end
												end
											else
												options = state.value;
											end
											if (not retString) then
												retString = string.format(MCOM_FEEDBACK_CHOICE, kOption.text, options);
											else
												--If we also have a check or radio, then use a version that displays both that, and this
												retString = string.format(MCOM_FEEDBACK_CHOICE_M, retString, options);
											end
										end
									end
									return retString;
								end
							end
						end

						--Convert the default check state to Khaos style
						if ( reglist.uicheck and ( (reglist.uicheck == 1) or (reglist.uicheck == true) ) ) then
							reglist.uicheck = true;
						else
							reglist.uicheck = false;
						end
						--Convert the disabled check to Khaos format
						if ( reglist.uidischeck and ( (reglist.uidischeck == 1) or (reglist.uidischeck == true) ) ) then
							reglist.uidischeck = true;
						elseif (reglist.uidischeck == 0) then
							reglist.uidischeck = false;
						end

						--Setup the default structure
						kOption.default = {};
						if (reglist.hasbool) then
							kOption.default.checked = reglist.uicheck;
						end
						if (reglist.uitype == K_SLIDER) then
							kOption.default.slider = reglist.uislider;
							if (kOption.default.slider == nil) then
								kOption.default.slider = reglist.uimax;
							end
							if (kOption.default.slider == nil) then
								kOption.default.slider = reglist.uimin;
							end
							if (kOption.default.slider == nil) then
								kOption.default.slider = 1;
							end
						end
						if (reglist.uitype == K_COLORPICKER) then
							kOption.default.color = reglist.uicolor;
						end
						if ( (reglist.uitype == K_PULLDOWN) ) then
							kOption.default.value = reglist.uichoice;
						end
						if ( (reglist.uitype == K_EDITBOX) ) then
							kOption.default.value = reglist.uistring;
						end
						
						--Setup the disabled structure
						--fallback to default, if disabled is not passed
						kOption.disabled = {};
						if (reglist.hasbool) then
							kOption.disabled.checked = reglist.uidischeck;
							if (kOption.disabled.checked == nil) then
								kOption.disabled.checked = reglist.uicheck;
							end
						end
						if (reglist.uitype == K_SLIDER) then
							kOption.disabled.slider = reglist.uidisslider;
							if (kOption.disabled.slider == nil) then
								kOption.disabled.slider = reglist.uislider;
							end
							if (kOption.disabled.slider == nil) then
								kOption.disabled.slider = reglist.uimax;
							end
							if (kOption.disabled.slider == nil) then
								kOption.disabled.slider = reglist.uimin;
							end
							if (kOption.disabled.slider == nil) then
								kOption.disabled.slider = 1;
							end
						end
						if (reglist.uitype == K_COLORPICKER) then
							kOption.disabled.color = reglist.uidiscolor;
							if (kOption.disabled.color == nil) then
								kOption.disabled.color = reglist.uicolor;
							end
						end
						if ( (reglist.uitype == K_PULLDOWN) ) then
							kOption.disabled.value = reglist.uidisstring;
							if (kOption.disabled.value == nil) then
								kOption.disabled.value = reglist.uistring;
							end
						end
						if ( (reglist.uitype == K_EDITBOX) ) then
							kOption.disabled.value = reglist.uidischoice;
							if (kOption.disabled.value == nil) then
								kOption.disabled.value = reglist.uichoice;
							end
						end
						--Setup the option dependencies
						kOption.dependencies = reglist.uidep;

						--Pull the option set from Khaos
						local optionSet = KhaosData.configurationSets[MCom.uisec];
						--Will be set to true if we need to register this set(as in, it has not yet been registered)
						local needsReg = false;
						--If the set didn't yet exist, then create it
						if (not optionSet) then
							needsReg = true;	--New set, so we need to register it
							optionSet = {	id = reglist.uisec;
														text = reglist.uiseclabel;
														helptext = reglist.uisecdesc;
														difficulty = reglist.uisecdiff;
														callback =  reglist.uiseccall;
														default = reglist.uisecdef;
														commands = reglist.uiseccom };
						end
						
						--If there is no option structure in this set yet, then make one
						if (not optionSet.options) then
							optionSet.options = {};
						end
						
						--Check that this option does not already exist
						local alreadyExists = false;
						for curOpt = 1, table.getn(optionSet.options) do
							if (optionSet.options[curOpt].id == reglist.uivar) then
								alreadyExists = true;
								break;
							end
						end
						
						--Only proceed further if the option doesn't already exist
						if (not alreadyExists) then
							--Default the option insertion position to the end of the option list
							local optionPos = table.getn(optionSet.options);
							
							--If we have a header specified, then try to find the last position after it
							--and if it doesn't exist yet.. then make it
							if (MCom.uisep) then
								local foundHeader = false;	--Set true if we find the header
								--Try to find the header
								for curOpt = 1, table.getn(optionSet.options) do
									--If we have found the header, and we have made it to the next header
									--then break here, to put the option just before this header
									if (foundHeader) then
										if (optionSet.options[curOpt].type == K_HEADER) then
											break;
										end
									end
									--If we found the header, set foundHeader
									if (optionSet.options[curOpt].id == MCom.uisep) then
										foundHeader = true;
									end
									--Set the current option position to this postition
									optionPos = curOpt;
								end
								--If we didn't find the passed header, then make it, at the last spot in the list
								if (not foundHeader) then
									--Make sure a header was passed
									if (reglist.uisep) then
										--If no label was passed for the header, use the header variable name
										if (not reglist.uiseplabel) then
											reglist.uiseplabel = reglist.uisep;
										end
										--If no description was passed for the header, use the header label
										if (not reglist.uisepdesc) then
											reglist.uisepdesc = reglist.uiseplabel;
										end
										--Make the header option structure
										local hOption = {	id = reglist.uisep;
																			text = reglist.uiseplabel;
																			helptext = reglist.uisepdesc;
																			type = K_HEADER;
																			difficulty = reglist.uisepdiff; };
										--Itterate the option position up one
										optionPos = optionPos + 1;
										--Shove the header in the last slot in the list
										table.insert(optionSet.options, optionPos, hOption);
									else
										--If we didn't find the header, and there wasn't one passed... then clean out the
										--stored header
										MCom.uisep = nil;
									end								
								end
							end
							
							--Shove the option into the next spot in the table
							table.insert(optionSet.options, optionPos + 1, kOption);

							if (needsReg) then
								--If the option set hasn't been registered yet.. then register it
								Khaos.registerOptionSet(MCom.uifolder, optionSet);
							else
								--If the option set has been registered, then we need to validate it, to make sure it's kuhl
								Khaos.validateOptionSet(optionSet);
							end
						end
					end
				end
			elseif (CosmosMaster_Init and reglist.uivar and reglist.uitype and reglist.uilabel ) then
				--Only register valid Cosmos types
				if (	(reglist.uitype == "SECTION") or (reglist.uitype == "SEPARATOR") or (reglist.uitype == "BUTTON") or
							(reglist.uitype == "CHECKBOX") or (reglist.uitype == "SLIDER") or (reglist.uitype == "BOTH")	) then
					--If we don't have Khaos, but do have Cosmos, then register for Cosmos
					--If the section has been passed, then register it
					if (reglist.uisec) then
						--If the section variable name is not prefixed with COS_ then put it on there
						if ( (string.len(reglist.uisec) < 4) or (string.sub(reglist.uisec, 1, 4) ~= "COS_") ) then
							reglist.uisec = "COS_"..reglist.uisec;
						end
						--Register the section
						Cosmos_RegisterConfiguration(reglist.uisec, "SECTION", reglist.uiseclabel, reglist.uisecdesc);
					end
					--If the separator has been passed, then register it
					if (reglist.uisep) then
						--If the separator variable name is not prefixed with COS_ then put it on there
						if ( (string.len(reglist.uisep) < 4) or (string.sub(reglist.uisep, 1, 4) ~= "COS_") ) then
							reglist.uisep = "COS_"..reglist.uisep;
						end
						--If no label is passed for the separator, then use the variable name
						if (not reglist.uiseplabel) then
							reglist.uiseplabel = reglist.uisep;
						end
						--If no description is passed for the separator, then use the label
						if (not reglist.uisepdesc) then
							reglist.uisepdesc = reglist.uiseplabel;
						end
						--Register the seperator
						Cosmos_RegisterConfiguration(reglist.uisep, "SEPARATOR", reglist.uiseplabel, reglist.uisepdesc);
					end

					--If we don't have a uifunc yet, then wrap the func
					if ( (not reglist.uifunc) and reglist.func ) then
						reglist.uifunc = function (checked, value) MCom.SetFromUI(reglist.uivar, checked, value); end;
						
						--Add the function to the list of callback functions
						if (reglist.uitype) then
							--Only do this for UI elements that have options
							if ((reglist.uitype == "CHECKBOX") or (reglist.uitype == "SLIDER") or (reglist.uitype == "BOTH") or (reglist.uitype == "BUTTON")) then
								if (not MCom.UIFuncList) then
									MCom.UIFuncList = {};
								end
								if (not MCom.UIFuncList[reglist.uivar]) then
									MCom.UIFuncList[reglist.uivar] = {};
								end
								MCom.UIFuncList[reglist.uivar].func = reglist.func;
								MCom.UIFuncList[reglist.uivar].uitype = reglist.uitype;
								MCom.UIFuncList[reglist.uivar].hasbool = reglist.hasbool;
							end
						end
					end
					
					--Convert the default check state to Cosmos style
					if ( reglist.uicheck and ( (reglist.uicheck == 1) or (reglist.uicheck == true) ) ) then
						reglist.uicheck = 1;
					else
						reglist.uicheck = 0;
					end
					
					--Register with Cosmos if available
					Cosmos_RegisterConfiguration(reglist.uivar, reglist.uitype, reglist.uilabel, reglist.uidesc,
						reglist.uifunc,	reglist.uicheck, reglist.uislider, reglist.uimin, reglist.uimax, reglist.uitext,
						reglist.uistep, reglist.uitexton, reglist.uisuffix, reglist.uimul
					);
				end
			end
			
			--If we have enough data to register a slash command, then do it
			--We need to make sure to pass the right ordered var data to the function
			local comVar = reglist.varbool;
			local comVarMulti = reglist.varnum;
			if (regtype == MCOM_STRINGT) then
				comVarMulti = reglist.varstring;
			elseif (regtype == MCOM_CHOICET) then
				comVarMulti = reglist.varchoice;
			elseif (regtype == MCOM_COLORT) then
				comVarMulti = reglist.varcolor;
			end
			if (not comVar) then
				comVar = comVarMulti;
				comVarMulti = nil;
			end
			if (reglist.command and reglist.func) then
				--If no command help was passed, but a ui description was, then use the ui description
				if ( ( not reglist.bomhelp ) and ( reglist.uidesc ) ) then
					reglist.bomhelp = reglist.uidesc;
				end
				MCom.addSlashCom(reglist.command, reglist.func, reglist.comaction, reglist.comsticky, reglist.comhelp, regtype, reglist.uisec, reglist.uivar, comVar, comVarMulti, reglist.varmin, reglist.varmax, reglist.commul, reglist.cominmul, reglist.hasbool, reglist.choices, reglist.multichoice, reglist.hasopacity, reglist.extrahelp);
			end
			--If we have enough data to register a super slash command, then do it
			if (reglist.supercom) then
				MCom.addSlashSuperCom(reglist.supercom, reglist.comaction, reglist.comsticky, reglist.comhelp, reglist.extrahelp);
			end
			--If we have enough data to register a sub slash command, then do it
			if (reglist.supercom and reglist.subcom and reglist.func) then
				--If no sub command help was passed, but a ui description was, then use the ui description
				if ( ( not reglist.subhelp ) and ( reglist.uidesc ) ) then
					reglist.subhelp = reglist.uidesc;
				end
				MCom.addSlashSubCom(reglist.supercom, reglist.subcom, reglist.func, reglist.subhelp, regtype, reglist.uisec, reglist.uivar, comVar, comVarMulti, reglist.varmin, reglist.varmax, reglist.commul, reglist.cominmul, reglist.hasbool, reglist.choices, reglist.multichoice, reglist.hasopacity);
			end

			--If we should be adding an info option, then handle this now
			if (reglist.infotext) then
				--Setup a function to display addon information, if data is available for it
				local infofunc = nil;
				if (reglist.infotext) then
					--If reglist.infotext isn't already a table, then turn it into one
					if (type(reglist.infotext) ~= "table") then
						reglist.infotext = { reglist.infotext };
					end
					--Setup a default info title if we dont have one
					local curInfoTitle = reglist.infotitle;
					if (not curInfoTitle) then
						curInfoTitle = MCOM_HELP_GENERIC_TITLE;
						if (reglist.name) then
							curInfoTitle = string.format(MCOM_HELP_TITLE, reglist.name);
						end
					end
				
					--If this is not a boolean, then add the slash command info to the end of the text as a new page
					if ( type(reglist.infotext) ~= "boolean" ) then
						infofunc = function ()
							--Get the info text and title
							local infotext = MCom.table.copy(reglist.infotext);
							local infotitle = curInfoTitle;
							--If the text isn't a table turn it into one
							if (type(infotext) ~= "table" ) then
								infotext = { infotext };
							end
							if (reglist.supercom) then
								--Add the slash command info on to it
								infotext[table.getn(infotext) + 1] = MCom.PrintSlashCommandInfo(MCom.getComID(reglist.supercom), true);
							end
							--Show the text frame
							MCom.textFrame( { text = infotext; title = infotitle; } );
						end;
					elseif ( reglist.supercom ) then
						infofunc = function ()
							--Set the text as the slash command info
							local infotext = MCom.PrintSlashCommandInfo(MCom.getComID(reglist.supercom), true);
							local infotitle = curInfoTitle;
							--Show the text frame
							MCom.textFrame( { text = infotext; title = infotitle; } );
						end;
					end
				end
				
				--If we have an info function, then add options to access it
				if (infofunc) then
					--Use the generic description
					local infoDesc = MCOM_HELP_GENERIC;
					--If a name has been passed for this mod, then use it in the description
					if (reglist.name) then
						infoDesc = string.format(MCOM_HELP_CONFIG_INFO, reglist.name);
					end
					--If we have Khaos or Cosmos then register with them
					if (Khaos or CosmosMaster_Init and reglist.name) then
						--Setup the difficulty of the help button
						local infodiff = reglist.uisecdiff;
						if (not infodiff) then
							infodiff = reglist.uidiff;
						end
						if (not infodiff) then
							infodiff = 1;
						end
						--Setup the name to display
						local infoName = string.format(MCOM_HELP_CONFIG, reglist.name);
						--Register the option
						MCom.registerSmart( {
							uivar = reglist.name.."MComInfo";									--The option name for the UI
							uitype = K_BUTTON;																--The option type for the UI
							uilabel = infoName;																--The label to use for the checkbox in the UI
							uidesc = infoDesc;																--The description to use for the checkbox in the UI
							uidiff = infodiff;																--The option's difficulty in Khaos
							uifunc = infofunc;																--The function to call
							uitext = MCOM_HELP_GENERIC_TITLE;									--The text to show on the button
						} );
					end
					--Register the sub slash command
					if ( reglist.supercom ) then
						MCom.registerSmart( {
							supercom = reglist.supercom;
							subcom = MCOM_HELP_COMMAND;
							subhelp = infoDesc;
							comtype = MCOM_SIMPLET;
							func = infofunc;
						} );
					end
				end
			end
		end
	end;
	
	--[[
	 	getStringVar ( string value )
		 	Accepts a variable as a string, and returns the value.
		 	However this can parse complex variable names that contain .
		 	such as "Something.Variable"
		 	
		 	It does not handle "Something['Variable']".. Just use the .
		 	format instead.  This also works for number indexes.
		
		Args:
		 	varString - the variable to get, encapsulated in a string, ex:
		 	"Something.Variable.Monkey.Hippo"
	 
		Returns:
		 	the contents of the variable in the passed string
	]]--
	MCom.getStringVar = function (varString)
		if (Sea and Sea.util and Sea.util.getValue) then
			return Sea.util.getValue(varString);
		else
			--Legorols get string var code, no GCs, and no need to store each entry
			if ( type(varString) ~= "string" ) then
				return nil;
			end;
			
			-- Table we reuse with calls to split
			if ( not MCom.valueTable ) then
				MCom.valueTable = {};
			end
			
			-- Split the variable name at ".", first field is a global name
			local fields = MCom.util.split(varString, ".", MCom.valueTable);
			local encloser, member = getglobal(fields[1]), fields[2];
			
			-- If encloser is the only field, it's a global, return its value
			if ( not member ) then
				return encloser;
			end
			
			-- If there are subsequent fields present, get to deeper levels
			for i = 3, table.getn(fields) do
				if ( type(encloser) ~= "table" ) then
					return nil;
				end
				encloser = encloser[member];
				member = fields[i];
			end
			
			-- Encloser is now the last but one field, member is the last field
			if ( type(encloser) == "table" ) then
				return encloser[member];
			end
			-- Error occured, encloser is not a table, return nil
		end
	end;
	--Alias for compatability
	MCom.stringToVar = MCom.getStringVar;
	
	--[[
	 	stringVarToGetFunc ( string varString )
		 	Accepts a variable as a string, and returns a function that
		 	returns the value.
		 	However this can parse complex variable names that contain .
		 	such as "Something.Variable"
		 	
		 	This is alot like getStringVar.  However, getStringVar has to
		 	generate several objects that will need to be garbage
		 	collected.  The function returned by stringVarToFunc does
		 	not generate any amount of GCs worth worying about.  So if
		 	you are needing to do this very often, like OnUpdate, then
		 	it is best to use this function to convert to a function,
		 	and simply call that functin to get the data you need.		 	

		 	It does not handle "Something['Variable']".. Just use the .
		 	format instead.  This also works for number indexes.
		
		Args:
		 	varString - the variable to get, encapsulated in a string, ex:
		 	"Something.Variable.Monkey.Hippo"
	 
		Returns:
		 	a function that when called will return the data in the passed variable
	]]--
	MCom.stringVarToGetFunc = function (varString)
		if ( type(varString) == "string" ) then
			--Seperate the variable by the .'s into a list
			local valList = MCom.util.split(varString, ".");
			--The function we will return
			local varFunc;
			
			--Only proceed if we have a variable to work with
			if (valList and valList[1]) then
				--If it's a table make it a function that will parse the parts
				if (getn(valList) > 1) then
					--Create the function
					varFunc = function ()
						--Get the global variable
						local value = getglobal(valList[1]);
						--Go through each entry in the table and get that variable
						for curPart = 2, getn(valList) do
							--Only get the variable if it is a table
							if ( ( type(value) == "table" ) and value[ valList[curPart] ] ) then
								--Get the variable
								value = value[ valList[curPart] ];
							else
								--Something was invalid, return nil
								return;
							end
						end
						--We got the value, so return it
						return value;
					end;
				else
					--This is a simple variable, so just return the global
					varFunc = function ()
						return getglobal(valList[1]);
					end;
				end
			end
			--Return the function
			return varFunc;
		end
	end;
	
	--[[
	 	setStringVar ( string varString, value )
		 	Sets a variable, specified by a string, to a value.
		 	However this can parse complex variable names that contain .
		 	such as "Something.Variable"
		 	
		 	It does not handle "Something['Variable']".. Just use the .
		 	format instead.  This also works for number indexes.
		
		Args:
		 	varString - the variable to set, encapsulated in a string, ex:
		 		"Something.Variable.Monkey.Hippo"
		 	value - the value to set the variable to, can be any type
	]]--
	MCom.setStringVar = function (varString, value)
		if (Sea and Sea.util and Sea.util.setValue) then
			return Sea.util.setValue(varString, value);
		else
			--Legorols set string var code, no GCs, and no need to store each entry
			if ( type(varString) ~= "string" ) then
				return false;
			end;
			
			-- Table we reuse with calls to split
			if ( not MCom.valueTable ) then
				MCom.valueTable = {};
			end
			
			-- Split the variable name at ".", first field is a global name
			local fields = MCom.util.split(varString, ".", MCom.valueTable);
			local encloser, member = getglobal(fields[1]), fields[2];
			
			-- If encloser is the only field, variable is a global, set its value
			if ( not member ) then
				setglobal(varString, value);
				return true;
			end
			
			-- If there are subsequent fields present, get to deeper levels
			for i = 3, table.getn(fields) do
				if ( type(encloser) ~= "table" ) then
					return false;
				end
				encloser = encloser[member];
				member = fields[i];
			end
			
			-- Encloser is now the last but one field, member is the last field
			if ( type(encloser) == "table" ) then
				encloser[member] = value;
				return true;
			end
			
			-- Error occured, encloser is not a table
			return false;
		end
	end;
	
	--[[
	 	stringVarToSetFunc ( string varString )
		 	Returns a function that can be used to set the passed string
		 	to a value.  However this can parse complex variable names
		 	that contain . such as "Something.Variable"
		 	
		 	This is alot like setStringVar.  However, setStringVar has to
		 	generate several objects that will need to be garbage
		 	collected.  The function returned by stringVarToSetFunc does
		 	not generate any amount of GCs worth worying about.  So if
		 	you are needing to do this very often, like OnUpdate, then
		 	it is best to use this function to convert to a function,
		 	and simply call that functin to set the data you need.		 	

		 	It does not handle "Something['Variable']".. Just use the .
		 	format instead.  This also works for number indexes.
		
		Args:
		 	varString - the variable to set, encapsulated in a string, ex:
		 	"Something.Variable.Monkey.Hippo"
	 
		Returns:
		 	function ( number value) - a function that when called will
		 	set the string passed here, to	the value passed to the function.
	]]--
	MCom.stringVarToSetFunc = function (varString)
		if ( type(varString) == "string" ) then
			--Seperate the variable by the .'s into a list
			local valList = MCom.util.split(varString, ".");
			--The function we will return
			local varFunc;
			
			--Only proceed if we have a variable to work with
			if (valList and valList[1]) then
				--If it's a table make it a function that will parse the parts
				if (getn(valList) > 1) then
					--Create the function
					varFunc = function (value)
						--Get the global variable
						local var = getglobal(valList[1]);
						--Go through each entry in the table and get that variable
						for curPart = 2, getn(valList) do
							--If we have reached the last entry in the list, then set it
							if ( curPart == getn(valList) ) then
								if ( type(var) == "table" ) then
									var[ valList[curPart] ] = value;
								else
									return;
								end
							else
								--Only get the variable if it is a table
								if ( ( type(var) == "table" ) and var[ valList[curPart] ] ) then
									--Get the variable
									var = var[ valList[curPart] ];
								else
									--Something was invalid, return nil
									return;
								end
							end
						end
					end;
				else
					--This is a simple variable, so just return the global
					varFunc = function (value)
						setglobal(valList[1], value);
					end;
				end
			end
			--Return the function
			return varFunc;
		end
	end;
	
	--[[
	 	updateVar ( string varname, value [, string vartype, number varmin, number varmax] )
		 	updates the variable contained in varname, to value.
		 	Handles things different based on the type of var varname is.
		 	If it should be a bool, then it only accepts 1 and 0, or -1 to invert the current setting.
		 	For number, it makes sure it is in the range varmin and varmax.
		
		Args:
		 	varname - name of the variable to update, wrapped in a string, can be complex like "Something.Variable"
		 	value - what to set it to, should be 1, 0, or -1 for bool, any number for number type, or any string for string type
	
		Optional: 
		 	vartype - should be one of the MCOM_ types
		 	varmin - specifies the minimum value for a number type
		 	varmax - specifies the maximum value for a number type
	 
		Returns:
		 	if the value changed from its origional value, returns true
	]]--
	MCom.updateVar = function (varname, value, vartype, varmin, varmax)
		if (varname and value) then
			-- store the old value of the variable
			local oldValue = MCom.getStringVar(varname);

			if (vartype == MCOM_BOOLT) then
				--If a -1 is passed, invert the value
				if (value and (value == -1)) then
					if (oldValue == 1) then
						value = 0;
					else
						value = 1;
					end
				end
				
				--Update the value
				if (value and (value==1)) then
					value = 1;
				else
					value = 0;
				end
			elseif (vartype == MCOM_NUMT) then
				--if its a number and max/min were specified, make sure it's in range
				if (varmin and (value < varmin)) then
					value = varmin;
				end
				if (varmax and (value > varmax)) then
					value = varmax;
				end
			end
			
			local didUpdate = false;
			if (vartype == MCOM_COLORT) then
				--If we don't have an old value, then make one
				if ( not oldValue ) then
					didUpdate = true;
					oldValue = {};
				end
				--if its a color then make sure the color parts are in range
				if (value.r) then
					if (value.r > 1) then
						value.r = 1;
					end
					if (value.r < 0) then
						value.r = 0;
					end
					if (oldValue.r ~= value.r) then
						didUpdate = true;
					end
				else
					value.r = oldValue.r;
				end
				if (value.g) then
					if (value.g > 1) then
						value.g = 1;
					end
					if (value.g < 0) then
						value.g = 0;
					end
					if (oldValue.g ~= value.g) then
						didUpdate = true;
					end
				else
					value.g = oldValue.g;
				end
				if (value.b) then
					if (value.b > 1) then
						value.b = 1;
					end
					if (value.b < 0) then
						value.b = 0;
					end
					if (oldValue.b ~= value.b) then
						didUpdate = true;
					end
				else
					value.b = oldValue.b;
				end
				if (value.opacity) then
					if (value.opacity > 1) then
						value.opacity = 1;
					end
					if (value.opacity < 0) then
						value.opacity = 0;
					end
					if (oldValue.opacity ~= value.opacity) then
						didUpdate = true;
					end
				else
					value.opacity = oldValue.opacity;
				end
			else	
				--if the value changed, return true
				if (value ~= oldValue) then
					didUpdate = true;
				end
			end
			
			if (didUpdate) then
				MCom.setStringVar(varname, value);
				return true;
			end
		end
	end;

	--[[
	 	printStatus ( string text, [string/number/bool] value, bool isbool, bool show )
		 	If Cosmos is not found printStatus will print out a status message, intended to let user know when an option has
		 	been changed, when there is no GUI available.
		
		Args:
		 	text -		the text to print, this can include a %s, and value(or enabled/disabled for bool) will be put in place of the %s
		 						Ex: "This option has been %s" for bool, or "This option has been set to %s" for number or string
	
		Optional: 
			value -		what value to display, can be a string, a number, or a bool
		 	isbool -	if this is true, then the value will be treated as a bool, and if true(or 1) then the %s will contain
		 						the world "Enabled" or "Disabled" for false(or 0)
		 	show - if this is true, then the text will be printed whether there is a UI or not
	]]--
	MCom.printStatus = function (text, value, isbool, show)
		if ( ( not MCom.hasUI() ) or show ) then
			--Convert to string
			if (type(value) == "number") then
				value = tostring(value);
			end
			--If it's boolean or nill convert to 1 or 0
			if ((type(value) == "boolean") or (type(value) == "nil")) then
				if (value) then
					value = "1";
				else
					value = "0";
				end
			end
			if (type(value) == "string") then
				local outText = value;
				--If it's a bool convert to Enabled/Disabled
				if (isbool) then
					outText = MCOM_CHAT_DISABLED;
					if (value == "1") then
						outText = MCOM_CHAT_ENABLED;
					end
				end
				--Format and print the message
				local msg = string.format(text, outText);
				MCom.IO.printc(ChatTypeInfo["SYSTEM"], msg);
			end
		end	
	end;
	
	--[[
	 	hasUI ( )
		 	Tells whether or not a UI, like Cosmos or Khaos is present.
	 
		Returns:
		 	true - there is a UI
		 	false - there is no UI
	]]--
	MCom.hasUI = function (varString)
		local hasUI = true;
		if ( ( CosmosMaster_Init == nil ) and ( Khaos == nil ) ) then 
			hasUI = false;
		end
		
		return hasUI;
	end;
	
	--[[
	 	updateUI ( string slashcom, string subcom )
		 	Updates the UI(Cosmos or Khaos) with the values of the variable associated with the slash command
		 	passed to the function.  If this is done on a super slash command, then all sub commands
		 	will be updated, unless a specific on is specified.
		
		Args:
		 	slashcom - The slash commmand, or super slash command to update the variable from.
	
		Optional: 
		 	subcom -	If slashcom is a super slash command, you can use this to specify which slash
		 						command to update.
	]]--
	MCom.updateUI = function (slashcom, subcom)
		if (MCom.SlashComs) then
			--Get the command IDs
			local comid, subcomid = MCom.getComID(slashcom, subcom);
			if (comid) then
				--Get the command
				local command = MCom.SlashComs[comid];
				--If we have a subcommand, then lets use it
				if (subcomid) then
					command = { command.commands[subcomid] };
				elseif (command.commands) then
					command = command.commands;
				end
				
				--If command isnt a table, then turn it into one
				if (type(command) ~= "table") then
					command = { command };
				end
				local didUpdate = nil;
				if (KhaosData and KhaosData.configurationSets) then
					--If we have Khaos around, then lets update for it
					local curCom = nil;
					local newValMulti = nil;
					local newVal = nil;
					--Go trhough all commands and update them
					for curComID in command do
						--Grab the current command structure
						curCom = command[curComID];
						if (curCom.uisec and KhaosData.configurationSets[curCom.uisec] and curCom.uivar and curCom.comvar) then
							--get the value of the variable
							newVal = MCom.getStringVar(curCom.comvar);
							if (newVal) then
								--Grab the second variable, if there is one
								newValMulti = MCom.getStringVar(curCom.comvarmulti);
								
								--Deault param to change is value
								local param = "value";
								--If it's a boolean, or we have a boolean as well.. then update the boolean part
								if ( (curCom.comtype == MCOM_BOOLT) or (curCom.comtype == MCOM_MULTIT) or curCom.hasbool) then
									--Make sure the value is in true/false form
									if (newVal == 1) then
										newVal = true;
									else
										newVal = false;
									end
									--Update the value
									Khaos.setSetKeyParameter(curCom.uisec, curCom.uivar, "checked", newVal);
								end
								--If it isn't a boolean type then proccess either the other types, or secondary part
								if ( curCom.comtype ~= MCOM_BOOLT ) then
									--If we have a second part variable, then use it now
									if (newValMulti) then
										newVal = newValMulti;
									end
									
									--Handle number types as sliders
									if ( (curCom.comtype == MCOM_NUMT) or (curCom.comtype == MCOM_MULTIT) ) then
										param = "slider";
									end
									
									--Handle color types as color pickers
									if (curCom.comtype == MCOM_COLORT) then
										param = "color";
									end
									
									--Update the value
									Khaos.setSetKeyParameter(curCom.uisec, curCom.uivar, param, newVal);
								end
								didUpdate = true;
							end
						end
					end
					--If we updated something, then update the Khaos display
					if (didUpdate) then
						Khaos.refresh();
					end
				else
					--We only need to update Cosmos if it exists
					if (CosmosMaster_Init) then
						local curCom = nil;
						local newValMulti = nil;
						local newVal = nil;
						--Go trhough all commands and update them
						for curComID in command do
							curCom = command[curComID];
							if (curCom.uivar and curCom.comvar) then
								--get the value of the variable
								newVal = MCom.getStringVar(curCom.comvar);
								if (newVal) then
									newValMulti = MCom.getStringVar(curCom.comvarmulti);
									if ((curCom.comtype ~= MCOM_MULTIT) or ((curCom.comtype == MCOM_MULTIT) and newValMulti)) then
										--if its a boolean, then set the checkbox
										if ((curCom.comtype == MCOM_BOOLT) or (curCom.comtype == MCOM_MULTIT)) then
											Cosmos_UpdateValue(curCom.uivar, CSM_CHECKONOFF, newVal);
											didUpdate = true;
										end
										--if its a number, then set the slider
										if ((curCom.comtype == MCOM_NUMT) or (curCom.comtype == MCOM_MULTIT)) then
											if (curCom.comtype == MCOM_MULTIT) then
												newVal = newValMulti;
											end
											Cosmos_UpdateValue(curCom.uivar, CSM_SLIDERVALUE, newVal);
											didUpdate = true;
										end
									end
								end
							end
						end
						--If we updated something, then update the Cosmos display
						if (didUpdate) then
							CosmosMaster_DrawData();
						end
					end
				end
			end
		end
	end;
	
	
	--[[
	 	getComID ( [string/number] slashcom, string subcom )
		 	Gets the ID of the slashcom in the slash commands list, as well as a
		 	sub slash command, if you specify that you want a sub commands ID.
		
		Args:
		 	slashcom -	The slash commmand, or super slash command to get the ID of.
		 							If you pass the ID itself, that ID will be used when getting
		 							the sub command.  This can be a list of commands, instead of
		 							just one, in which case, it will return the first one in the
		 							list that it finds. Don't forget the / ex. "/command"
		Optional:
		 	slashcom -	The sub command you want to get, if you want one.  This can
		 							be a list instead of just one command, the first one found
		 							will be used.
		 	
		Returns:
			commandid - If it finds the command, it returns the ID, otherwise it returns nil.
			subcommand - If it finds the subcommand it also returns that, otherwise, nil.
	]]--
	MCom.getComID = function (command, subcom)
		local commandid = nil;
		local subcommandid = nil;
		if (MCom.SlashComs) then
			--If the ID was passed, then use it
			if ((type(command) == "number") and MCom.SlashComs[command]) then
				commandid = command;
			else
				--make sure command is a table
				if (type(command) ~= "table") then
					command = {command};
				end
				--find the command in the table
				for curCom in command do
					for curListCom in MCom.SlashComs do
						if (MCom.SlashComs[curListCom].basecommand) then
							for curBaseCom in MCom.SlashComs[curListCom].basecommand do
								if (MCom.SlashComs[curListCom].basecommand[curBaseCom] == command[curCom]) then
									commandid = curListCom;
									break;
								end
							end
							if (commandid) then
								break;
							end
						end
					end
				end
			end			
			
			if (commandid and subcom) then
				--make sure sub command is a table
				if (type(subcom) ~= "table") then
					subcom = {subcom};
				end
				--Try and find the subcommand in the list
				for curSub in subcom do
					for curCom in MCom.SlashComs[commandid].commands do
						if (MCom.SlashComs[commandid].commands[curCom].command) then
							for curComCom in MCom.SlashComs[commandid].commands[curCom].command do
								if (MCom.SlashComs[commandid].commands[curCom].command[curComCom] == subcom[curSub]) then
									subcommandid = curCom;
									break;
								end
							end
							if (subcommandid) then
								break;
							end
						end
					end
				end
			end			
		end
		return commandid, subcommandid;
	end;

	--[[
	 	saveConfig ( {reglist} )
	 		This will store all of the variables you want into a per realm, per character table(MComStorage) inside the passed variable.
	 		This is meant to facilatate storing/loading variables on a per realm, per character basis.  You must register the passed
	 		variable for saving, yourself.
	 		
	 	Args:
	 		reglist - This contains all options for this save procedure
	 			{
	 			Required:
	 				(string) configVar -	The name of the config variable, this should have been registered for save by you, and must be a table with a simple
	 															variable name.  IE no .'s or []'s
	 			
	 			Optional:
	 				(string) storeVar -	The name of the variable to load/store the data in.  If not passed then configVar.MComStorage is used.  Remember to register
	 														it for saving.
	 				(string) exactVar -	If you pass this, then data will be stored in this var, regardless of realm/character.  It will go into this exact var.  This
	 														takes precidence over storeVar.
	 				(string) realm	- This allows you to specify the realm to store to, if not passed, then the current realm will be used.
	 				(string) character	- This allows you to specify the character to store to, if not passed, then the current character will be used.
	 				NOTE: For all the following, this will only work on root level variables.  I.E. Whatever_Config.Variable.  For this you would pass "Variable"
	 				(string or table) saveList -	The names of all variables in the config to be stored, if this is not passed, then MCom will try to store
	 																			all variables except the MComStorage variable.
	 				(string or table) ignoreList - The names of any variables that you want MCom to not store.
	 				(string or table) uiList -	These variables will only be stored if there is no UI available.  Any options that you have the UI controlling
	 																		should be included in here, so you can leave it up to the UI to properly load/save them.
	 				(string or table) nonUIList -	If this list is declared, then uiList will be ignored, and all variables, except these, will be considered UI
	 																			variables.
	 				(string or table) forceList -	After going through the normal vars, MCom will go through and save these vars, even if they are nil.  This list
	 																			is affected by the rules set by the above lists as well.
	 			}
	 	
	 	Returns:
	 			true - Some data was saved
	 			false - No data was saved
	]]--
	MCom.saveConfig = function ( reglist )
		--We will set this true, if we saved any data
		local didSave = false;
		--Make sure we have the required info in the right form
		if ( reglist and ( type(reglist) == "table" ) and reglist.configVar ) then
			--Get the config variable table
			local varTable = MCom.getStringVar(reglist.configVar);
			--Only proceed if the config variable is a table
			if ( type(varTable) == "table" ) then
				--Get the realm and character name
				local realm = reglist.realm;
				if (not realm) then
					realm = GetCVar("RealmName");
				end
				local character = reglist.character;
				if (not character) then
					character = UnitName("player")
				end
				
				--Setup the variable to store data in.
				local storeVar = MCom.getStringVar(reglist.exactVar);
				--If we don't have an exactVar and we have the server and character name then generate the storeVar
				if ( (not storeVar) and realm and character and ( ( character ~= UKNOWNBEING ) and ( character ~= UNKNOWNOBJECT ) ) ) then
					--Get the storage var if one was passed
					storeVar = MCom.getStringVar(reglist.storeVar);
					if (not storeVar) then
						--If the MComStorage variable isn't there yet, or isn't a table, then set it as an empty table
						if (type(varTable.MComStorage) ~= "table") then
							varTable.MComStorage = {};
						end
						storeVar = varTable.MComStorage;
					end
					
					--If this realm doesn't exist, then create it
					if (not storeVar[realm]) then
						storeVar[realm] = {};
					end
					--If this character doesn't exist, then create it
					if (not storeVar[realm][character]) then
						storeVar[realm][character] = {};
					end
					--Set storeVar to use the current realm/char
					storeVar = storeVar[realm][character];
				end
				
				--If we have the variable to store to, then we are good to go
				if (storeVar) then
					--Go through all the variables in the table
					for curVar in varTable do
						--Ignore the MComStorage variable
						if (curVar ~= "MComStorage") then
							--This will become true if we shouldn't store this variable
							local doIgnore = false;
							
							--If we have a list of vars to save, then go through them, and if this var is not in there, then ignore it
							if (reglist.saveList) then
								--Default to ignoring now
								doIgnore = true;
								--Make sure the saveList is a table
								if (type(reglist.saveList) ~= "table") then
									reglist.saveList = { reglist.saveList };
								end
								--Go through the list and see if we find the variable, if we do, then we don't ignore it
								for i, curSaveCheck in reglist.saveList do
									if (curVar == curSaveCheck) then
										doIgnore = false;
										break;
									end
								end
							end
							
							--If we are supposed to ignore this guy, then do so now
							if (not doIgnore) then
								--If we have a list of vars to ignore, then go through them, and if this var is in there, then ignore it
								if (reglist.ignoreList) then
									--Make sure the ignoreList is a table
									if (type(reglist.ignoreList) ~= "table") then
										reglist.ignoreList = { reglist.ignoreList };
									end
									--Go through the list and see if we find the variable, if we do, then ignore it
									for i, curIgnoreCheck in reglist.ignoreList do
										if (curVar == curIgnoreCheck) then
											doIgnore = true;
											break;
										end
									end
								end
								
								--If we are supposed to ignore this guy, then do so now
								if (not doIgnore) then
									if (reglist.nonUIList) then
										--Since these are UI vars, then we should only be ignoring them if the UI is around
										if ( MCom.hasUI() ) then
											--Unless we find this in the list, we should be ignoring it
											doIgnore = true;
											--Make sure the nonUIList is a table
											if (type(reglist.nonUIList) ~= "table") then
												nonUIList = { reglist.nonUIList };
											end
											--Go through the list and see if we find the variable, if we do, then don't ignore it
											for i, curUICheck in reglist.nonUIList do
												if (curVar == curUICheck) then
													doIgnore = false;
													break;
												end
											end
										end
									else
										if (reglist.uiList) then
											--Since these are UI vars, then we should only be ignoring them if the UI is around
											if ( MCom.hasUI() ) then
												--Make sure the uiList is a table
												if (type(reglist.uiList) ~= "table") then
													uiList = { reglist.uiList };
												end
												--Go through the list and see if we find the variable, if we do, then ignore it
												for i, curUICheck in reglist.uiList do
													if (curVar == curUICheck) then
														doIgnore = true;
														break;
													end
												end
											end
										end
									end
									
									--If we are supposed to ignore this guy, then do so now
									if (not doIgnore) then
										--Store the variable
										storeVar[curVar] = varTable[curVar];
										--Set that we saved data
										didSave = true;
									end
								end
							end
						end
					end
					
					--If a forced list has been passed, then go through it
					if (reglist.forceList) then
						--Make sure it is a table
						if ( type(reglist.forceList) ~= "table" ) then
							reglist.forceList = { reglist.forceList };
						end
						--Go through all the variables in the table
						for i, curVar in reglist.forceList do
							--Ignore the MComStorage variable
							if (curVar ~= "MComStorage") then
								--This will become true if we shouldn't store this variable
								local doIgnore = false;
								
								--If we have a list of vars to save, then go through them, and if this var is not in there, then ignore it
								if (reglist.saveList) then
									--Default to ignoring now
									doIgnore = true;
									--Make sure the saveList is a table
									if (type(reglist.saveList) ~= "table") then
										reglist.saveList = { reglist.saveList };
									end
									--Go through the list and see if we find the variable, if we do, then we don't ignore it
									for i, curSaveCheck in reglist.saveList do
										if (curVar == curSaveCheck) then
											doIgnore = false;
											break;
										end
									end
								end
								
								--If we are supposed to ignore this guy, then do so now
								if (not doIgnore) then
									--If we have a list of vars to ignore, then go through them, and if this var is in there, then ignore it
									if (reglist.ignoreList) then
										--Make sure the ignoreList is a table
										if (type(reglist.ignoreList) ~= "table") then
											reglist.ignoreList = { reglist.ignoreList };
										end
										--Go through the list and see if we find the variable, if we do, then ignore it
										for i, curIgnoreCheck in reglist.ignoreList do
											if (curVar == curIgnoreCheck) then
												doIgnore = true;
												break;
											end
										end
									end
									
									--If we are supposed to ignore this guy, then do so now
									if (not doIgnore) then
										if (reglist.nonUIList) then
											--Since these are UI vars, then we should only be ignoring them if the UI is around
											if ( MCom.hasUI() ) then
												--Unless we find this in the list, we should be ignoring it
												doIgnore = true;
												--Make sure the nonUIList is a table
												if (type(reglist.nonUIList) ~= "table") then
													nonUIList = { reglist.nonUIList };
												end
												--Go through the list and see if we find the variable, if we do, then don't ignore it
												for i, curUICheck in reglist.nonUIList do
													if (curVar == curUICheck) then
														doIgnore = false;
														break;
													end
												end
											end
										else
											if (reglist.uiList) then
												--Since these are UI vars, then we should only be ignoring them if the UI is around
												if ( MCom.hasUI() ) then
													--Make sure the uiList is a table
													if (type(reglist.uiList) ~= "table") then
														uiList = { reglist.uiList };
													end
													--Go through the list and see if we find the variable, if we do, then ignore it
													for i, curUICheck in reglist.uiList do
														if (curVar == curUICheck) then
															doIgnore = true;
															break;
														end
													end
												end
											end
										end
										
										--If we are supposed to ignore this guy, then do so now
										if (not doIgnore) then
											--Store the variable
											storeVar[curVar] = varTable[curVar];
											--Set that we saved data
											didSave = true;
										end
									end
								end
							end
						end
					end
				end
			end
		end
		--Return if we saved data or not
		return didSave;
	end;

	--[[
	 	loadConfig ( {reglist} )
	 		This will load all variables stored in the passed table in MComStorage.  This only works on variables that have stored the data using
	 		MCom.saveConfig
	 		
	 	Args:
	 		reglist - This contains all options for this load procedure
	 			{
	 			Required:
	 				(string) configVar -	The name of the config variable, this should have been registered for save by you, and must be a table with a simple
	 															variable name.  IE no .'s or []'s
	 			
	 			Optional:
	 				(string) storeVar -	The name of the variable to load/store the data in.  If not passed then configVar.MComStorage is used.  Remember to register
	 														it for saving.
	 				(string) exactVar -	If you pass this, then data will be loaded from this var, regardless of realm/character.  It will get from this exact var.  This
	 														takes precidence over storeVar.
	 				(string) realm	- This allows you to specify the realm to load from, if not passed, then the current realm will be used.
	 				(string) character	- This allows you to specify the character to load from, if not passed, then the current character will be used.
	 				NOTE: For all the following, this will only work on root level variables.  I.E. Whatever_Config.Variable.  For this you would pass "Variable"
	 				(string or table) loadList -	The names of all variables in the config to be loaded, if this is not passed, then MCom will try to load
	 																			all variables except the MComStorage variable.
	 				(string or table) ignoreList - The names of any variables that you want MCom to not load.
	 				(string or table) uiList -	These variables will only be loaded if there is no UI available.  Any options that you have the UI controlling
	 																		should be included in here, so you can leave it up to the UI to properly load/save them.
	 				(string or table) nonUIList -	If this list is declared, then uiList will be ignored, and all variables, except these, will be considered UI
	 																			variables.
	 				(string or table) forceList -	After going through the normal vars, MCom will go through and load these vars, even if they are nil.
	 																			is affected by the rules set by the above lists as well.
	 			}
	 		
	 		Returns:
	 			true - Some data was loaded
	 			false - No data was loaded
	]]--
	MCom.loadConfig = function ( reglist )
		--We will set this true, if we loaded any data
		local didLoad = false;
		--Make sure we have the required info in the right form
		if ( reglist and ( type(reglist) == "table" ) and reglist.configVar ) then
			--Get the config variable table
			local varTable = MCom.getStringVar(reglist.configVar);
			--Only proceed if the config variable is a table
			if ( type(varTable) == "table" ) then
				
				
				--Get the realm and character name
				local realm = reglist.realm;
				if (not realm) then
					realm = GetCVar("RealmName");
				end
				local character = reglist.character;
				if (not character) then
					character = UnitName("player")
				end
				
				--Setup the variable to load data from
				local storeVar = MCom.getStringVar(reglist.exactVar);
				--If we don't have an exactVar and we have the server and character name then generate the storeVar
				if ( (not storeVar) and realm and character and ( ( character ~= UKNOWNBEING ) and ( character ~= UNKNOWNOBJECT ) ) ) then
					--Get the storage var if one was passed
					storeVar = MCom.getStringVar(reglist.storeVar);
					if (not storeVar) then
						--If the MComStorage variable isn't there yet, or isn't a table, then set it as an empty table
						if (type(varTable.MComStorage) ~= "table") then
							varTable.MComStorage = {};
						end
						storeVar = varTable.MComStorage;
					end
					
					--If this realm doesn't exist, then create it
					if (not storeVar[realm]) then
						storeVar[realm] = {};
					end
					--If this character doesn't exist, then create it
					if (not storeVar[realm][character]) then
						storeVar[realm][character] = {};
					end
					--Set storeVar to use the current realm/char
					storeVar = storeVar[realm][character];
				end
				
				--If we have the variable to load from, then we are good to go
				if (storeVar) then
					--Go through all the variables in the table
					for curVar in storeVar do
						--This will become true if we shouldn't load this variable
						local doIgnore = false;
						
						--If we have a list of vars to load, then go through them, and if this var is not in there, then ignore it
						if (reglist.loadList) then
							--Default to ignoring now
							doIgnore = true;
							--Make sure the loadList is a table
							if (type(reglist.loadList) ~= "table") then
								reglist.loadList = { reglist.loadList };
							end
							--Go through the list and see if we find the variable, if we do, then we don't ignore it
							for i, curLoadCheck in reglist.loadList do
								if (curVar == curLoadCheck) then
									doIgnore = false;
									break;
								end
							end
						end
						
						--If we are supposed to ignore this guy, then do so now
						if (not doIgnore) then
							--If we have a list of vars to ignore, then go through them, and if this var is in there, then ignore it
							if (reglist.ignoreList) then
								--Make sure the ignoreList is a table
								if (type(reglist.ignoreList) ~= "table") then
									reglist.ignoreList = { reglist.ignoreList };
								end
								--Go through the list and see if we find the variable, if we do, then ignore it
								for i, curIgnoreCheck in reglist.ignoreList do
									if (curVar == curIgnoreCheck) then
										doIgnore = true;
										break;
									end
								end
							end
							
							--If we are supposed to ignore this guy, then do so now
							if (not doIgnore) then
								if (reglist.nonUIList) then
									--Since these are UI vars, then we should only be ignoring them if the UI is around
									if ( MCom.hasUI() ) then
										--Unless we find this in the list, we should be ignoring it
										doIgnore = true;
										--Make sure the nonUIList is a table
										if (type(reglist.nonUIList) ~= "table") then
											nonUIList = { reglist.nonUIList };
										end
										--Go through the list and see if we find the variable, if we do, then don't ignore it
										for i, curUICheck in reglist.nonUIList do
											if (curVar == curUICheck) then
												doIgnore = false;
												break;
											end
										end
									end
								else
									if (reglist.uiList) then
										--Since these are UI vars, then we should only be ignoring them if the UI is around
										if ( MCom.hasUI() ) then
											--Make sure the uiList is a table
											if (type(reglist.uiList) ~= "table") then
												uiList = { reglist.uiList };
											end
											--Go through the list and see if we find the variable, if we do, then ignore it
											for i, curUICheck in reglist.uiList do
												if (curVar == curUICheck) then
													doIgnore = true;
													break;
												end
											end
										end
									end
								end
									
								--If we are supposed to ignore this guy, then do so now
								if (not doIgnore) then
									--Load the variable
									varTable[curVar] = storeVar[curVar];
									--Set that we loaded data
									didLoad = true;
								end
							end
						end
					end
					
					--If a forced list has been passed, then go through it
					if (reglist.forceList) then
						--Make sure it is a table
						if ( type(reglist.forceList) ~= "table" ) then
							reglist.forceList = { reglist.forceList };
						end
						--Go through all the variables in the table
						for i, curVar in reglist.forceList do
							--This will become true if we shouldn't load this variable
							local doIgnore = false;
							
							--If we have a list of vars to load, then go through them, and if this var is not in there, then ignore it
							if (reglist.loadList) then
								--Default to ignoring now
								doIgnore = true;
								--Make sure the loadList is a table
								if (type(reglist.loadList) ~= "table") then
									reglist.loadList = { reglist.loadList };
								end
								--Go through the list and see if we find the variable, if we do, then we don't ignore it
								for i, curLoadCheck in reglist.loadList do
									if (curVar == curLoadCheck) then
										doIgnore = false;
										break;
									end
								end
							end
							
							--If we are supposed to ignore this guy, then do so now
							if (not doIgnore) then
								--If we have a list of vars to ignore, then go through them, and if this var is in there, then ignore it
								if (reglist.ignoreList) then
									--Make sure the ignoreList is a table
									if (type(reglist.ignoreList) ~= "table") then
										reglist.ignoreList = { reglist.ignoreList };
									end
									--Go through the list and see if we find the variable, if we do, then ignore it
									for i, curIgnoreCheck in reglist.ignoreList do
										if (curVar == curIgnoreCheck) then
											doIgnore = true;
											break;
										end
									end
								end
								
								--If we are supposed to ignore this guy, then do so now
								if (not doIgnore) then
									if (reglist.nonUIList) then
										--Since these are UI vars, then we should only be ignoring them if the UI is around
										if ( MCom.hasUI() ) then
											--Unless we find this in the list, we should be ignoring it
											doIgnore = true;
											--Make sure the nonUIList is a table
											if (type(reglist.nonUIList) ~= "table") then
												nonUIList = { reglist.nonUIList };
											end
											--Go through the list and see if we find the variable, if we do, then don't ignore it
											for i, curUICheck in reglist.nonUIList do
												if (curVar == curUICheck) then
													doIgnore = false;
													break;
												end
											end
										end
									else
										if (reglist.uiList) then
											--Since these are UI vars, then we should only be ignoring them if the UI is around
											if ( MCom.hasUI() ) then
												--Make sure the uiList is a table
												if (type(reglist.uiList) ~= "table") then
													uiList = { reglist.uiList };
												end
												--Go through the list and see if we find the variable, if we do, then ignore it
												for i, curUICheck in reglist.uiList do
													if (curVar == curUICheck) then
														doIgnore = true;
														break;
													end
												end
											end
										end
									end
										
									--If we are supposed to ignore this guy, then do so now
									if (not doIgnore) then
										--Load the variable
										varTable[curVar] = storeVar[curVar];
										--Set that we loaded data
										didLoad = true;
									end
								end
							end
						end
					end
				end
			end
		end
		--Return if we loaded data or not
		return didLoad;
	end;

	--[[
	 	safeLoad ( configVar )
	 		Used to ensure that when variables are loaded into a table based variable, that none of the defaults
	 		are niled out.
	 		Call this after you have setup the defaults for your table, but before VARIABLES_LOADED occurs.
	 		When the variables are loaded, anything that is missing will be filled in with the defaults.

	 	Args:
 			Required:
 				(string) configVar -	The name of the config variable, this should have been registered for save by you, and must be a table with a simple
 															variable name.  IE no .'s or []'s
	]]--
	MCom.safeLoad = function ( configVar )
		if (not MCom.didVarsLoaded) then
			--Get the actual config table
			local varTable = MCom.getStringVar(configVar);
			if ( type(varTable) == "table" ) then
				--If we don't have a table of safe loads yet, then make one
				if (not MCom.safeLoads) then
					MCom.safeLoads = {};
				end
				if (not MCom.safeLoads.addonLoaded) then
					MCom.safeLoads.addonLoaded = {};
				end
				if (not MCom.safeLoads.varsLoaded) then
					MCom.safeLoads.varsLoaded = {};
				end

				--Store this config for loading later
				MCom.safeLoads.addonLoaded[configVar] = varTable;

				--Hook for the VARIABLES_LOADED event
				if (not MCom.HookedOnEvent) then
					MCom.HookedOnEvent = true;
					MCom.util.hook("UIParent_OnEvent", "MCom.UIParent_OnEvent", "after");
				end
				--Hook for the ADDON_LOADED event
				if (not MCom.RegisteredAddonLoaded) then
					UIParent:RegisterEvent("ADDON_LOADED");
				end
			end
		end
	end;

	--[[
	 	varsLoaded
	 		This will simply check to see if the variables needed to be able to use MCom.loadConfig have been loaded.
	 		To use this properly you must have an OnEvent function.  You must have registered for the "UNIT_NAME_UPDATE"
	 		event.  In your OnEvent handler you need to check if that event has occured, and if it has if the arg1 is player.
	 		You should also have a variable that keeps up with whether or not you have loaded your config, and only try to
	 		do so if it hasn't loaded.
	 		
	 		Ex	(somewhere in the OnLoad handler) this will either register with the UI to call ModName.LoadConfig when
	 				they load their configuration, or it will register a "UNIT_NAME_UPDATE" event for you:
	 		MCom.registerForLoad(ModName.LoadConfig);
	 		
	 		Ex	(somewhere in the OnEvent handler) this will handle waiting till the right vars are loaded before calling
	 				the config, when there is no UI around:
	 		if (( event == "UNIT_NAME_UPDATE" ) and (arg1 == "player") and (not ModName.VarsLoaded)) then
				if ( MCom.varsLoaded() ) then
					ModName.VarsLoaded = true;
					ModName.LoadConfig();
				end
			end
			
			NOTE: Make sure you're LoadConfig function only loads the config once, as some UIs might call the function more
						than once.
		
		Returns:
			true - the variables needed to load the config are present and proper
			false - the variables needed to load the config are not present or not proper
		 	
	]]--
	MCom.varsLoaded = function ()
		--Get the realm and character names
		local realm = GetCVar("RealmName");
		local character = UnitName("player");
		--If we have the needed data, in proper format, then return true, otherwise return false
		if ( realm and character and ( character ~= UKNOWNBEING ) and ( character ~= UNKNOWNOBJECT ) ) then
			return true;
		end
		return false;
	end;
	
	--[[
	 	registerVarsLoaded ( function callback )
	 		This will call the passed function back when the variables have been loaded by the game, or the
	 		UI.  This would be an optimal time to load 
		
		Args:
			callback( vltype ) - the function to be called when the variables have been loaded
				Args:
					(string) vltype - indicates what kind of load has occured, "UIParent" for normal, "Khaos", or "Cosmos"
	]]--
	MCom.registerVarsLoaded = function ( callback )
		--Add this callback to the list
		if (not MCom.varsLoadedList) then
			MCom.varsLoadedList = {};
		end
		table.insert(MCom.varsLoadedList, callback);

		--Only register for the load notice once
		if (not MCom.LoadNoticeRegistered) then
			MCom.LoadNoticeRegistered = true;
			--Try to register with Khaos
			if (Khaos) then
				Khaos.registerConfigurationLoadNotice( { onConfigurationChange = MCom.VariablesLoaded; id = "MCom"; description = "Handles all MCom registered load notices"; } );
			elseif (Cosmos_RegisterVarsLoaded) then
				--Try to register with Cosmos
				Cosmos_RegisterVarsLoaded( MCom.VariablesLoaded );
			else
				--Hook the event function of UIParent so we know when VARS_LOADED occurs
				if (not MCom.HookedOnEvent) then
					MCom.HookedOnEvent = true;
					MCom.util.hook("UIParent_OnEvent", "MCom.UIParent_OnEvent", "after");
				end
				MCom.UseVarsLoadedEvent = true;
			end
		end
	end;
	
	--[[
	 	DEPRICATED!  For Backward compatability only.
	 	USE MCom.registerVarsLoaded
	]]--
	MCom.registerForLoad = function ( callback )
		--Try to register with Khaos
		if (Khaos and this:GetName()) then
			Khaos.registerConfigurationLoadNotice( { onConfigurationChange = callback; id = this:GetName(); description = ""; } );
		elseif (Cosmos_RegisterVarsLoaded) then
			--Try to register with Cosmos
			Cosmos_RegisterVarsLoaded( callback );
		else
			--No UI around, so we register the event
			this:RegisterEvent( "UNIT_NAME_UPDATE" );
		end
		return false;
	end;

	--[[
	 	addSlashCom ( [string/{string, ...}] command, function comfunc, string comaction, bool comsticky, string comhelp, string comtype, string uisec, string uivar, string comvar, string comvarmulti, number commin, number commax, number commul, number cominmul, bool hasbool, {string = string, ...} choices, bool multichoice, bool hasopacity, {string, ...} extrahelp )
		 	Registers a standard slash command.  This will register with Sky, if it exists.
		 	addSlashCom makes its own chat handler function.  The function expects a particular kind of input, specified by comtype.
		 	
		 	For boolean input, it will require that the user pass on, off, 1, or 0, to consider the command valid. It will then call
		 	the function you pass, and will pass a 1, 0, or a -1, standing for True, False, and no input(I suggest you make it invert
		 	the current value in this case).  If Cosmos is loaded, and you have passed uivar and comvar, it will update the cosmos
		 	variable after the function has completed.
		 	
		 	If the slash command is already registered with MCom, nothing will happen.
		
		Args:
		 	command -	The slash command(s) you want to register. Ex: "/command". This can be a string or a table of strings if you
		 						want more than one command.
		 	comfunc -	The function that the should be called when the slash command is used, and valid.  If the function returns a value
		 						that value will be used to update a cosmos variable, if uivar has been passed.  You don't have to return a value
		 						to do this, but if you don't then you need to use comvar, and comvarmulti(for multi type).  For multi type it
		 						should return the bool then the value, like so: "return enabled, value;"
		 						BOOL - function (bool enabled)
		 						NUMBER - function (number value)
		 						MULTI - function (bool enabled, number value)
		 						STRING - function (string value)
		 						SIMPLE - function ()
	
		Optional: 
		 	comaction -	The action to perform, see Sky documentation for further details
		 	comsticky -	Whether the command is sticky or not(1 or 0), see Sky documentation for further details
		 	comhelp -	What message to display as help in Sky for this command, see Sky documentation for further details
		 	comtype -	the type of data you are expecting from this slash command
		 						MCOM_BOOLT - Expects boolean data, an on, off, 1, or 0
		 						MCOM_NUMT - Expects a number value
		 						MCOM_MULTIT - Expects a boolean and then a number value, Ex: "/command on 3"
		 						MCOM_STRINGT - Expects any string
		 						MCOM_SIMPLET - No input needed, just calls the function
		 	commin - the minimum value the number variable can be set to, for help display only
		 	commax - the maximum value the number variable can be set to, for help display only
		 	commul - the value to multiply the number by when showing it's status
		 	cominmul - A value to multiply the number passed in by the user(for number types only)
		 	hasbool - If this option has a boolean part, set this to true
		 	multichoice - Set this true if this is a choice type and can have multiple choices selected
		 	hasopacity - Set this true if this is a color type that should also have an opacity setting
		 	extrahelp - A table of extra help messages to display, each line is printed on a seperate line
		 	
		These are required if you want to update a Cosmos or Khaos variable:
		 	uivar -	The Cosmos variable that should be updated, if you want this slash command to update a cosmos variable
		These are required if you want to update a Cosmos or Khaos variable, and your function doesn't return the updated value:
		 	comvar -	The variable that the cosmos variable should be set by, if you want this slash command to update a cosmos variable
		 						This should be a string containing the name of the variable to update, this can include .'s for tables, Ex: "Something.Value"
		 						When type is MULTI, this specifies the bool variable
		 	comvarmulti - The same as comvar, but used to specify the number variable when type is MULTI, only used for MULTI type
		 	
		This is required if you want to update a Khaos variable:
			uisec - The option set ID that the uivar is found in
			
		This is required is you are using a MCOM_CHOICET type:
			choices - The list of choices
	]]--
	MCom.addSlashCom = function (command, comfunc, comaction, comsticky, comhelp, comtype, uisec, uivar, comvar, comvarmulti, commin, commax, commul, cominmul, hasbool, choices, multichoice, hasopacity, extrahelp)
		--We need at bare minimum command, and comfunc
		if (command and comfunc) then
			--If we dont have our chat command list yet, make one
			if (not MCom.SlashComs) then
				MCom.SlashComs = {};
			end
			--make sure command is a table
			if (type(command) ~= "table") then
				command = {command};
			end

			--If the command is not in the list yet, then add it
			if (not MCom.getComID(command)) then
				table.insert(MCom.SlashComs, {});
				local commandid = getn(MCom.SlashComs);

				--Set the commands various elements
				MCom.SlashComs[commandid].basecommand = command;
				MCom.SlashComs[commandid].comfunc = comfunc;
				if (comtype) then
					MCom.SlashComs[commandid].comtype = comtype;
				elseif (MCom.SlashComs[commandid].comtype == nil) then
					--Default to simple type
					MCom.SlashComs[commandid].comtype = MCOM_SIMPLET;
				end
				if (uisec) then
					MCom.SlashComs[commandid].uisec = uisec;
				end
				if (uivar) then
					MCom.SlashComs[commandid].uivar = uivar;
				end
				if (comvar) then
					MCom.SlashComs[commandid].comvar = comvar;
				end
				if (comvarmulti) then
					MCom.SlashComs[commandid].comvarmulti = comvarmulti;
				end
				if (commim) then
					MCom.SlashComs[commandid].commin = commin;
				end
				if (commax) then
					MCom.SlashComs[commandid].commax = commax;
				end
				if (commul) then
					MCom.SlashComs[commandid].commul = commul;
				end
				if (cominmul) then
					MCom.SlashComs[commandid].cominmul = cominmul;
				end
				if (extrahelp) then
					MCom.SlashComs[commandid].extrahelp = extrahelp;
				end
				if (hasbool) then
					MCom.SlashComs[commandid].hasbool = hasbool;
				end
				if (choices) then
					MCom.SlashComs[commandid].choices = choices;
				end
				if (multichoice) then
					MCom.SlashComs[commandid].multichoice = multichoice;
				end
				if (hasopacity) then
					MCom.SlashComs[commandid].hasopacity = hasopacity;
				end
				
				--Register the command with Sky, or the default method
				if ( Sky ) then
					--Register the command with Sky
					Sky.registerSlashCommand(
						{
							id=string.upper(command[1]).."_COMMAND";
							commands = command;
							onExecute = function (msg) MCom.SlashCommandHandler(commandid, msg); end;
							action = comaction;
							sticky = comsticky;
							helpText = comhelp;
						}
					);
				else
					SlashCmdList[string.upper(string.sub(command[1], 2))] = function (msg) MCom.SlashCommandHandler(commandid, msg); end;
					for curCom = 1, getn(command) do
						setglobal("SLASH_"..string.upper(string.sub(command[1], 2))..curCom, command[curCom]);
					end
				end
			end
		end
	end;
	
	--[[
	 	addSlashSuperCom ( [string/{string, ...}] command, string comaction, number comsticky, string comhelp )
		 	This registers a slash command that will have sub commands in it.  See addSlashSubCom for more details on sub commands.
		 	
		 	If the slash command is already registered with MCom, nothing will happen.
		
		Args:
		 	command -	The slash command(s) you want to register. Ex: "/command". This can be a string or a table of strings if you
		 						want more than one command.
	
		Optional: 
		 	comaction -	The action to perform, see Sky documentation for further details
		 	comsticky -	Whether the command is sticky or not(1 or 0), see Sky documentation for further details
		 	comhelp -	What message to display as help in Sky for this command, see Sky documentation for further details
		 	extrahelp - A table of extra help messages to display, each line is printed on a seperate line
	]]--
	MCom.addSlashSuperCom = function (command, comaction, comsticky, comhelp, extrahelp)
		--We need at bare minimum command
		if (command) then
			--If we dont have our chat command list yet, make one
			if (not MCom.SlashComs) then
				MCom.SlashComs = {};
			end
			--make sure command is a table
			if (type(command) ~= "table") then
				command = {command};
			end
			
			--If the command is not in the list yet, then add it
			if (not MCom.getComID(command)) then
				table.insert(MCom.SlashComs, {});
				local commandid = getn(MCom.SlashComs);

				MCom.SlashComs[commandid].basecommand = command;
				if (extrahelp) then
					MCom.SlashComs[commandid].extrahelp = extrahelp;
				end
				
				--Register the command with Sky, or the default method
				if ( Sky ) then
					Sky.registerSlashCommand(
						{
							id=string.upper(command[1]).."_COMMAND";
							commands = command;
							onExecute = function (msg) MCom.SlashCommandHandler(commandid, msg); end;
							action = comaction;
							sticky = comsticky;
							helpText = comhelp;
						}
					);
				else
					SlashCmdList[string.upper(string.sub(command[1], 2))] = function (msg) MCom.SlashCommandHandler(commandid, msg); end;
					for curCom = 1, getn(command) do
						setglobal("SLASH_"..string.upper(string.sub(command[1], 2))..curCom, command[curCom]);
					end
				end
			end
		end
	end;
	
	--[[
	 	addSlashSubCom ( [string/{string, ...}] basecommand, [string/{string, ...}] subcommand, function comfunc, string comhelp, string comtype, string uisec, string uivar, string comvar, string comvarmulti, number commin, number commax, number commul, number cominmul, bool hasbool, {string = string, ...} choices, bool multichoice, bool hasopacity)
		 	This is like addSlashCom, but it registers a sub command to be used with a super command.
		 	A sub command is one that is entered after the super command is entered.
		 	Example:
		 	Normal command: "/modcommand on"
		 	Sub command, with super command of mod: "/mod command on"
		 	
		 	Using super and sub commands allows you to register only one actual real command, which helps to clean up the listing of slash
		 	commands, and helps to prevent using a slash command that may already be there.  It also makes it easier for the user to remember
		 	and use, as if the user simply types the super command by itself they will get a listing of all sub commands, and usage.
		 	
		 	If the slash command is already registered with MCom, nothing will happen.
		
		Args:
		 	basecommand -	The super command that this sub command goes with.  Can be a single command or a list of commands.
		 	subcommand -	The sub command(s) you want to register. Ex: "command". This can be a string or a table of strings if you
		 						want more than one command.
		 	comfunc -	The function that the should be called when the slash command is used, and valid.  If the function returns a value
		 						that value will be used to update a cosmos variable, if uivar has been passed.  You don't have to return a value
		 						to do this, but if you don't then you need to use comvar, and comvarmulti(for multi type).  For multi type it
		 						should return the bool then the value, like so: "return enabled, value;"
		 						BOOL - function (bool enabled)
		 						NUMBER - function (number value)
		 						MULTI - function (bool enabled, number value)
		 						STRING - function (string value)
		 						SIMPLE - function ()
	
		Optional: 
		 	comhelp -	What message to display next to the sub command when listing sub commands in the help output.
		 						NOTE: if this is an MCOM_CHOICET then if you put a %s in this string, it will be replaces with a list of
								the choices you passed.
		 	comtype -	the type of data you are expecting from this slash command
		 						MCOM_BOOLT - Expects boolean data, an on, off, 1, or 0
		 						MCOM_NUMT - Expects a number value
		 						MCOM_MULTIT - Expects a boolean and then a number value, Ex: "/command on 3"
		 						MCOM_STRINGT - Expects any string
		 						MCOM_SIMPLET - No input needed, just calls the function
		 	commin - the minimum value the number variable can be set to, for help display only
		 	commax - the maximum value the number variable can be set to, for help display only
		 	commul - the value to multiply the number by when showing it's status
		 	cominmul - A value to multiply the number passed in by the user(for number types only)
		 	hasbool - If this option has a boolean part, set this to true
		 	multichoice - Set this true if this is a choice type and can have multiple choices selected
		 	hasopacity - Set this true if this is a color type that should also have an opacity setting
		 	
		These are required if you want to update a Cosmos variable:
		 	uivar -	The Cosmos variable that should be updated, if you want this slash command to update a cosmos variable
		These are required if you want to update a Cosmos variable, and your function doesn't return the updated value:
		 	comvar -	The variable that the cosmos variable should be set by, if you want this slash command to update a cosmos variable
		 						This should be a string containing the name of the variable to update, this can include .'s for tables, Ex: "Something.Value"
		 						When type is MULTI, this specifies the bool variable
		 	comvarmulti - The same as comvar, but used to specify the number variable when type is MULTI, only used for MULTI type
		 	
		This is required if you want to update a Khaos variable:
			uisec - The option set ID that the uivar is found in
			
		This is required is you are using a MCOM_CHOICET type:
			choices - The list of choices
	]]--
	MCom.addSlashSubCom = function (basecommand, subcommand, comfunc, comhelp, comtype, uisec, uivar, comvar, comvarmulti, commin, commax, commul, cominmul, hasbool, choices, multichoice, hasopacity)
		--We need at bare minimum commandid, subcommand, and comfunc
		if (basecommand and subcommand and comfunc) then
			--If we don't have a chat com list, then we shouldn't do anything
			if (MCom.SlashComs) then
				--Make sure basecommand is a table
				if (type(basecommand) ~= "table") then
					basecommand = {basecommand};
				end
				
				--get the ID of the super command, if it is in the list
				local commandid = MCom.getComID(basecommand);		
				
				--no commandid means no nothing
				if (commandid) then
					--If this super command doesn't have a list of sub commands yet, then make one
					if (not MCom.SlashComs[commandid].commands) then
						MCom.SlashComs[commandid].commands = {};
					end
					
					--If the sub command isn't a table turn it to one
					if (type(subcommand) ~= "table") then
						subcommand = {subcommand};
					end
					
					--Try and find the subcommand in the list
					local monkey, subcommandid = MCom.getComID(commandid, subcommand);
					
					--Make sure this sub command doesn't already exist
					if (not subcommandid) then
						--Make the sub command
						table.insert(MCom.SlashComs[commandid].commands, {});
						subcommandid = getn(MCom.SlashComs[commandid].commands);
						
						--Setup the sub commands elements
						MCom.SlashComs[commandid].commands[subcommandid].command = subcommand;
						MCom.SlashComs[commandid].commands[subcommandid].comfunc = comfunc;
						if (comhelp) then
							MCom.SlashComs[commandid].commands[subcommandid].comhelp = comhelp;
						end
						if (comtype) then
							MCom.SlashComs[commandid].commands[subcommandid].comtype = comtype;
						elseif (MCom.SlashComs[commandid].commands[subcommandid].comtype == nil) then
							--Default to simple type
							MCom.SlashComs[commandid].commands[subcommandid].comtype = MCOM_SIMPLET;
						end
						if (uisec) then
							MCom.SlashComs[commandid].commands[subcommandid].uisec = uisec;
						end
						if (uivar) then
							MCom.SlashComs[commandid].commands[subcommandid].uivar = uivar;
						end
						if (comvar) then
							MCom.SlashComs[commandid].commands[subcommandid].comvar = comvar;
						end
						if (comvarmulti) then
							MCom.SlashComs[commandid].commands[subcommandid].comvarmulti = comvarmulti;
						end
						if (commin) then
							MCom.SlashComs[commandid].commands[subcommandid].commin = commin;
						end
						if (commax) then
							MCom.SlashComs[commandid].commands[subcommandid].commax = commax;
						end
						if (commul) then
							MCom.SlashComs[commandid].commands[subcommandid].commul = commul;
						end
						if (cominmul) then
							MCom.SlashComs[commandid].commands[subcommandid].cominmul = cominmul;
						end
						if (hasbool) then
							MCom.SlashComs[commandid].commands[subcommandid].hasbool = hasbool;
						end
						if (choices) then
							MCom.SlashComs[commandid].commands[subcommandid].choices = choices;
						end
						if (multichoice) then
							MCom.SlashComs[commandid].commands[subcommandid].multichoice = multichoice;
						end
						if (hasopacity) then
							MCom.SlashComs[commandid].commands[subcommandid].hasopacity = hasopacity;
						end
					end
				end				
			end
		end
	end;
	
	--[[
		callHook ( (string) hook, (any) a1..a20 )
			Calls the origional hooked function.

		Args:
			(string) hook - The name of the origional function to call
			(any) a1..a20 - Any variables that need to be passed to the function

		Returns:
			Whatever the passed function returns
	]]--
	MCom.callHook = function ( hook, a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20 )
		--Make sure we have a hook
		if ( hook ) then
			--If we can use Sea, then do so
			if ( Sea ) then
				if ( Sea.util and Sea.util.Hooks and Sea.util.Hooks[hook] and Sea.util.Hooks[hook].orig ) then
					return Sea.util.Hooks[hook].orig(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
				end
			elseif ( MCom.util.Hooks and MCom.util.Hooks[hook] and MCom.util.Hooks[hook].orig ) then
				--Use the MCom list if Sea isn't available
				return MCom.util.Hooks[hook].orig(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
			end
		end
	end;
	
	--[[
		textFrame ( { reglist } )
			Displays the passed text in a multipage scrollable frame.
			This will not be available if the ItemTextFrame has been opened by the game.
			
		Args:
	 		reglist -	Either a table with the options, or a string or list of strings to display as
	 							the text.
	 			{
	 			Required:
	 				(string or table) text -	The text you want to display, if this is a table, then each
	 																	numbered entry will be a page.
	 			
	 			Optional:
	 				(string) title -	The title to display at the top of the frame.
	 				(string) material -	The appearance to use for the frame, can be "Stone", "Parchment", "Marble", "Silver",
	 														or "Bronze", defaults to "Stone" font with a black background.
	 				(number) textscale -	What size to scale the text to, relative to normal (Ex. 1 is normal, 0.5 is half),
	 															defaults to 0.85
	 			}
	 	
	 	Returns:
	 		true - The text frame was displayed
	 		true - The text frame was not displayed
	]]--
	MCom.textFrame = function ( reglist )
		--We have to have a reglist
		if (reglist) then
			--We need to hook some of the functions of the ItemTextFrame so we can have it
			--behave properly for this usage.
			local TextFrame = "MComText";
			if ( not getglobal(TextFrame.."Frame") ) then
				TextFrame = "ItemText";
				if (not MCom.HasHookedText) then
					MCom.HasHookedText = true;
					MCom.util.hook("ItemTextNextPage", "MCom.ItemTextNextPage", "after");
					MCom.util.hook("ItemTextPrevPage", "MCom.ItemTextPrevPage", "after");
					MCom.util.hook("CloseItemText", "MCom.CloseItemText", "after");
					MCom.util.hook("ItemTextFrame_OnEvent", "MCom.ItemTextFrame_OnEvent", "before");
				end
			end

			--Only display the frame if it isn't already visible
			if ( (not MCom.NoTextAvail) and ( not getglobal(TextFrame.."Frame"):IsVisible() ) ) then
				--If this isn't a table, then turn it into one
				if ( type(reglist) ~= "table" ) then
					reglist = { text = { reglist }; };
				end
				--If this is a table of strings, then move the strings into text
				if ( ( not reglist.text ) and reglist[1] ) then
					reglist.text = {};
					for curPage = 1, table.getn(reglist) do
						reglist.text[curPage] = reglist[curPage];
						reglist[curPage] = nil;
					end
				end
				--If text isn't a table then make it one
				if ( type(reglist.text) ~= "table" ) then
					reglist.text = { reglist.text };
				end
				--Set the current text and page, to what was passed
				MCom.CurText = reglist.text;
				MCom.CurTextPage = 1;
				--If there was no title passed, set it as an empty string
				if (not reglist.title) then
					reglist.title = "";
				end
				--Got through all the pages and add some extra fluff new lines to let the user scroll down further
				for curPage in MCom.CurText do
					if (MCom.CurText[curPage]) then
						MCom.CurText[curPage] = MCom.CurText[curPage].."\n\n\n\n";
					end
				end
				--Set the title of the frame
				getglobal(TextFrame.."TitleText"):SetText(reglist.title);
				--Hide the scrollframe and status bar
				getglobal(TextFrame.."ScrollFrame"):Hide();
				getglobal(TextFrame.."StatusBar"):Hide();
				--Setup the look of the frame to the passed look
				local material = Stone;
				--Make sure the material is one of the available materials
				local textColor = {1,1,1};
				if ( reglist.material and MATERIAL_TEXT_COLOR_TABLE[reglist.material] ) then
					material = reglist.material;
					textColor = MATERIAL_TEXT_COLOR_TABLE[material];
				end
				getglobal(TextFrame.."PageText"):SetTextColor(textColor[1], textColor[2], textColor[3]);

				if (not material) then
					if (MComTextFrame) then
						MComTextTopLeft:Show();
						MComTextTop:Show();
						MComTextTopRight:Show();
						MComTextBotLeft:Show();
						MComTextBot:Show();
						MComTextBotRight:Show();
						MComItemTextTopLeft:Hide();
						MComItemTextTopRight:Hide();
						MComItemTextBotLeft:Hide();
						MComItemTextBotRight:Hide();
						getglobal(TextFrame.."MaterialTopLeft"):Hide();
						getglobal(TextFrame.."MaterialTopRight"):Hide();
						getglobal(TextFrame.."MaterialBotLeft"):Hide();
						getglobal(TextFrame.."MaterialBotRight"):Hide();
						MComSpellBookIcon:Hide();
						MComTextFrame:SetWidth(512);
						MComTextCloseButton:SetPoint("CENTER", MComTextFrame, "TOPRIGHT", -58, -19);
						MComTextScrollFrame:SetPoint("TOPRIGHT", MComTextFrame, "TOPRIGHT", -82, -58);
						MComTextScrollFrame:SetWidth(408);
						MComTextScrollFrame:SetHeight(406);
						MComTextScrollFrameMiddle:Show();
						MComTextTitleText:SetPoint("CENTER", MComTextFrame, "CENTER", -14, 230);
						MComTextCurrentPage:SetPoint("TOP", MComTextFrame, "TOP", -14, -34);
						MComTextNextPageButton:SetPoint("CENTER", MComTextFrame, "TOPRIGHT", -86, -32);
						MComTextPrevPageButton:SetPoint("CENTER", MComTextFrame, "TOPLEFT", 32, -32);
						MComTextPageText:SetWidth(400);
					else
						getglobal(TextFrame.."MaterialTopLeft"):SetVertexColor(0,0,0);
						getglobal(TextFrame.."MaterialTopRight"):SetVertexColor(0,0,0);
						getglobal(TextFrame.."MaterialBotLeft"):SetVertexColor(0,0,0);
						getglobal(TextFrame.."MaterialBotRight"):SetVertexColor(0,0,0);
					end
				else
					if (MComTextFrame) then
						MComTextTopLeft:Hide();
						MComTextTop:Hide();
						MComTextTopRight:Hide();
						MComTextBotLeft:Hide();
						MComTextBot:Hide();
						MComTextBotRight:Hide();
						MComItemTextTopLeft:Show();
						MComItemTextTopRight:Show();
						MComItemTextBotLeft:Show();
						MComItemTextBotRight:Show();
						MComSpellBookIcon:Show();
						MComTextFrame:SetWidth(384);
						MComTextCloseButton:SetPoint("CENTER", MComTextFrame, "TOPRIGHT", -45, -26);
						MComTextScrollFrame:SetPoint("TOPRIGHT", MComTextFrame, "TOPRIGHT", -66, -76);
						MComTextScrollFrame:SetWidth(280);
						MComTextScrollFrame:SetHeight(355);
						MComTextScrollFrameMiddle:Hide();
						MComTextTitleText:SetPoint("CENTER", MComTextFrame, "CENTER", 6, 230);
						MComTextCurrentPage:SetPoint("TOP", MComTextFrame, "TOP", 10, -50);
						MComTextNextPageButton:SetPoint("CENTER", MComTextFrame, "TOPRIGHT", -55, -56);
						MComTextPrevPageButton:SetPoint("CENTER", MComTextFrame, "TOPLEFT", 90, -56);
						MComTextPageText:SetWidth(270);
					end
					getglobal(TextFrame.."MaterialTopLeft"):SetVertexColor(1,1,1);
					getglobal(TextFrame.."MaterialTopRight"):SetVertexColor(1,1,1);
					getglobal(TextFrame.."MaterialBotLeft"):SetVertexColor(1,1,1);
					getglobal(TextFrame.."MaterialBotRight"):SetVertexColor(1,1,1);
				end

				--If the look is parchment, then hide the extra textures
				if ( material == "Parchment" ) then
					getglobal(TextFrame.."MaterialTopLeft"):Hide();
					getglobal(TextFrame.."MaterialTopRight"):Hide();
					getglobal(TextFrame.."MaterialBotLeft"):Hide();
					getglobal(TextFrame.."MaterialBotRight"):Hide();
				elseif (material) then
					getglobal(TextFrame.."MaterialTopLeft"):Show();
					getglobal(TextFrame.."MaterialTopRight"):Show();
					getglobal(TextFrame.."MaterialBotLeft"):Show();
					getglobal(TextFrame.."MaterialBotRight"):Show();
					getglobal(TextFrame.."MaterialTopLeft"):SetTexture("Interface\\ItemTextFrame\\ItemText-"..material.."-TopLeft");
					getglobal(TextFrame.."MaterialTopRight"):SetTexture("Interface\\ItemTextFrame\\ItemText-"..material.."-TopRight");
					getglobal(TextFrame.."MaterialBotLeft"):SetTexture("Interface\\ItemTextFrame\\ItemText-"..material.."-BotLeft");
					getglobal(TextFrame.."MaterialBotRight"):SetTexture("Interface\\ItemTextFrame\\ItemText-"..material.."-BotRight");
				end
				--Default the scrollbar positions for all pages to the top
				MCom.CurText.Scroll = {};
				for curPage in MCom.CurText do
					MCom.CurText.Scroll[curPage] = { Value = 0; };
				end
				
				--Resize the text
				if (not reglist.textscale) then
					reglist.textscale = 0.85;
					if (MComTextFrame) then
						reglist.textscale = 1;
					end
				end
				MCom.PageWidth = getglobal(TextFrame.."PageText"):GetWidth();
				MCom.PageScale = getglobal(TextFrame.."PageText"):GetScale();
				getglobal(TextFrame.."PageText"):SetWidth(MCom.PageWidth / reglist.textscale);
				getglobal(TextFrame.."PageText"):SetScale(MCom.PageScale * reglist.textscale);
				
				--Update it with the new text
				MCom.UpdateTextPage();
				--Show the frame
				getglobal(TextFrame.."Frame"):Show();
				return true;
			end
		end
		return false;
	end
	
	--------------------------------------------------
	--
	-- Private Library Functions
	--
	--------------------------------------------------
	--[[ Updates the text in the text frame ]]--
	MCom.UpdateTextPage = function ()
		--Only do this if CurText is a table
		if ( type(MCom.CurText) == "table" ) then
			local TextFrame = "MComText";
			if ( not getglobal(TextFrame.."Frame") ) then
				TextFrame = "ItemText";
			end
			--If there is more than one page then setup the frame for that
			if ( table.getn(MCom.CurText) > 1 ) then
				--Show the text that shows the current page number
				local pageText = string.format(MCOM_PAGE_TEXT, MCom.CurTextPage, table.getn(MCom.CurText));
				if (pageText) then
					getglobal(TextFrame.."CurrentPage"):SetText(pageText);
					getglobal(TextFrame.."CurrentPage"):Show();
				else
					getglobal(TextFrame.."CurrentPage"):Hide();
				end
				--If we have gone passed the first page, then enable the previous page button
				if ( MCom.CurTextPage > 1 ) then
					getglobal(TextFrame.."PrevPageButton"):Show();
				else
					getglobal(TextFrame.."PrevPageButton"):Hide();
				end
				--If we are not on the last page, then enable the next page button
				if ( MCom.CurTextPage < table.getn(MCom.CurText) ) then
					getglobal(TextFrame.."NextPageButton"):Show();
				else
					getglobal(TextFrame.."NextPageButton"):Hide();
				end
			else
				--There is only one page, so hide the page controls
				getglobal(TextFrame.."CurrentPage"):Hide();
				getglobal(TextFrame.."PrevPageButton"):Hide();
				getglobal(TextFrame.."NextPageButton"):Hide();
			end
			
			--Hide the scroll frame
			getglobal(TextFrame.."ScrollFrame"):Hide();
			--Set the text for this page
			getglobal(TextFrame.."PageText"):SetText(MCom.CurText[MCom.CurTextPage]);
			--Update the scrollframe and show if neccisary
			getglobal(TextFrame.."ScrollFrame"):UpdateScrollChildRect();
			getglobal(TextFrame.."ScrollFrame"):Show();
			--Reset the scroll bar position to the one stored for this page
			getglobal(TextFrame.."ScrollFrameScrollBar"):SetValue(MCom.CurText.Scroll[MCom.CurTextPage].Value);
		else
			MCom.CurText = nil;
		end
	end;

	--[[ Adds any entry missing in the toTable from the fromTable ]]--
	MCom.LoadSafeTable = function (toTable, fromTable)
		--Make sure we have tables to work with
		if ( ( type(toTable) == "table" ) and ( type(fromTable) == "table" ) ) then
			--Go through each entry in the from table
			for curEntry in fromTable do
				--If the from entry is a table, then we need to parse each of its entries
				if ( type( fromTable[curEntry] ) == "table" ) then
					--If the to table is not already a table, then turn it into one
					if ( type( toTable[curEntry] ) ~= "table" ) then
						toTable[curEntry] = {};
					end
					--Load the entries from the current from table entry into the current to table entry
					MCom.LoadSafeTable( toTable[curEntry], fromTable[curEntry] );
				elseif ( toTable[curEntry] == nil ) then
					--If this entry is not a table, and it is nil, then load from the from table
					toTable[curEntry] = fromTable[curEntry];
				end
			end
		end
	end;

	--[[ Calls all frames registered for variables loaded notification ]]--
	MCom.VariablesLoaded = function ()
		--Only proceed if we have a list of callbacks
		if ( type(MCom.varsLoadedList) == "table" ) then
			--Figure out what type of load notice was used
			local regType = "UIParent";
			if (Khaos) then
				regType = "Khaos";
			elseif (Cosmos_RegisterVarsLoaded) then
				regType = "Cosmos";
			end
			--Call all the callbacks, and pass the type of load notice
			for i = 1, table.getn(MCom.varsLoadedList) do
				if ( type(MCom.varsLoadedList[i]) == "function" ) then
					MCom.varsLoadedList[i](regType);
				end
			end
		end
	end;

	--[[ Parses a boolean command ]]--
	MCom.ParseBoolCommand = function (value)
		--If it's a boolean then treat it as one
		if (value) then
			value = string.upper(value);
			if ( string.find(value, string.upper(MCOM_CHAT_ON) ) ) then
				value = 1;
			else
				if ( string.find(value, string.upper(MCOM_CHAT_OFF) ) ) then
					value = 0;
				else
					if ( string.find(value, "1") ) then
						value = 1;
					else
						if ( string.find(value, "0") ) then
							value = 0;
						else									
							value = nil;
						end
					end
				end
			end
		else
			--If there was no data passed for this boolean, then send -1 to the functions
			value = -1;
		end
		
		return value;
	end;
	
	--[[ Parses a number command ]]--
	MCom.ParseNumCommand = function (cominmul, value)
		if (value) then
			--Get the valid decimal portion only
			local dump, dump1;
			dump, dump1, value = string.find(value, "(%d*%.*%d+)");
			--If we got a valid decimal, multiply it by cominmul
			if (value) then
				if (not cominmul) then
					cominmul = 1;
				end
				value = value * cominmul;
			end
		end
		
		return value;
	end;

	--[[ Parses a choice command ]]--
	MCom.ParseChoiceCommand = function (choices, multichoice, value)
		retVal = nil;
		name = nil;
		--Make sure we have the needed data
		if (choices and value) then
			--Split the list by spaces
			value = MCom.util.split(value, " ");
			--Make sure it is in table format
			if (type(value) ~= "table") then
				value = {value};
			end
			--Go through all passed choices, and keep any that are in the available list
			for choice in value do
				local curChoice = value[choice];
				--If this isn't a viable choice, then see if there is one with any capitalization
				if (not choices[curChoice]) then
					for curCheck in choices do
						if ( string.lower(curChoice) == string.lower( curCheck ) ) then
							curChoice = curCheck;
							break;
						end
					end
				end
				--Make sure we have a good choice
				if ( choices[curChoice] ) then
					--If it is multichoice, add it to the list
					if (multichoice) then
						if (retVal == nil) then
							retVal = {};
						end
						table.insert(retVal, choices[curChoice]);
						--Make a named list of the selected choices
						if (name) then
							name = name..", "..curChoice;
						else
							name = curChoice;
						end
					else
						--If it's single choice, then return it
						retVal = choices[curChoice];
						name = curChoice;
						break;
					end
				end
			end
		end
		
		return retVal, name;
	end;
	
	--[[ Parses a color command ]]--
	MCom.ParseColorCommand = function (hasopacity, value1, value2, value3, value4)
		local value = nil;
		local dump, dump1;
		--Make sure we have atleast the R the G and the B
		if (value1 and value2 and value3) then
			--Get valid decimals for all three values, and divide them to a percent format
			value = {};
			dump, dump1, value1 = string.find(value1, "(%d*%.*%d+)");
			if (value1) then
				value.r = value1/100;
			end
			dump, dump1, value2 = string.find(value2, "(%d*%.*%d+)");
			if (value1) then
				value.g = value2/100;
			end
			dump, dump1, value3 = string.find(value3, "(%d*%.*%d+)");
			if (value3) then
				value.b = value3/100;
			end
			if (hasopacity and value4) then
				--If we are supposed to have an opacity part then
				--Get a valid decimal for opacity, and divide it to a percent format
				dump, dump1, value3 = string.find(value4, "(%d*%.*%d+)");
				if (value4) then
					value.opacity = value4/100;
				end
			end
			--If we didn't have all three values, then return nil
			if ( not (value1 and value2 and value3) ) then
				value = nil;
			end
			--If we are supposed to have opacity, and it wasn't passed, then return nil
			if (hasopacity and (not value4) ) then
				value = nil;
			end
		end
		
		return value;
	end;

	--[[ The slash command handler used by MCom slash commands ]]--
	MCom.SlashCommandHandler = function (commandid, msg)
		--Only works if we have some registered slash commands
		if (MCom.SlashComs and MCom.SlashComs[commandid]) then
			--Get a shorthand for the current command
			curCommand = MCom.SlashComs[commandid];
			--Only proccess the message if there is one
			if ((msg and (msg ~= "")) or ((curCommand.comtype) and (curCommand.comtype == MCOM_BOOLT))) then
				local subcommand, value;
				local isSimple = true;	--Set true if the command is a standard, not super, slash command
				local comType = nil;		--Stores the type of command
				local badCommand = nil;	--Set true if the data for the command turns out bad
				
				if (not curCommand.commands) then
					--This is simple so unpack it to the values
					if (msg) then
						value = MCom.util.split(msg, " ");
					end
				else
					--This is a super command, so unpack the subcommand and values
					isSimple = nil;
					--Get the position of the subcommand, and the rest goes into msg2
					local first, last, msg2 = string.find(msg, " (.*)");
					--If we got the subcommand position then get that portion to the subcommand
					if (first) then
						subcommand = string.sub(msg, 1, first - 1);
					else
						--If we didn't find a position then we have only the subcommand
						subcommand = msg;
					end
					--Move the rest of the values into msg
					msg = msg2;
					--If we have values in msg, then parse them out
					if (msg) then
						value = MCom.util.split(msg, " ");
					end
					
					if (subcommand) then
						--Try and find an exact match of the subcommand in the list
						local subcommandid = nil;
						for curCom in MCom.SlashComs[commandid].commands do
							if (MCom.SlashComs[commandid].commands[curCom].command) then
								for curComCom in MCom.SlashComs[commandid].commands[curCom].command do
									if (MCom.SlashComs[commandid].commands[curCom].command[curComCom] == subcommand) then
										subcommandid = curCom;
										break;
									end
								end
								if (subcommandid) then
									break;
								end
							end
						end
						
						if (not subcommandid) then
							--Try and find a similar match of the subcommand in the list
							for curCom in MCom.SlashComs[commandid].commands do
								if (MCom.SlashComs[commandid].commands[curCom].command) then
									for curComCom in MCom.SlashComs[commandid].commands[curCom].command do
										if (string.find(MCom.SlashComs[commandid].commands[curCom].command[curComCom], subcommand)) then
											subcommandid = curCom;
											break;
										end
									end
									if (subcommandid) then
										break;
									end
								end
							end
						end
						
						if (not subcommandid) then
							--We didn't find the sub command, so we've got a bad command
							badCommand = true;
						else
							--We found the sub command so change curCommand to point at it
							curCommand = curCommand.commands[subcommandid];
						end
					else
						--No subcommand passed, so thats a bad command
						badCommand = true;
					end
				end
				--We only want to continue if the command was good
				if (not badCommand) then
					--Get the command type
					if (curCommand.comtype) then
						comType = curCommand.comtype;
					end
					
					local retVal, retVal2;

					if ( ( (comType == MCOM_BOOLT) or curCommand.hasbool ) and (value == nil) ) then
						--If nothing was passed and its a bool command then invert it
						curCommand.comfunc(-1);
					elseif ( (comType ~= MCOM_SIMPLET) ) then
						--If it's not a simply command parse the data if we have data
						if (value) then
							--Setup a list of variables to use for checking the passed data
							local checkVal = value[1];
							local checkVal2 = value[2];
							local checkVal3 = value[3];
							local checkVal4 = value[4];
							--This stores the boolean portion of the command, if it has two parts
							local boolVal = value;
							--This stores the display name for choice types
							local name = nil;
							if ( (comType == MCOM_MULTIT) or (curCommand.hasbool and (comType ~= MCOM_BOOLT)) ) then
								--Since the first value was the boolean, move the other values down in the list
								checkVal = value[2];
								checkVal2 = value[3];
								checkVal3 = value[4];
								checkVal4 = value[5];
								
								--Remove the boolean part of the message
								local dump1, dump2;
								dump1, dump2, msg = string.find(msg, " (.*)");
							end
							
							--If it is a multi part, or a boolean, then parse the first value as boolean
							if ( (comType == MCOM_BOOLT) or (comType == MCOM_MULTIT) or curCommand.hasbool ) then
								boolVal = MCom.ParseBoolCommand(value[1]);
								value = boolVal;
							end
							
							--Parse the value, or secondary as the appropriate type
							if ( (comType == MCOM_NUMT) or (comType == MCOM_MULTIT) ) then
								value = MCom.ParseNumCommand(curCommand.cominmul, checkVal);
							elseif (comType == MCOM_STRINGT) then
								--For string we pass the message so spaces can be included
								value = msg;
							elseif (comType == MCOM_CHOICET) then
								--For choice we pass the message so as many passed choices as are passed can be used on a multichoice
								value, name = MCom.ParseChoiceCommand(curCommand.choices, curCommand.multichoice, msg);
							elseif (comType == MCOM_COLORT) then
								value = MCom.ParseColorCommand(curCommand.hasopacity, checkVal, checkVal2, checkVal3, checkVal4);
							end
							
							if ( (comType == MCOM_MULTIT) or (curCommand.hasbool and (comType ~= MCOM_BOOLT)) ) then
								--Handle the two part commands
								if (boolVal or value) then
									--Call the function
									retVal, retVal2 = curCommand.comfunc(boolVal, value, name);
								else
									--We got bad data
									badCommand = true;
								end
							else
								--Handle the one part commands
								if (value) then
									--Call the function
									retVal = curCommand.comfunc(value, name);
								else
									--We got bad data
									badCommand = true;
								end
							end
						else
							badCommand = true;
						end
					else
						--It's a simple type, so just call it and quit
						curCommand.comfunc();
						return;
					end

					if (not badCommand) then
						--If Khaos is around, then we update the variable with it, if possible
						if (Khaos and (curCommand.comvar or retVal) and curCommand.uivar and curCommand.uisec) then
							--Make sure the passed set exists
							if ( KhaosData.configurationSets and (KhaosData.configurationSets[curCommand.uisec]) ) then
								--get the value of the variable
								local newVal = MCom.getStringVar(curCommand.comvar);
								--If a value was returned from the setter function, then use it
								if (retVal) then
									newVal = retVal;
								end
								if (newVal) then
									--Get the second part variable if there is one
									local newValMulti = MCom.getStringVar(curCommand.comvarmulti);
									--If a value was returned from the setter function from the second part, then use it
									if (retVal2) then
										newValMulti = retVal2;
									end
									
									--Default param type is value
									local param = "value";
									--If we have a boolean type, or boolean portion, then update that
									if ( (comType == MCOM_BOOLT) or (comType == MCOM_MULTIT) or curCommand.hasbool) then
										--Make sure its in true/false format
										if (newVal == 1) then
											newVal = true;
										else
											newVal = false;
										end
										--Update the boolean variable
										Khaos.setSetKeyParameter(curCommand.uisec, curCommand.uivar, "checked", newVal);
									end
									--If it isn't a boolean type, then update the other types, or secondary variable
									if ( comType ~= MCOM_BOOLT ) then
										--If we have a secondary variable, then switch to using it
										if (newValMulti) then
											newVal = newValMulti;
										end
										
										--Treat number types as sliders
										if ( (comType == MCOM_NUMT) or (comType == MCOM_MULTIT) ) then
											param = "slider";
										end
										
										--Treat color types as color pickers
										if (comType == MCOM_COLORT) then
											param = "color";
										end
									
										--Update the variable
										Khaos.setSetKeyParameter(curCommand.uisec, curCommand.uivar, param, newVal);
									end
								end
							end
						else
							if(CosmosMaster_Init and (curCommand.comvar or retVal) and curCommand.uivar) then
								--get the value of the variable
								local newVal = MCom.getStringVar(curCommand.comvar);
								if (retVal) then
									newVal = retVal;
								end
								if (newVal) then
									local newValMulti = MCom.getStringVar(curCommand.comvarmulti);
									if (retVal2) then
										newValMulti = retVal2;
									end
									if (((comType ~= MCOM_MULTIT) and (not ((comType ~= MCOM_BOOLT) and curCommand.hasbool))) or (((comType == MCOM_MULTIT) or ((comType ~= MCOM_BOOLT) and curCommand.hasbool)) and newValMulti)) then
										--if its a boolean, then set the checkbox
										if ((comType == MCOM_BOOLT) or (comType == MCOM_MULTIT)) then
											Cosmos_UpdateValue(curCommand.uivar, CSM_CHECKONOFF, newVal);
										end
										--if its a number, then set the slider
										if ((comType == MCOM_NUMT) or (comType == MCOM_MULTIT)) then
											if (comType == MCOM_MULTIT) then
												newVal = newValMulti;
											end
											Cosmos_UpdateValue(curCommand.uivar, CSM_SLIDERVALUE, newVal);
										end
									end
								end
							end
						end
						return;
					end
				end
			elseif ((curCommand.comtype) and (curCommand.comtype == MCOM_SIMPLET)) then
				--If the command is a standard simple command, then just execute it
				curCommand.comfunc();
				return;
			end
			
			--If we didn't find any valid commands we print out the help
			local infoText = MCom.PrintSlashCommandInfo(commandid, true);
			MCom.textFrame( { text = infoText; title = MCOM_HELP_GENERIC_TITLE; } );
		end
	end;

	--[[ Either prints out, or adds to a string the current chat line ]]--
	MCom.PrintSlashCommandLine = function ( asString, chatLine, extraLine )
		--If it's supposed to be in a string then add this to the string
		if ( asString ) then
			--If it isn't a string yet, then just set it to this line
			if ( type(asString) ~= "string" ) then
				asString = chatLine;
			else
				--It's already a string so add a newline and then this line
				if (extraLine) then
					asString = asString.."\n\n"..chatLine
				else
					asString = asString.."\n"..chatLine
				end
			end
			--Return the string
			return asString;
		else
			--Print out the chat line
			MCom.IO.printc(ChatTypeInfo["SYSTEM"], chatLine);
		end
	end

	--[[ Prints the help for a chat command	]]--
	MCom.PrintSlashCommandInfo = function (commandid, asString)
		if (MCom.SlashComs[commandid]) then
			local chatLine = ""; --The current line of text to be printed
			local basecommand = MCom.SlashComs[commandid].basecommand[1];

			--Construct a list of the aliases for the command, if any
			local aliasList = "";
			if (getn(MCom.SlashComs[commandid].basecommand) > 1) then
				for curCom = 2, getn(MCom.SlashComs[commandid].basecommand) do
					if (aliasList ~= "") then
						aliasList = aliasList..", ";
					else
						aliasList = basecommand..", ";
					end
					aliasList = aliasList..MCom.SlashComs[commandid].basecommand[curCom];
				end
			end

			--Print list of aliases, if there are any
			if (aliasList ~= "") then
				chatLine = string.format(MCOM_CHAT_COM_ALIAS, aliasList);
				asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
			end

			local isSimple = true;		--Set true if this command does not have sub commands
			local eSample = nil;			--Set to something if a simple command is found
			local bSample = nil;			--Set to something if a bool command is found
			local nSample = nil;			--Set to something if a num command is found
			local nSampleV = nil;			--Set to and example value for a number command
			local sSample = nil;			--Set to something if a string command is found
			local cSample = nil;			--Set to something if a choice command is found
			local cnSampleV = nil;		--Set to and example value for a choice command
			local cmSample = nil;			--Set to something if a multi choice command is found
			local cmnSampleV = nil;		--Set to and example value for a multi choice command
			local koSample = nil;			--Set to something if a color with opacity command is found
			local bnSample = nil;			--Set to something if a bool and num command is found
			local bnSampleV = nil;		--Set to and example value for a bool and number command
			local bsSample = nil;			--Set to something if a bool and string command is found
			local bcSample = nil;			--Set to something if a bool and choice command is found
			local bcnSampleV = nil;		--Set to and example value for a bool and choice command
			local bcmSample = nil;		--Set to something if a bool and multi choice command is found
			local bcmnSampleV = nil;	--Set to and example value for a bool and multi choice command
			local bkoSample = nil;		--Set to something if a bool and color with opacity command is found

			--If this command has sub commands, then print a list of them
			if (MCom.SlashComs[commandid].commands) then
				asString = MCom.PrintSlashCommandLine(asString, MCOM_CHAT_COM_COMMANDS, true);
				isSimple = nil;	--This is not a simple command, lets remember that
				for curCom = 1, getn(MCom.SlashComs[commandid].commands) do
					local curComType = MCOM_SIMPLET;	--Default our type to simple
					local curComBool = false;					--Default has bool to false
					local curComChoices = nil;				--The choices for a choice type
					local curComMulti = false;				--Default multi choice to false
					local curComOpacity = false;			--Default has opacity to false
					local curComValue = nil;					--The value of the variable associated with the command
					local curComValueMulti = nil;			--The value of the multi variable associated with the command
					local curComMin = nil;						--The minimum a value can be set to
					local curComMax = nil;						--The maximum a value can be set to
					local curComMul = 1;							--The value to multiply numbers by when showing status
					--If a type is specified look it up
					if (MCom.SlashComs[commandid].commands[curCom].comtype) then
						curComType = MCom.SlashComs[commandid].commands[curCom].comtype;
					end
					--If a hasbool is specified look it up
					if (MCom.SlashComs[commandid].commands[curCom].hasbool) then
						curComBool = true;
					end
					--If choices are specified look them up
					if (MCom.SlashComs[commandid].commands[curCom].choices) then
						curComChoices = MCom.SlashComs[commandid].commands[curCom].choices;
					end
					--If a multichoioce is specified look it up
					if (MCom.SlashComs[commandid].commands[curCom].multichoice) then
						curComMulti = true;
					end
					--If a hasopacity is specified look it up
					if (MCom.SlashComs[commandid].commands[curCom].hasopacity) then
						curComOpacity = MCom.SlashComs[commandid].commands[curCom].hasopacity;
					end
					--If a comvar is specified look it up
					if (MCom.SlashComs[commandid].commands[curCom].comvar ~= nil) then
						curComValue = MCom.getStringVar(MCom.SlashComs[commandid].commands[curCom].comvar);
					end
					--If a comvarmulti is specified look it up
					if (MCom.SlashComs[commandid].commands[curCom].comvarmulti ~= nil) then
						curComValueMulti = MCom.getStringVar(MCom.SlashComs[commandid].commands[curCom].comvarmulti);
					end
					--If a commin is specified look it up
					if (MCom.SlashComs[commandid].commands[curCom].commin ~= nil) then
						curComMin = MCom.SlashComs[commandid].commands[curCom].commin;
					end
					--If a commax is specified look it up
					if (MCom.SlashComs[commandid].commands[curCom].commax ~= nil) then
						curComMax = MCom.SlashComs[commandid].commands[curCom].commax;
					end
					--If a commul is specified look it up
					if (MCom.SlashComs[commandid].commands[curCom].commul ~= nil) then
						curComMul = MCom.SlashComs[commandid].commands[curCom].commul;
					end
					
					--Store this command as a sample of whatever type it is
					if ((not eSample) and (curComType == MCOM_SIMPLET)) then
						eSample = MCom.SlashComs[commandid].commands[curCom].command[1];
					end
					if ((not bSample) and (curComType == MCOM_BOOLT)) then
						bSample = MCom.SlashComs[commandid].commands[curCom].command[1];
					end
					if (not curComBool) then
						if ((not nSample) and (curComType == MCOM_NUMT)) then
							nSample = MCom.SlashComs[commandid].commands[curCom].command[1];
							--Get a valid sample number
							nSampleV = curComMin;
							if (not nSampleV) then
								nSampleV = curComMax;
							end
							if (not nSampleV) then
								nSampleV = MCOM_CHAT_COM_EXAMPLE_O_N;
							end
						end
						if ((not sSample) and (curComType == MCOM_STRINGT)) then
							sSample = MCom.SlashComs[commandid].commands[curCom].command[1];
						end
						if (not curComMulti) then
							if ((not cSample) and (curComType == MCOM_CHOICET)) then
								cSample = MCom.SlashComs[commandid].commands[curCom].command[1];
								--Get a valid sample choice
								for sampleV in curComChoices do
									cSampleV = sampleV;
									break;
								end
							end
						else
							if ((not cmSample) and (curComType == MCOM_CHOICET)) then
								cmSample = MCom.SlashComs[commandid].commands[curCom].command[1];
								--Get a valid sample choice
								local count = 0;
								--Construct an example with two valid choices
								for sampleV in curComChoices do
									count = count + 1;
									if (cmSampleV) then
										cmSampleV = cmSampleV.." "..sampleV;
									else
										cmSampleV = sampleV;
									end
									if (count > 1) then
										break;
									end
								end
							end
						end
						if (not curComOpacity) then
							if ((not kSample) and (curComType == MCOM_COLORT)) then
								kSample = MCom.SlashComs[commandid].commands[curCom].command[1];
							end
						else
							if ((not koSample) and (curComType == MCOM_COLORT)) then
								koSample = MCom.SlashComs[commandid].commands[curCom].command[1];
							end
						end
					else
						if ((not bnSample) and ((curComType == MCOM_NUMT) or (curComType == MCOM_MULTIT))) then
							bnSample = MCom.SlashComs[commandid].commands[curCom].command[1];
							--Get a valid sample number
							bnSampleV = curComMin;
							if (not bnSampleV) then
								bnSampleV = curComMax;
							end
							if (not bnSampleV) then
								bnSampleV = MCOM_CHAT_COM_EXAMPLE_O_N;
							end
						end
						if ((not bsSample) and (curComType == MCOM_STRINGT)) then
							bsSample = MCom.SlashComs[commandid].commands[curCom].command[1];
						end
						if (not curComMulti) then
							if ((not bcSample) and (curComType == MCOM_CHOICET)) then
								bcSample = MCom.SlashComs[commandid].commands[curCom].command[1];
								--Get a valid sample choice
								for sampleV in curComChoices do
									bcSampleV = sampleV;
									break;
								end
							end
						else
							if ((not bcmSample) and (curComType == MCOM_CHOICET)) then
								bcmSample = MCom.SlashComs[commandid].commands[curCom].command[1];
								--Get a valid sample choice
								local count = 0;
								--Construct an example with two valid choices
								for sampleV in curComChoices do
									count = count + 1;
									if (bcmSampleV) then
										bcmSampleV = bcmSampleV.." "..sampleV;
									else
										bcmSampleV = sampleV;
									end
									if (count > 1) then
										break;
									end
								end
							end
						end
						if (not curComOpacity) then
							if ((not bkSample) and (curComType == MCOM_COLORT)) then
								bkSample = MCom.SlashComs[commandid].commands[curCom].command[1];
							end
						else
							if ((not bkoSample) and (curComType == MCOM_COLORT)) then
								bkoSample = MCom.SlashComs[commandid].commands[curCom].command[1];
							end
						end
					end
					
					--If help was specified look it up
					local curHelp = MCOM_CHAT_COM_NOINFO;
					if (MCom.SlashComs[commandid].commands[curCom].comhelp) then
						curHelp = MCom.SlashComs[commandid].commands[curCom].comhelp;
					end
					--If we have a choice type, then make a list of the choices, and tack that onto the help
					if ( curComType == MCOM_CHOICET ) then
						if (curHelp == MCOM_CHAT_COM_NOINFO) then
							curHelp = MCOM_CHAT_COM_CLIST;
						end
						local curChoices = nil;
						for curChoice in curComChoices do
							if (curChoices) then
								curChoices = curChoices..", "..curChoice;
							else
								curChoices = curChoice;
							end
						end
						curHelp = string.format(curHelp, curChoices);
					end
					
					--If we have aliases for this sub command then make a list
					local comList = MCom.SlashComs[commandid].commands[curCom].command[1];
					if (getn(MCom.SlashComs[commandid].commands[curCom].command) > 1) then
						for curAlias = 2, getn(MCom.SlashComs[commandid].commands[curCom].command) do
							comList = comList.."/"..MCom.SlashComs[commandid].commands[curCom].command[curAlias];
						end
					end
		
					--Prepare the type string
					local curComTypeString = curComType;
					if ( curComType == MCOM_MULTIT ) then
						curComTypeString = MCOM_NUMT;
					end
					if ( curComMulti and (curComType == MCOM_CHOICET) ) then
						curComTypeString = MCOM_CHAT_C_M;
					end
					if ( curComOpacity and (curComType == MCOM_COLORT) ) then
						curComTypeString = MCOM_CHAT_K_O;
					end
					if ( curComBool and (not (curComType == MCOM_BOOLT) ) ) then
						curComTypeString = MCOM_BOOLT..curComTypeString;
					end
					--If we have a number type, then display the min and max values
					if ( ( curComType == MCOM_NUMT ) or ( curComType == MCOM_MULTIT ) ) then
						local curRangeString = nil;
						if (curComMin) then
							curRangeString = string.format(MCOM_CHAT_COM_N_MIN, curComMin * curComMul);
						end
						if (curComMax) then
							if (curRangeString) then
								curRangeString = curRangeString..", ";
							else
								curRangeString = "";
							end
							curRangeString = curRangeString..string.format(MCOM_CHAT_COM_N_MAX, curComMax * curComMul);
						end
						if (curRangeString) then
							curComTypeString = curComTypeString..string.format(MCOM_CHAT_COM_N_RANGE, curRangeString);
						end
					end

					--Prepare the command info
					local curValString = nil;
					if ( ( curComType == MCOM_SIMPLET ) or ( curComValue == nil ) ) then
						chatLine = string.format(MCOM_CHAT_COM_SUBCOMMAND_S, comList, curComTypeString, curHelp);
					elseif ( curComValue ~= nil ) then
						--If it is a bool, or has a bool, then get the boolean part
						if ( curComBool or ( curComType == MCOM_BOOLT ) ) then
							if ( curComValue == 1 ) then
								curValString = MCOM_CHAT_ON;
							else
								curValString = MCOM_CHAT_OFF;
							end
						end
						--If this doesn't have a boolean part, then handle curcomvalue
						if (not curComBool) then
							--Handle number type
							if ( ( curComType == MCOM_NUMT ) or ( curComType == MCOM_MULTIT ) ) then
								curValString = ( MCom.math.round( ( curComValue * curComMul ) * 100 ) / 100 );
							end
							--Handle string type
							if ( curComType == MCOM_STRINGT ) then
								curValString = curComValue;
							end
							--If it's a choice type, then handle the one choice, or a list of choices
							if (curComType == MCOM_CHOICET) then
								--If we don't have a table of choices, then just use the values
								if ( type(curComChoices) ~= "table" ) then
									--If this can not have multiple choices, then use just the one
									if (not curComMulti) then
										curValString = curComValue;
									elseif ( type(curComValue) == "table" ) then
										--This is a multi choice selection, so make a list of selected choices
										curValString = curComValue[1];
										if ( curValString ~= nil ) then
											for curVal = 2, table.getn(curComValue) do
												if ( curComValue[curVal] ~= nil ) then
													curValString = curValString..", "..curComValue[curVal];
												end
											end
										end
									end
								else
									--If we have a table of choices, then make a table indexed by value
									local curChoiceDex = {};
									for curChoice in curComChoices do
										curChoiceDex[curComChoices[curChoice]] = curChoice;
									end
									--If this can not have multiple choices, then use just the one
									if (not curComMulti) then
										curValString = curChoiceDex[curComValue];
									elseif ( type(curComValue) == "table" ) then
										--This is a multi choice selection, so make a list of selected choices
										curValString = curChoiceDex[curComValue[1]];
										if ( curValString ~= nil ) then
											for curVal = 2, table.getn(curComValue) do
												if ( ( curComValue[curVal] ~= nil ) and ( curChoiceDex[curComValue[curVal]] ~= nil ) ) then
													curValString = curValString..", "..curChoiceDex[curComValue[curVal]];
												end
											end
										end
									end
								end
							end
							--If it's a color type, then handle the color parts
							if (curComType == MCOM_COLORT) then
								if ( type(curComValue) == "table" ) then
									local curColString = "";
									if (curComValue.r) then
										curColString = string.format(MCOM_CHAT_COM_K_R, MCom.math.round(curComValue.r * 100));
									end
									if (curComValue.g) then
										if ( curColString ~= "" ) then
											curColString = curColString..", ";
										end
										curColString = curColString..string.format(MCOM_CHAT_COM_K_G, MCom.math.round(curComValue.g * 100));
									end
									if (curComValue.b) then
										if ( curColString ~= "" ) then
											curColString = curColString..", ";
										end
										curColString = curColString..string.format(MCOM_CHAT_COM_K_B, MCom.math.round(curComValue.b * 100));
									end
									if (curComOpacity) then
										local displayOpacity = 1;
										if (curComValue.opacity) then
											displayOpacity = curComValue.opacity;
										end
										if ( curColString ~= "" ) then
											curColString = curColString..", ";
										end
										curColString = curColString..string.format(MCOM_CHAT_COM_K_O, MCom.math.round(displayOpacity * 100));
									end
									if ( curColString ~= "" ) then
										curColString = curColString..", ";
									end
									curColString = curColString..string.format(MCOM_CHAT_COM_K_X, MCom.string.colorToString(curComValue));
									curValString = curColString;
								end
							end
						elseif ( curComValueMulti ~= nil ) then
							--If we have a second variable, then prepare the second part of the string
							if ( curValString == nil ) then
								curValString = "";
							else
								curValString = curValString..", ";
							end
							--Handle number type
							if ( ( curComType == MCOM_NUMT ) or ( curComType == MCOM_MULTIT ) ) then
								curValString = curValString..( MCom.math.round( ( curComValueMulti * curComMul ) * 100 ) / 100 );
							end
							--Handle string type
							if ( curComType == MCOM_STRINGT ) then
								curValString = curValString..curComValueMulti;
							end
							--If it's a choice type, then handle the one choice, or a list of choices
							if (curComType == MCOM_CHOICET) then
								--If we don't have a table of choices, then just use the values
								if ( type(curComChoices) ~= "table" ) then
									--If this can not have multiple choices, then use just the one
									if (not curComMulti) then
										curValString = curValString..curComValueMulti;
									elseif ( type(curComValueMulti) == "table" ) then
										--This is a multi choice selection, so make a list of selected choices
										curValString = curValString..curComValueMulti[1];
										if ( curComValueMulti[1] ~= nil ) then
											for curVal = 2, table.getn(curComValueMulti) do
												if ( curComValueMulti[curVal] ~= nil ) then
													curValString = curValString..", "..curComValueMulti[curVal];
												end
											end
										end
									end
								else
									--If we have a table of choices, then make a table indexed by value
									local curChoiceDex = {};
									for curChoice in curComChoices do
										curChoiceDex[curComChoices[curChoice]] = curChoice;
									end
									--If this can not have multiple choices, then use just the one
									if (not curComMulti) then
										curValString = curValString..curChoiceDex[curComValueMulti];
									elseif ( type(curComValueMulti) == "table" ) then
										--This is a multi choice selection, so make a list of selected choices
										curValString = curValString..curChoiceDex[curComValueMulti[1]];
										if ( curChoiceDex[curComValueMulti[1]] ~= nil ) then
											for curVal = 2, table.getn(curComValueMulti) do
												if ( ( curComValueMulti[curVal] ~= nil ) and ( curChoiceDex[curComValueMulti[curVal]] ~= nil ) ) then
													curValString = curValString..", "..curChoiceDex[curComValueMulti[curVal]];
												end
											end
										end
									end
								end
							end
							--If it's a color type, then handle the color parts
							if (curComType == MCOM_COLORT) then
								if ( type(curComValueMulti) == "table" ) then
									local curColString = "";
									if (curComValueMulti.r) then
										curColString = string.format(MCOM_CHAT_COM_K_R, MCom.math.round(curComValueMulti.r * 100));
									end
									if (curComValueMulti.g) then
										if ( curColString ~= "" ) then
											curColString = curColString.." ";
										end
										curColString = curColString..string.format( MCOM_CHAT_COM_K_G, MCom.math.round(curComValueMulti.g * 100));
									end
									if (curComValueMulti.b) then
										if ( curColString ~= "" ) then
											curColString = curColString.." ";
										end
										curColString = curColString..string.format(MCOM_CHAT_COM_K_B, MCom.math.round(curComValueMulti.b * 100));
									end
									if (curComOpacity) then
										if (curComValueMulti.opacity) then
											if ( curColString ~= "" ) then
												curColString = curColString.." ";
											end
											curColString = curColString..string.format(MCOM_CHAT_COM_K_O, MCom.math.round(curComValueMulti.opacity * 100));
										end
									end
									if ( curColString ~= "" ) then
										curColString = curColString..", ";
									end
									curColString = curColString..string.format(MCOM_CHAT_COM_K_X, MCom.string.colorToString(curComValueMulti));
									curValString = curValString..curColString;
								end
							end
						end
						if ( ( curValString ~= nil ) and ( curValString ~= "" ) and ( curValString ~= ", " ) ) then
							chatLine = string.format(MCOM_CHAT_COM_SUBCOMMAND, comList, curComTypeString, curValString, curHelp);
						else
							chatLine = string.format(MCOM_CHAT_COM_SUBCOMMAND_S, comList, curComTypeString, curHelp);
						end
					end

					--Print out the command info
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
			else
				--This is a simple command, find out what type it is, and set the correct sample
				if (MCom.SlashComs[commandid].comtype == MCOM_BOOLT) then
					bSample = true;
				else
					if (not MCom.SlashComs[commandid].hasbool) then
						if (MCom.SlashComs[commandid].comtype == MCOM_NUMT) then
							nSample = true;
							--Get a valid sample number
							nSampleV = MCom.SlashComs[commandid].commin;
							if (not nSampleV) then
								nSampleV = MCom.SlashComs[commandid].commax;
							end
							if (not nSampleV) then
								nSampleV = MCOM_CHAT_COM_EXAMPLE_O_N;
							end
						elseif (MCom.SlashComs[commandid].comtype == MCOM_STRINGT) then
							sSample = true;
						elseif (MCom.SlashComs[commandid].comtype == MCOM_CHOICET) then
							if (not MCom.SlashComs[commandid].multichoice) then
								cSample = true;
								--Get a valid sample choice
								for sampleV in MCom.SlashComs[commandid].choices do
									cSampleV = sampleV;
									break;
								end
							else
								cmSample = true;
								--Get a valid sample choice
								local count = 0;
								--Construct an example with two valid choices
								for sampleV in MCom.SlashComs[commandid].choices do
									count = count + 1;
									if (cmSampleV) then
										cmSampleV = cmSampleV.." "..sampleV;
									else
										cmSampleV = sampleV;
									end
									if (count > 1) then
										break;
									end
								end
							end
						elseif (MCom.SlashComs[commandid].comtype == MCOM_COLORT) then
							if (not MCom.SlashComs[commandid].hasopacity) then
								kSample = true;
							else
								okSample = true;
							end
						else
							eSample = true;
						end
					else
						if (MCom.SlashComs[commandid].comtype == MCOM_NUMT) then
							bnSample = true;
						elseif (MCom.SlashComs[commandid].comtype == MCOM_MULTIT) then
							bnSample = true;
							--Get a valid sample number
							bnSampleV = MCom.SlashComs[commandid].commin;
							if (not bnSampleV) then
								bnSampleV = MCom.SlashComs[commandid].commax;
							end
							if (not bnSampleV) then
								bnSampleV = MCOM_CHAT_COM_EXAMPLE_O_N;
							end
						elseif (MCom.SlashComs[commandid].comtype == MCOM_STRINGT) then
							bsSample = true;
						elseif (MCom.SlashComs[commandid].comtype == MCOM_CHOICET) then
							if (not MCom.SlashComs[commandid].multichoice) then
								bcSample = true;
								--Get a valid sample choice
								for sampleV in MCom.SlashComs[commandid].choices do
									bcSampleV = sampleV;
									break;
								end
							else
								bcmSample = true;
								--Get a valid sample choice
								local count = 0;
								--Construct an example with two valid choices
								for sampleV in MCom.SlashComs[commandid].choices do
									count = count + 1;
									if (bcmSampleV) then
										bcmSampleV = bcmSampleV.." "..sampleV;
									else
										bcmSampleV = sampleV;
									end
									if (count > 1) then
										break;
									end
								end
							end
						elseif (MCom.SlashComs[commandid].comtype == MCOM_COLORT) then
							if (not MCom.SlashComs[commandid].hasopacity) then
								bkSample = true;
							else
								bokSample = true;
							end
						else
							eSample = true;
						end
					end
				end
			end	
			
			--Print basic usage info
			local usageLine = MCOM_CHAT_COM_USAGE;
			if (bSample or bnSample or bsSample or bcSample or bcmSample or bkSample or bkoSample) then
				usageLine = usageLine.."\n\n"..MCOM_CHAT_COM_USAGE_B;
			end
			if (bnSample) then
				usageLine = usageLine.."\n\n"..string.format(MCOM_CHAT_COM_USAGE_B_M, MCOM_NUMT, MCOM_CHAT_COM_USAGE_B_N);
			elseif (bsSample) then
				usageLine = usageLine.."\n\n"..string.format(MCOM_CHAT_COM_USAGE_B_M, MCOM_STRINGT, MCOM_CHAT_COM_USAGE_B_S);
			elseif (bcSample or bcmSample) then
				usageLine = usageLine.."\n\n"..string.format(MCOM_CHAT_COM_USAGE_B_M, MCOM_CHOICET, MCOM_CHAT_COM_USAGE_B_C);
			elseif (bkSample or bkoSample) then
				usageLine = usageLine.."\n\n"..string.format(MCOM_CHAT_COM_USAGE_B_M, MCOM_COLORT, MCOM_CHAT_COM_USAGE_B_K);
			end
			asString = MCom.PrintSlashCommandLine(asString, usageLine, true);
			
			--Print detailed usage info
			if (isSimple) then
				--If its simple we print the simple versions of the usage info, but only for the command type
				if (eSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_S_E, basecommand);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (bSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_S_S, basecommand, MCOM_CHAT_COM_B);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (nSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_S_S, basecommand, MCOM_CHAT_COM_N);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (sSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_S_S, basecommand, MCOM_CHAT_COM_S);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (cSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_S_S, basecommand, MCOM_CHAT_COM_C);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (cmSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_S_S, basecommand, MCOM_CHAT_COM_C_M);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (kSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_S_S, basecommand, MCOM_CHAT_COM_K);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (koSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_S_S, basecommand, MCOM_CHAT_COM_K_O);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (bnSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_S_M, basecommand, MCOM_CHAT_COM_N);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (bsSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_S_M, basecommand, MCOM_CHAT_COM_S);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (bcSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_S_M, basecommand, MCOM_CHAT_COM_C);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (bcmSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_S_M, basecommand, MCOM_CHAT_COM_C_M);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (bkSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_S_M, basecommand, MCOM_CHAT_COM_K);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (bkoSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_S_M, basecommand, MCOM_CHAT_COM_K_O);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
			else
				--If its not simple then we print usage info for any type of subcommand used
				if (eSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_E, basecommand);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (bSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_S, MCOM_BOOLT, basecommand, MCOM_CHAT_COM_B);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (nSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_S, MCOM_NUMT, basecommand, MCOM_CHAT_COM_N);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (sSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_S, MCOM_STRINGT, basecommand, MCOM_CHAT_COM_S);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (cSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_S, MCOM_CHOICET, basecommand, MCOM_CHAT_COM_C);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (cmSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_S, MCOM_CHAT_C_M, basecommand, MCOM_CHAT_COM_C_M);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (kSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_S, MCOM_COLORT, basecommand, MCOM_CHAT_COM_K);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (koSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_S, MCOM_CHAT_K_O, basecommand, MCOM_CHAT_COM_K_O);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (bnSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_M, MCOM_BOOLT..MCOM_NUMT, basecommand, MCOM_CHAT_COM_N);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (bsSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_M, MCOM_BOOLT..MCOM_STRINGT, basecommand, MCOM_CHAT_COM_S);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (bcSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_M, MCOM_BOOLT..MCOM_CHOICET, basecommand, MCOM_CHAT_COM_C);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (bcmSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_M, MCOM_BOOLT..MCOM_CHAT_C_M, basecommand, MCOM_CHAT_COM_C_M);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (bkSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_M, MCOM_BOOLT..MCOM_COLORT, basecommand, MCOM_CHAT_COM_K);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
				if (bkoSample) then
					chatLine = string.format(MCOM_CHAT_COM_USAGE_M, MCOM_BOOLT..MCOM_CHAT_K_O, basecommand, MCOM_CHAT_COM_K_M);
					asString = MCom.PrintSlashCommandLine(asString, chatLine, true);
				end
			end
			
			--Print extra help for the command
			if (MCom.SlashComs[commandid].extrahelp) then
				if (type(MCom.SlashComs[commandid].extrahelp) ~= "table") then
					MCom.SlashComs[commandid].extrahelp = { MCom.SlashComs[commandid].extrahelp };
				end
				--Add an extra line before the extra help
				if (asString) then
					asString = asString.."\n";
				end
				for curHelp in MCom.SlashComs[commandid].extrahelp do
					asString = MCom.PrintSlashCommandLine(asString, MCom.SlashComs[commandid].extrahelp[curHelp]);
				end
			end
			
			--Print example usage
			asString = MCom.PrintSlashCommandLine(asString, MCOM_CHAT_COM_EXAMPLE, true);
			if (isSimple) then
				--If it's simple we print an example for the appropriate type
				if (eSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_S_E, basecommand);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (bSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_S_S, basecommand, MCOM_CHAT_COM_EXAMPLE_O_B);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (nSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_S_S, basecommand, nSampleV);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (sSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_S_S, basecommand, MCOM_CHAT_COM_EXAMPLE_O_S);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (cSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_S_S, basecommand, cSampleV);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (cmSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_S_S, basecommand, cmSampleV);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (kSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_S_S, basecommand, MCOM_CHAT_COM_EXAMPLE_O_K);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (koSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_S_S, basecommand, MCOM_CHAT_COM_EXAMPLE_O_K_O);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (bnSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_S_M, basecommand, bnSampleV);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (bsSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_S_M, basecommand, MCOM_CHAT_COM_EXAMPLE_O_S);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (bcSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_S_M, basecommand, bcSampleV);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (bcmSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_S_M, basecommand, bcmSampleV);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (bkSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_S_M, basecommand, MCOM_CHAT_COM_EXAMPLE_O_K);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (bkoSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_S_M, basecommand, MCOM_CHAT_COM_EXAMPLE_O_K_O);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
			else
				--If it's not simple we print an example for each type used
				if (eSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_E, basecommand, eSample);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (bSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_S, basecommand, bSample, MCOM_CHAT_COM_EXAMPLE_O_B);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (nSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_S, basecommand, nSample, nSampleV);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (sSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_S, basecommand, sSample, MCOM_CHAT_COM_EXAMPLE_O_S);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (cSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_S, basecommand, cSample, cSampleV);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (cmSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_S, basecommand, cmSample, cmSampleV);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (kSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_S, basecommand, kSample, MCOM_CHAT_COM_EXAMPLE_O_K);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (koSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_S, basecommand, koSample, MCOM_CHAT_COM_EXAMPLE_O_K_O);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (bnSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_M, basecommand, bnSample, bnSampleV);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (bsSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_M, basecommand, bsSample, MCOM_CHAT_COM_EXAMPLE_O_S);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (bcSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_M, basecommand, bcSample, bcSampleV);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (bcmSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_M, basecommand, bcmSample, bcmSampleV);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (bkSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_M, basecommand, bkSample, MCOM_CHAT_COM_EXAMPLE_O_K);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
				if (bkoSample) then
					chatLine = string.format(MCOM_CHAT_COM_EXAMPLE_M, basecommand, bkoSample, MCOM_CHAT_COM_EXAMPLE_O_K_O);
					asString = MCom.PrintSlashCommandLine(asString, chatLine);
				end
			end
		end
		--Return the string
		return asString;
	end;
	
	--[[ The Cosmos callback function handler ]]--
	MCom.SetFromUI = function (option, checked, value)
		if (not MCom.UIFuncList) then
			MCom.UIFuncList = {};
		end
		
		--Get the info for this function
		local funcInfo = MCom.UIFuncList[option];
		if (funcInfo) then
			local func = funcInfo.func;
			local funcType = funcInfo.uitype;
			--Call the appropriate kind of function for this kind of element
			if (func and funcType) then
				if (funcType == "CHECKBOX") then
					func(checked);
				elseif (funcType == "SLIDER") then
					func(value);
				elseif (funcType == "BOTH") then
					func(checked, value);
				else
					func();
				end
			end
		end
	end;
	
	--[[ The Khaos callback function handler ]]--
	MCom.SetFromKUI = function (option, state, keypressed, choices)
		if (not MCom.UIFuncList) then
			MCom.UIFuncList = {};
		end
		
		--Get the info for this function
		local funcInfo = MCom.UIFuncList[option];
		if (funcInfo) then
			local func = funcInfo.func;
			local funcType = funcInfo.uitype;
			
			--split into hasbool and not hasbool sections.
			
			--Call the appropriate kind of function for this kind of element
			if (func and funcType) then
				local checked = nil;
				if (funcInfo.hasbool) then
					checked = 0;
					if (state and state.checked) then
						checked = 1;
					end
				end
				
				local value = nil;
				local name = nil;
				--If it's a bool then call it as such
				if ((funcType == K_TEXT) and funcInfo.hasbool) then
					func(checked);
				else
					--Handle the value from the right variable for this type
					if (funcType == K_SLIDER) then
						value = state.slider;
					elseif ( funcType ==  K_EDITBOX ) then
						value = state.value;
					elseif (funcType == K_PULLDOWN) then
						value = state.value;
						--If we don't have a table of choices, then just use the values
						if ( type(choices) ~= "table" ) then
							--If this can not have multiple choices, then use just the one
							if ( type(value) ~= "table" ) then
								name = value;
							else
								--This is a multi choice selection, so make a list of selected choices
								name = value[1];
								if ( name ~= nil ) then
									for curVal = 2, table.getn(value) do
										if ( value[curVal] ~= nil ) then
											name = name..", "..value[curVal];
										end
									end
								end
							end
						else
							--If we have a table of choices, then make a table indexed by value
							local curChoiceDex = {};
							for curChoice in choices do
								curChoiceDex[choices[curChoice]] = curChoice;
							end
							--If this can not have multiple choices, then use just the one
							if ( type(value) ~= "table" ) then
								name = curChoiceDex[value];
							else
								--This is a multi choice selection, so make a list of selected choices
								name = curChoiceDex[value[1]];
								if ( name ~= nil ) then
									for curVal = 2, table.getn(value) do
										if ( ( value[curVal] ~= nil ) and ( curChoiceDex[value[curVal]] ~= nil ) ) then
											name = name..", "..curChoiceDex[value[curVal]];
										end
									end
								end
							end
						end
					elseif (funcType ==  K_COLORPICKER) then
						value = state.color;
					end
					
					--If it's a button, then just call it
					if (funcType == K_BUTTON) then
						func();
					else
						--If it has a bool call it with the bool, and the value, otherwise, just the value
						if (funcInfo.hasbool) then
							func(checked, value, name);
						else
							func(value, name);
						end
					end
				end
			end
		end
	end;

	--------------------------------------------------
	--
	-- Hooked Functions
	--
	--------------------------------------------------
	MCom.ItemTextPrevPage = function ()
		--Switch to the previous page if there is one
		if ( type(MCom.CurText) == "table" ) then
			local TextFrame = "MComText";
			if ( not getglobal(TextFrame.."Frame") ) then
				TextFrame = "ItemText";
			end
			if ( MCom.CurTextPage > 1 ) then
				--Store the current position and range of the scrollbar so we can restore this, the next time the page is visited
				MCom.CurText.Scroll[MCom.CurTextPage].Value = getglobal(TextFrame.."ScrollFrameScrollBar"):GetValue();
				MCom.CurText.Scroll[MCom.CurTextPage].Range = getglobal(TextFrame.."ScrollFrame"):GetVerticalScrollRange();
				--Flip the page
				MCom.CurTextPage = MCom.CurTextPage - 1;
				--If a scroll range was recorded for this page, then adjust to those values
				if (MCom.CurText.Scroll[MCom.CurTextPage].Range) then
					getglobal(TextFrame.."ScrollFrameScrollBar"):SetMinMaxValues(0, MCom.CurText.Scroll[MCom.CurTextPage].Range);
				end
				--Update the page
				MCom.UpdateTextPage();
			end
		else
			MCom.CurText = nil;
		end
	end;

	MCom.ItemTextNextPage = function ()
		--Switch to the previous page if there is one
		if ( type(MCom.CurText) == "table" ) then
			local TextFrame = "MComText";
			if ( not getglobal(TextFrame.."Frame") ) then
				TextFrame = "ItemText";
			end
			if ( MCom.CurTextPage < table.getn(MCom.CurText) ) then
				--Store the current position and range of the scrollbar so we can restore this, the next time the page is visited
				MCom.CurText.Scroll[MCom.CurTextPage].Value = getglobal(TextFrame.."ScrollFrameScrollBar"):GetValue();
				MCom.CurText.Scroll[MCom.CurTextPage].Range = getglobal(TextFrame.."ScrollFrame"):GetVerticalScrollRange();
				--Flip the page
				MCom.CurTextPage = MCom.CurTextPage + 1;
				--If a scroll range was recorded for this page, then adjust to those values
				if (MCom.CurText.Scroll[MCom.CurTextPage].Range) then
					getglobal(TextFrame.."ScrollFrameScrollBar"):SetMinMaxValues(0, MCom.CurText.Scroll[MCom.CurTextPage].Range);
				end
				--Update the page
				MCom.UpdateTextPage();
			end
		else
			MCom.CurText = nil;
		end
	end;
	
	--When the item text is closed, let's reset it to normal, and confirm that MCom
	--can now make use of it
	MCom.CloseItemText = function ()
		local TextFrame = "MComText";
		if ( not getglobal(TextFrame.."Frame") ) then
			TextFrame = "ItemText";
		end
		MCom.CurText = nil;
		MCom.NoTextAvail = nil;
		--Remove the vertex color
		getglobal(TextFrame.."MaterialTopLeft"):SetVertexColor(1,1,1);
		getglobal(TextFrame.."MaterialTopRight"):SetVertexColor(1,1,1);
		getglobal(TextFrame.."MaterialBotLeft"):SetVertexColor(1,1,1);
		getglobal(TextFrame.."MaterialBotRight"):SetVertexColor(1,1,1);
		
		--Resize the text to normal
		if (MCom.PageWidth and MCom.PageScale) then
			getglobal(TextFrame.."PageText"):SetWidth(MCom.PageWidth);
			getglobal(TextFrame.."PageText"):SetScale(MCom.PageScale);
		end
	end;

	MCom.ItemTextFrame_OnEvent = function (event)
		--If the game is doing something with the text frame, then clear the MCom text
		--and set the frame as unavailable for MCom to use
		if (	( event == "ITEM_TEXT_BEGIN" ) or ( event == "ITEM_TEXT_TRANSLATION" ) or
					( event == "ITEM_TEXT_READY" ) ) then
			local TextFrame = "MComText";
			if ( not getglobal(TextFrame.."Frame") ) then
				TextFrame = "ItemText";
				MCom.CurText = nil;
				MCom.NoTextAvail = true;
				--Remove the vertex color
				getglobal(TextFrame.."MaterialTopLeft"):SetVertexColor(1,1,1);
				getglobal(TextFrame.."MaterialTopRight"):SetVertexColor(1,1,1);
				getglobal(TextFrame.."MaterialBotLeft"):SetVertexColor(1,1,1);
				getglobal(TextFrame.."MaterialBotRight"):SetVertexColor(1,1,1);
				
				--Resize the text to normal
				if (MCom.PageWidth and MCom.PageScale) then
					getglobal(TextFrame.."PageText"):SetWidth(MCom.PageWidth);
					getglobal(TextFrame.."PageText"):SetScale(MCom.PageScale);
				end
			end
		end
	end;
	
	MCom.myAddOnsFrame_OnEvent = function ()
		--If this is variables loaded, then load in the MCom registered addons
		if (event == "VARIABLES_LOADED") then
			MCom.MyAddOnsLoaded = true;
			--If this vesion of myAddons supports the registration method, then use it
			if(myAddOnsFrame_Register) then
				for curAddon in MCom.MyAddOnsList do
					local help = nil;
					--If we have a table of help, then get a copy of it, and add the slash command help if available
					if ( type(MCom.MyAddOnsList[curAddon].help) == "table" ) then
						help = MCom.table.copy(MCom.MyAddOnsList[curAddon].help);
						if (MCom.MyAddOnsList[curAddon].supercom) then
							--Add the slash command info on to it
							help[table.getn(help) + 1] = MCom.PrintSlashCommandInfo(MCom.getComID(MCom.MyAddOnsList[curAddon].supercom), true);
						end
					elseif ( ( MCom.MyAddOnsList[curAddon].help == "boolean" ) and MCom.MyAddOnsList[curAddon].help and MCom.MyAddOnsList[curAddon].supercom ) then
						--If help is a boolean and we have slash command info, then generate the help from the slash command info
						help = MCom.PrintSlashCommandInfo(MCom.getComID(MCom.MyAddOnsList[curAddon].supercom), true);
					end
					 -- Register the addon in myAddOns
					myAddOnsFrame_Register(MCom.MyAddOnsList[curAddon].details, help);
				end
			else
				--Use the old method of adding an addon to the list
				for curAddon in MCom.MyAddOnsList do
					myAddOnsList[curAddon] = MCom.MyAddOnsList[curAddon].details;
				end
			end
		end
	end;

	MCom.UIParent_OnEvent = function ()
		if ( event == "VARIABLES_LOADED" ) then
			if (not MCom.didVarsLoaded) then
				MCom.didVarsLoaded = true;
				--If we have anything that needs to be safe loaded, then load it now
				if ( type(MCom.safeLoads) == "table" ) then
					local curConfig;
					if ( type(MCom.safeLoads.varsLoaded) == "table" ) then
						--Load any safe load that has changed
						for curLoad in MCom.safeLoads.varsLoaded do
							--Get the variable for the current safe load
							curConfig = MCom.getStringVar(curLoad);
							--Load the stored data into the empty entries of the current config if the table has been replaced
							if ( ( type(curConfig) == "table" ) and ( curConfig ~= MCom.safeLoads.varsLoaded[curLoad] ) ) then
								MCom.LoadSafeTable( curConfig, MCom.safeLoads.varsLoaded[curLoad] );
							end
						end
					end

					--Deal with any old style entries
					for curLoad in MCom.safeLoads do
						if ( ( curLoad ~= "addonLoaded" ) and ( curLoad ~= "varsLoaded" ) ) then
							--Get the variable for the current safe load
							curConfig = MCom.getStringVar(curLoad);
							--Load the stored data into the empty entries of the current config
							if ( ( type(curConfig) == "table" ) ) then
								MCom.LoadSafeTable( curConfig, MCom.safeLoads[curLoad] );
							end
						end
					end
				end

				--Clear the safe loads table
				MCom.safeLoads = nil;

				--If we are using this as the vars loaded event, then call the vars loaded callbacks
				if (MCom.UseVarsLoadedEvent) then
					MCom.VariablesLoaded();
				end
			end
		end

		if ( event == "ADDON_LOADED" ) then
			--If we have anything that needs to be safe loaded, then load it now
			if ( type(MCom.safeLoads) == "table" ) then
				local curConfig;
				if ( type(MCom.safeLoads.addonLoaded) == "table" ) then
					--Load any safe load that has changed
					for curLoad in MCom.safeLoads.addonLoaded do
						--Get the variable for the current safe load
						curConfig = MCom.getStringVar(curLoad);
						--Load the stored data into the empty entries of the current config if the table has been replaced
						if ( ( type(curConfig) == "table" ) and ( curConfig ~= MCom.safeLoads.addonLoaded[curLoad] ) ) then
							MCom.LoadSafeTable( curConfig, MCom.safeLoads.addonLoaded[curLoad] );
							--Move the entry to the variables loaded table to be checked for loading once more
							MCom.safeLoads.varsLoaded[curLoad] = MCom.safeLoads.addonLoaded[curLoad];
							MCom.safeLoads.addonLoaded[curLoad] = nil;
						end
					end
				end
				
				--Deal with any old style entries
				for curLoad in MCom.safeLoads do
					if ( ( curLoad ~= "addonLoaded" ) and ( curLoad ~= "varsLoaded" ) ) then
						--Get the variable for the current safe load
						curConfig = MCom.getStringVar(curLoad);
						--Load the stored data into the empty entries of the current config
						if ( ( type(curConfig) == "table" ) ) then
							MCom.LoadSafeTable( curConfig, MCom.safeLoads[curLoad] );
						end
					end
				end
			end
		end
	end

	--------------------------------------------------
	--
	-- Sea Wrapper Functions
	--
	--------------------------------------------------
	--Wrappers used to ensure MCom functions without Sea, for those who just
	--absolutely refuse to use Sea
	MCom.math = {};
	MCom.math.round = function (x)
		if (Sea and Sea.math and Sea.math.round) then
			--Call origional
			return Sea.math.round(x);
		else
			--Same as origional
			if(x - math.floor(x) > 0.5) then
				x = x + 0.5;
			end
			return math.floor(x);
		end
	end;

	MCom.math.hexFromInt = function (intval, minlength)
		if (Sea and Sea.math and Sea.math.hexFromInt) then
			--Call origional
			return Sea.math.hexFromInt(intval, minlength);
		else
			--Same as origional
			if ( minlength == nil )	then 
				minlength = "2";
			end
			return string.format("%"..minlength.."x", intval );
		end
	end;

	MCom.table = {};
	MCom.table.copy = function ( t, recursionList ) 
		if (Sea and Sea.table and Sea.table.copy) then
			--Call origional
			return Sea.table.copy(t, recursionList);
		else
			--Same as origional
			if ( not recursionList ) then recursionList = {} end;
			if ( type(t) ~= "table" ) then 
				return t;
			end
	
			local newTable = {};
			if ( recursionList[t] ) then
				return recursionList[t];
			else
				recursionList[t] = newTable;
				for k,v in t do
					--If it's a table we want to recurse.  But the second half of this if checks to see if it
					--is a reference to a frame, which looks like a table, and does a normal copy in such a
					--case
					if ( ( type(v) == "table" ) and not ( v[0] and ( type(v[0]) == "userdata" ) ) ) then 
						newTable[k] = MCom.table.copy(v, recursionList);
					else
						newTable[k] = v;
					end
				end
	
				return newTable;
			end
		end
	end;

	MCom.table.push = function ( table, val ) 
		if (Sea and Sea.table and Sea.table.copy) then
			--Call origional
			return Sea.table.push(table, val);
		else
			--Same as origional
			if(not table or not table.n) then
				return nil;
			end
			table.n = table.n+1;
			table[table.n] = val;
		end
	end;

	MCom.IO = {};
	MCom.IO.printc = function ( color, pString )
		if (Sea and Sea.IO and Sea.IO.printc) then
			--Call origional
			Sea.IO.printc(color, pString);
		else
			--Simple colored print, not as capable as Sea's functions
			if ( color == nil ) then 
				color = NORMAL_FONT_COLOR;
			end
			ChatFrame1:AddMessage(pString, color.r, color.g, color.b);
		end
	end;
	
	MCom.util = {};
	MCom.util.split = function ( text, separator, oldTable, noPurge )
		if (Sea and Sea.util and Sea.util.split and Sea.version) then
			--Call origional
			return Sea.util.split( text, separator, oldTable, noPurge );
		else
			--Using Legorols version
			local value;
    	local init, mstart, mend = 1;
			local t, oldn = oldTable, 0;
			
			if ( not t ) then
				t = {};
			else
				oldn = table.getn(t);
				table.setn(t, 0);
			end
			
			-- Using string.find instead of string.gfind to avoid garbage generation		
	    repeat
				mstart, mend, value = string.find(text, "([^"..separator.."]+)", init);
				if ( value ) then
					table.insert(t, value)
					init = mend + 1;
				end
	    until not value;
			
			if ( not noPurge ) then
				for i = table.getn(t)+1, oldn do
					t[i] = nil;
				end
			end
			
			return t;
		end
	end;
	
	MCom.util.hook = function (orig, new, hooktype, scriptElementName)
		if (Sea and Sea.util and Sea.util.hook and Sea.version and ( Sea.version >= 1.05 ) ) then
			Sea.util.hook(orig, new, hooktype, scriptElementName);
		else
			--Modified hook function from origional, uses Sea's hook list if available
			if (not MCom.util.Hooks) then
				MCom.util.Hooks = {};
			end
			local hookList = MCom.util.Hooks;

			--If Sea is around, then use it's list
			if (Sea and Sea.util and Sea.util.hook) then
				if(not Sea.util.Hooks) then
					Sea.util.Hooks = {};
				end
				hookList = Sea.util.Hooks;
			end

			local origCopy = orig;
			if (scriptElementName) then
				orig = orig.."."..scriptElementName;
			end

			if(not hooktype) then
				hooktype = "before";
			end
			if(not hookList[orig]) then
				hookList[orig] = {};
				hookList[orig].before = {};
				hookList[orig].before.n = 0;
				hookList[orig].after = {};
				hookList[orig].after.n = 0;
				hookList[orig].hide = {};
				hookList[orig].hide.n = 0;
				hookList[orig].replace = {};
				hookList[orig].replace.n = 0;
				hookList[orig].orig = MCom.getStringVar(orig);
				-- Set up the hook the first time
				if (scriptElementName) then
					hookList[orig].orig = MCom.getStringVar(origCopy):GetScript(scriptElementName);
					MCom.getStringVar(origCopy):SetScript(scriptElementName, function(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20) return MCom.util.hookHandler(orig,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20); end);
				else
					hookList[orig].orig = MCom.getStringVar(orig);
					MCom.setStringVar(orig,function(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20) return MCom.util.hookHandler(orig,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20); end);
				end
			else
				for key,value in hookList[orig][hooktype] do
					-- NOTE THIS SHOULD BE VALUE! VALUE! *NOT* KEY!
					if(value == MCom.getStringVar(new)) then
						return;
					end
				end
			end
			-- intentionally will error if bad type is passed
			MCom.table.push(hookList[orig][hooktype], MCom.getStringVar(new));
		end
	end;

	MCom.util.unhook = function (orig, new, hooktype, scriptElementName)
		if (Sea and Sea.util and Sea.util.unhook and Sea.version and ( Sea.version >= 1.05 ) ) then
			Sea.util.unhook(orig, new, hooktype, scriptElementName);
		else
			--Modified unhook function from origional, uses Sea's hook list if available
			if (not MCom.util.Hooks) then
				MCom.util.Hooks = {};
			end		
			local hookList = MCom.util.Hooks;
			--If Sea is around, then use it's list
			if (Sea and Sea.util and Sea.util.hook) then
				if(not Sea.util.Hooks) then
					Sea.util.Hooks = {};
				end
				hookList = Sea.util.Hooks;
			end

			if(not hooktype) then
				hooktype = "before";
			end
			local l,g;
			local origCopy = orig;
			if (scriptElementName) then
				orig = orig.."."..scriptElementName;
			end
			if(not hookList[orig]) then
				hookList[orig] = {};
				hookList[orig].before = {};
				hookList[orig].before.n = 0;
				hookList[orig].after = {};
				hookList[orig].after.n = 0;
				hookList[orig].hide = {};
				hookList[orig].hide.n = 0;
				hookList[orig].replace = {};
				hookList[orig].replace.n = 0;
				if (scriptElementName) then
					hookList[orig].orig = MCom.getStringVar(origCopy):GetScript(scriptElementName);
					MCom.getStringVar(origCopy):SetScript(scriptElementName, function(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20) return MCom.util.hookHandler(orig,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20); end);
				else
					hookList[orig].orig = MCom.getStringVar(orig);
					MCom.setStringVar(orig,function(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20) return MCom.util.hookHandler(orig,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20); end);
				end
			end
			l = hookList[orig][hooktype];
			g = MCom.getStringVar(new);
			if ( l ) then 
				for key,value in l do
					if(value == g) then
						l[key] = nil;
						return;
					end
				end
			end
		end
	end;

	if (Sea and Sea.util and Sea.util.hookHandler and Sea.version) then
		MCom.util.hookHandler = Sea.util.hookHandler;
	else
		MCom.util.hookHandler = function (name,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)
			local called = false;
			local continue = true;
			local retval = nil;
			local ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9,ra10,ra11,ra12,ra13,ra14,ra15,ra16,ra17,ra18,ra19,ra20;
			local hookList = MCom.util.Hooks;

			--If Sea is around, then use it's list
			if (Sea and Sea.util and Sea.util.hook) then
				hookList = Sea.util.Hooks;
			end

			if ( not hookList[name] ) then
				hookList[name] = {};
				hookList[name].before = {};
				hookList[name].before.n = 0;
				hookList[name].after = {};
				hookList[name].after.n = 0;
				hookList[name].hide = {};
				hookList[name].hide.n = 0;
				hookList[name].replace = {};
				hookList[name].replace.n = 0;
			end
			for key,value in hookList[name].hide do
				if(type(value) == "function") then
					if(not value(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20)) then
						continue = false;
					end
					called = true;
				end
			end
			if(not continue) then
				return;
			end
			for key,value in hookList[name].before do
				if(type(value) == "function") then
					value(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
					called = true;
				end
			end
			continue = false;
			local replacedFunction = false;
			for key,value in hookList[name].replace do
				if(type(value) == "function") then
					replacedFunction = true;
					local callOrig = false;
					callOrig,ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9,ra10,ra11,ra12,ra13,ra14,ra15,ra16,ra17,ra18,ra19,ra20 = value(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
					if(callOrig) then
						continue = true;
					else
						retval = true;
					end
					called = true;
				end
			end
			if(continue or (not replacedFunction)) then
				if (hookList[name].orig) then
		  		ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9,ra10,ra11,ra12,ra13,ra14,ra15,ra16,ra17,ra18,ra19,ra20 = hookList[name].orig(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
		  	end
		  	retval = true;
			end
			for key,value in hookList[name].after do
				if(type(value) == "function") then
					value(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20);
					called = true;
				end
			end
			if(not called) then
				--[[ Disabled Complete Unhhoking Sept 17, 2005 - Incompatible with Frame Script Element Hooks - Liable to erase hooks loaded after the first hook.
				MCom.setStringVar(name,hookList[name].orig);
				hookList[name] = nil;
				]]--
			end
			if (retval) then
				if (type(ra1) == "table") then
					return unpack(ra1);
				else
					return ra1,ra2,ra3,ra4,ra5,ra6,ra7,ra8,ra9,ra10,ra11,ra12,ra13,ra14,ra15,ra16,ra17,ra18,ra19,ra20;
				end
			end
		end;
	end;

	MCom.wow = { tooltip = {}; };
	MCom.wow.tooltip.get = function ( tooltip, row, value )
		if (Sea and Sea.wow and Sea.wow.tooltip and Sea.wow.tooltip.get) then
			--Call origional
			return Sea.wow.tooltip.get( tooltip, row, value );
		else
			--Default to GameTooltip
			if (not tooltip) then
				tooltip = "GameTooltip";
			end
			--Default to first row
			if (not row) then
				row = 1;
			end

			local text, left, right, leftRed, leftGreen, leftBlue, leftAlpha, rightRed, rightGreen, rightBlue, rightAlpha;

			--Get the left tooltip
			if ( ( value == nil ) or ( value == "left" ) or ( value == "leftColor" ) ) then
				text = getglobal(tooltip.."TextLeft"..row);

				--Get the left tooltip text
				if ( ( value == nil ) or ( value == "left" ) ) then
					if ( text and text:IsVisible() ) then
						left = text:GetText();
					end
					--If this is all they want, then return it now
					if ( value == "left" ) then
						return left;
					end
				end
				--Get the left tooltip color
				if ( ( value == nil ) or ( value == "leftColor" ) ) then
					if ( text and text:IsVisible() ) then
						leftRed, leftGreen, leftBlue, leftAlpha = text:GetTextColor();
					end
					--If this is all they want, then return it now
					if ( value == "leftColor" ) then
						return leftRed, leftGreen, leftBlue, leftAlpha;
					end
				end
			end
			
			--Get the right tooltip
			if ( ( value == nil ) or ( value == "right" ) or ( value == "rightColor" ) ) then
				text = getglobal(tooltip.."TextRight"..row);

				--Get the right tooltip text
				if ( ( value == nil ) or ( value == "right" ) ) then
					if ( text and text:IsVisible() ) then
						right = text:GetText();
					end
					--If this is all they want, then return it now
					if ( value == "right" ) then
						return right;
					end
				end
				--Get the right tooltip color
				if ( ( value == nil ) or ( value == "rightColor" ) ) then

					if ( text and text:IsVisible() ) then
						rightRed, rightGreen, rightBlue, rightAlpha = text:GetTextColor();
					end
					--If this is all they want, then return it now
					if ( value == "rightColor" ) then
						return rightRed, rightGreen, rightBlue, rightAlpha;
					end
				end
			end

			--If no individual value was specified, return the entire row
			return left, right, leftRed, leftGreen, leftBlue, leftAlpha, rightRed, rightGreen, rightBlue, rightAlpha;
		end
	end;

	MCom.string = {};
	MCom.string.colorToString = function ( color )
		if (Sea and Sea.string and Sea.string.colorToString) then
			--Call origional
			return Sea.string.colorToString(color);
		else
			if ( not color ) then 
				return "FFFFFFFF";
			end
			local rString =  MCom.math.hexFromInt(math.floor(255*color.r));
			local gString =  MCom.math.hexFromInt(math.floor(255*color.g));
			local bString =  MCom.math.hexFromInt(math.floor(255*color.b));
			local aString;
		
			if ( color.a ) then 
				aString = MCom.math.hexFromInt(math.floor(255*color.a));
			elseif ( color.opacity ) then 
				aString = MCom.math.hexFromInt(math.floor(255*color.opacity));
			end
		
			if ( aString ) then
				return aString..rString..gString..bString;
			else
				return rString..gString..bString;
			end;
		end
	end;
end