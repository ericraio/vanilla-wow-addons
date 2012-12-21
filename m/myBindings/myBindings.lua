
-- Old mappings now deprecated. Left here to support addons already using them,
-- but these will be removed in the future, so update to the new format.
MYBINDINGS_CATEGORY_BARS			= "bars"
MYBINDINGS_CATEGORY_CHAT			= "chat"
MYBINDINGS_CATEGORY_CLASS			= "class"
MYBINDINGS_CATEGORY_COMBAT			= "combat"
MYBINDINGS_CATEGORY_COMPILATIONS	= "compilations"
MYBINDINGS_CATEGORY_INTERFACE		= "interface"
MYBINDINGS_CATEGORY_INVENTORY		= "inventory"
MYBINDINGS_CATEGORY_MAP				= "map"
MYBINDINGS_CATEGORY_OTHERS			= "others"
MYBINDINGS_CATEGORY_PROFESSIONS		= "professions"
MYBINDINGS_CATEGORY_QUESTS			= "quests"
MYBINDINGS_CATEGORY_RAID			= "raid"

-- Key binding to open up the myBindings window.
BINDING_HEADER_MYBINDINGS		= MYBINDINGS_NAME
BINDING_CATEGORY_MYBINDINGS		= "interface"
BINDING_NAME_MYBINDINGS_OPEN	= MYBINDINGS_KEYBIND_OPEN


--[[--------------------------------------------------------------------------
  Class Definition
-----------------------------------------------------------------------------]]

myBindings = AceAddonClass:new({
	name				 = MYBINDINGS_NAME,
	description			 = MYBINDINGS_DESCRIPTION,
	category			 = BINDING_CATEGORY_MYBINDINGS,
	optionsFrame		 = "myBindingsOptionsFrame",
	version				 = "1.3",
	releaseDate			 = "10-11-2005",
	author				 = "Turan",
	email				 = "turan@wowace.com",
	website				 = "http://www.wowace.com",
	aceCompatible		 = "100",
	db					 = AceDbClass:new("myBindingsDB"),
	cmd					 = AceChatCmdClass:new(MYBINDINGS_COMMANDS, MYBINDINGS_CMD_OPTIONS),

	maxMenuLines		 = 18,
	maxMenuLineHeight	 = 22,
	maxBindingLines		 = 17,
	maxBindingLineHeight = 25,

	categoriesSort		 = {
		MYBINDINGS_CATEGORY_GAME,
		ACE_CATEGORY_BARS,
		ACE_CATEGORY_CHAT,
		ACE_CATEGORY_CLASS,
		ACE_CATEGORY_COMBAT,
		ACE_CATEGORY_COMPILATIONS,
		ACE_CATEGORY_INTERFACE,
		ACE_CATEGORY_INVENTORY,
		ACE_CATEGORY_MAP,
		ACE_CATEGORY_OTHERS,
		ACE_CATEGORY_PROFESSIONS,
		ACE_CATEGORY_QUESTS,
		ACE_CATEGORY_RAID
	},
	gameBindings		 = {},
	currentMenuSelection = nil,
	confirmKeyBind		 = nil
})
myBindings:RegisterForLoad()

function myBindings:Initialize()
	if( myBindings_LoadCategories ) then myBindings_LoadCategories() end

	self.Msg	= function(...) self.cmd:result(format(unpack(arg))) end
	self.Error  = function(...) self.cmd:result(ACEG_LABEL_ERROR, " ", format(unpack(arg))) end

	self.savedKeyBindingFrame = KeyBindingFrame
	self.frame = myBindingsOptionsFrame
	self.currentProfile = self.profilePath[2]
end

-- Data Management

function myBindings:GetBind(val)
	if( not val ) then
		return self.db:get(self.profilePath, "bindings")
	else
		return self.db:get({self.profilePath, "bindings"}, val)
	end
end
function myBindings:SetBind(var, val)
	self.db:set({self.profilePath, "bindings"}, var, val)
end
function myBindings:ClearBinds()
	self.db:set(self.profilePath, "bindings")
end

function myBindings:GetCat(var)
	return self.db:get({"categories"}, var)
end
function myBindings:SetCat(var, val)
	self.db:set({"categories"}, var, val)
end

--

function myBindings:Enable()
	-- Override the existing key bindings dialog so that myBindingsOptionsFrame will
	-- get called just like any other UIPanel frame.
	KeyBindingFrame = myBindingsOptionsFrame
	GameMenuButtonKeybindings:Hide()
	myBindingsGameMenuButton:Show()

	self:RegisterEvent("ACE_PROFILE_LOADED")

	self:SetGameBindings()
	self:ParseBindings()
	self:LoadBindings(GetCurrentBindingSet())
	self:UpdateLoadedLabel()

	UIPanelWindows[self.optionsFrame] = {area = "center", pushable = 0}
	self.frame.selected   = nil
end

function myBindings:Disable()
	KeyBindingFrame = self.savedKeyBindingFrame
	GameMenuButtonKeybindings:Show()
	myBindingsGameMenuButton:Hide()
end

function myBindings:ACE_PROFILE_LOADED()
	if( self.profilePath[2] == self.currentProfile ) then return end
	self.currentProfile = self.profilePath[2]
	self:LoadBindings(GetCurrentBindingSet())
	self:UpdateLoadedLabel()
end


--[[--------------------------------------------------------------------------
  Initialize Bindings List
-----------------------------------------------------------------------------]]

function myBindings:SetGameBindings()
	-- This is just a reference list to check later which bindings are part of the
	-- standard game controls.
	self.gameBindings[BINDING_HEADER_ACTIONBAR]		 = 1
	self.gameBindings[BINDING_HEADER_CAMERA]		 = 1
	self.gameBindings[BINDING_HEADER_CHAT]			 = 1
	self.gameBindings[BINDING_HEADER_INTERFACE]		 = 1
	self.gameBindings[BINDING_HEADER_MISC]			 = 1
	self.gameBindings[BINDING_HEADER_MOVEMENT]		 = 1
	self.gameBindings[BINDING_HEADER_TARGETING]		 = 1
	self.gameBindings[BINDING_HEADER_MULTIACTIONBAR] = 1
	self.gameBindings[BINDING_HEADER_BLANK]			 = 1
	self.gameBindings[BINDING_HEADER_BLANK2]		 = 1
	self.gameBindings[BINDING_HEADER_BLANK3]		 = 1
end

function myBindings:ParseBindings()
	local categories  = {}
	local commandName, binding1, binding2, header, addOnCat

	self.menuHeaders		= {}
	self.bindingIndexes		= {}
	self.expandedCategories	= {}

	for index = 1, GetNumBindings(), 1 do
		commandName, binding1, binding2 = GetBinding(index)

		if( strsub(commandName, 1, 6) == "HEADER" ) then
			header = getglobal("BINDING_"..commandName)
			if( (header or "") == "" ) then header = strsub(commandName, 8) end

			self.bindingIndexes[header] = {}

			-- Add to appropriate category
			if( self.gameBindings[header] ) then
				if( not categories[MYBINDINGS_CATEGORY_GAME] ) then
					categories[MYBINDINGS_CATEGORY_GAME] = {}
				end
				table.insert(categories[MYBINDINGS_CATEGORY_GAME], header)
			else
				addOnCat = getglobal(
					"ACE_CATEGORY_"..
					strupper(
						self:GetCat(strsub(commandName, 8)) or
						getglobal("BINDING_CATEGORY_"..strsub(commandName, 8)) or
						"others"
					)
				) or ACE_CATEGORY_OTHERS
				if( not categories[addOnCat] ) then categories[addOnCat] = {} end
				table.insert(categories[addOnCat], header)
			end
		elseif( header ) then
			-- Need to save the index so it can be used later to reference this command
			-- in the API's bindings list.
			table.insert(self.bindingIndexes[header], index)
		end
	end

	-- Now place all the sorted categories and headers into one list for easy
	-- display later on.
	for index, category in self.categoriesSort do
		if( categories[category] ) then
			table.sort(categories[category])
			table.insert(self.menuHeaders, {text=category, isCategory=TRUE})
			for i, header in categories[category] do
				table.insert(self.menuHeaders, {text=header, category=category})
			end
		end
	end
end


--[[--------------------------------------------------------------------------
  Dialog Handling Methods
-----------------------------------------------------------------------------]]

function myBindings:HeadingsUpdate()
	local numHeaders = table.getn(self.menuHeaders)
	local offset	 = FauxScrollFrame_GetOffset(myBindingsOptionsHeadingsScrollFrame)
	local hdrinx	 = 0
	local visible	 = 0
	local line		 = 0
	local header, menuItem, button

	-- In case we were waiting for a key bind confirmation, cancel it.
	self:CancelKeyBind()

	-- Browse the lines
	while ( line < self.maxMenuLines ) do
		if( ((offset + line) <= numHeaders) and (hdrinx < numHeaders) ) then
			hdrinx	= hdrinx + 1
			header = self.menuHeaders[hdrinx]

			if( header.isCategory ) then
				visible = visible + 1
				if( visible > offset ) then
					line = line + 1
					getglobal("myBindingsOptionsBindCategory"..line.."NormalText"):SetText(header.text)
--					getglobal("myBindingsOptionsBindCategory"..line.."HighlightText"):SetText(header.text)
					getglobal("myBindingsOptionsBindCategory"..line):Show()
					getglobal("myBindingsOptionsBindHeader"..line):Hide()
				end
			elseif( self.expandedCategories[header.category] ) then
				visible = visible + 1
				if( visible > offset ) then
					line	   = line + 1
					menuItem   = getglobal("myBindingsOptionsBindHeader"..line)
					button	   = getglobal("myBindingsOptionsBindHeader"..line.."Button")

					getglobal("myBindingsOptionsBindHeader"..line.."ButtonNormalText"):SetText(header.text)
--					getglobal("myBindingsOptionsBindHeader"..line.."ButtonHighlightText"):SetText(header.text)
					getglobal("myBindingsOptionsBindCategory"..line):Hide()
					menuItem:Show()

					if( self.currentMenuSelection == header.text ) then
						myBindingsOptionsFrameBindingsTitle:SetText(header.text)
						menuItem:SetBackdropBorderColor(.9, .9, 0)
						menuItem:SetBackdropColor(1.0, 1.0, 0.5)
						button:LockHighlight()
					else
						menuItem:SetBackdropBorderColor(0.4, 0.4, 0.4)
						menuItem:SetBackdropColor(0.15, 0.15, 0.15)
						button:UnlockHighlight()
					end

					self.frame.highlightID = self.frame:GetParent():GetID()
				end
			end
		else
			line = line + 1
			getglobal("myBindingsOptionsBindCategory"..line):Hide()
			getglobal("myBindingsOptionsBindHeader"..line):Hide()
		end
	end

	FauxScrollFrame_Update(myBindingsOptionsHeadingsScrollFrame,
						   self:GetMenuNumVisible(),
						   self.maxMenuLines,
						   self.maxMenuLineHeight
						   )
end

function myBindings:ExpandCollapseHeadings(val)
	for index, header in self.menuHeaders do
		if( header.isCategory ) then
			self.expandedCategories[header.text] = val
		end
	end
end

function myBindings:GetMenuNumVisible()
	local numVisible = 0

	for index = 1, table.getn(self.menuHeaders), 1 do
		if( self.menuHeaders[index].isCategory ) then
			numVisible = numVisible + 1
		elseif( self.expandedCategories[self.menuHeaders[index].category] ) then
			numVisible = numVisible + 1
		end
	end

	return numVisible
end

function myBindings:CategoryOnClick(text)
	self.expandedCategories[text] = (not self.expandedCategories[text])
	self:HeadingsUpdate()
end

function myBindings:HeaderOnClick()
	self.currentMenuSelection = this:GetText()
	self:HeadingsUpdate()
	self:BindingsUpdate()
end


--[[--------------------------------------------------------------------------
  Bindings ScrollFrame Methods
-----------------------------------------------------------------------------]]

-- Copied from Blizzard's UI as a temporary fix for game patch 1800. Since the
-- default key binding frame is no longer loaded at start, this function is
-- not available if the default key bind frame is never opened, which it probably
-- never is if someone is using myBindings. 10/11/2005
function KeyBindingFrame_GetLocalizedName(name, prefix)
	if ( not name ) then
		return "";
	end
	local tempName = name;
	local i = strfind(name, "-");
	local dashIndex = nil;
	while ( i ) do
		if ( not dashIndex ) then
			dashIndex = i;
		else
			dashIndex = dashIndex + i;
		end
		tempName = strsub(tempName, i + 1);
		i = strfind(tempName, "-");
	end

	local modKeys = '';
	if ( not dashIndex ) then
		dashIndex = 0;
	else
		modKeys = strsub(name, 1, dashIndex);
		if ( GetLocale() == "deDE") then
			modKeys = gsub(modKeys, "CTRL", "STRG");
		end
	end

	local variablePrefix = prefix;
	if ( not variablePrefix ) then
		variablePrefix = "";
	end
	local localizedName = nil;
	if ( IsMacClient() ) then
		-- see if there is a mac specific name for the key
		localizedName = getglobal(variablePrefix..tempName.."_MAC");
	end
	if ( not localizedName ) then
		localizedName = getglobal(variablePrefix..tempName);
	end
	if ( not localizedName ) then
		localizedName = tempName;
	end
	return modKeys..localizedName;
end

function myBindings:BindingsUpdate()
	local header		= self.currentMenuSelection
	local indexes		= self.bindingIndexes[header]
	local scrollOffset	= FauxScrollFrame_GetOffset(myBindingsOptionsBindingsScrollFrame)
	local bindLine, commandName, numCommands, keyOffset
	local keyBindingButton1, keyBindingButton1NormalTexture, keyBindingButton1PushedTexture,
		  keyBindingButton2, keyBindingButton2NormalTexture, keyBindingButton2PushedTexture,
		  keyBindingDescription

	-- In case we were waiting for a key bind confirmation, cancel it.
	if( not myBindingsOptionsBindingsScrollFrame.buttonPressed ) then
		self:CancelKeyBind()
	end

	if( indexes ) then
		numCommands = table.getn(indexes)
	else
		numCommands = 0
	end

	-- Browse the lines
	for line = 1, self.maxBindingLines, 1 do
		keyOffset		  = scrollOffset + line
		keyBindingButton1 = getglobal("myBindingsOptionsBindingLine"..line.."Key1Button")
		keyBindingButton2 = getglobal("myBindingsOptionsBindingLine"..line.."Key2Button")

		if( keyOffset <= numCommands ) then
			bindLine	= getglobal("myBindingsOptionsBindingLine"..line)
			commandName, binding1, binding2 = GetBinding(self.bindingIndexes[header][keyOffset])

			keyBindingButton1NormalTexture = getglobal("myBindingsOptionsBindingLine"..line.."Key1ButtonNormalTexture")
			keyBindingButton1PushedTexture = getglobal("myBindingsOptionsBindingLine"..line.."Key1ButtonPushedTexture")
			keyBindingButton2NormalTexture = getglobal("myBindingsOptionsBindingLine"..line.."Key2ButtonNormalTexture")
			keyBindingButton2PushedTexture = getglobal("myBindingsOptionsBindingLine"..line.."Key2ButtonPushedTexture")
			keyBindingLabel				   = getglobal("myBindingsOptionsBindingLine"..line.."Label")

			keyBindingLabel:SetText(KeyBindingFrame_GetLocalizedName(commandName, "BINDING_NAME_"))

			if( binding1 ) then
				keyBindingButton1:SetText(
								KeyBindingFrame_GetLocalizedName(binding1, "KEY_")
								)
				keyBindingButton1:SetAlpha(1)
			else
				keyBindingButton1:SetText(NORMAL_FONT_COLOR_CODE..NOT_BOUND..FONT_COLOR_CODE_CLOSE)
				keyBindingButton1:SetAlpha(0.8)
			end

			if( binding2 ) then
				keyBindingButton2:SetText(
								KeyBindingFrame_GetLocalizedName(binding2, "KEY_")
								)
				keyBindingButton2:SetAlpha(1)
			else
				keyBindingButton2:SetText(NORMAL_FONT_COLOR_CODE..NOT_BOUND..FONT_COLOR_CODE_CLOSE)
				keyBindingButton2:SetAlpha(0.8)
			end

			if( myBindingsOptionsBindingsScrollFrame.selected == commandName ) then
				if( myBindingsOptionsBindingsScrollFrame.keyID == 1 ) then
					keyBindingButton1:LockHighlight()
					keyBindingButton2:UnlockHighlight()
				else
					keyBindingButton2:LockHighlight()
					keyBindingButton1:UnlockHighlight()
				end
			else
				keyBindingButton1:UnlockHighlight()
				keyBindingButton2:UnlockHighlight()
			end

			keyBindingButton1.commandName = commandName
			keyBindingButton2.commandName = commandName

			bindLine:Show()
		else
			keyBindingButton1.commandName = nil
			keyBindingButton2.commandName = nil
			getglobal("myBindingsOptionsBindingLine"..line):Hide()
		end
	end

	FauxScrollFrame_Update(myBindingsOptionsBindingsScrollFrame,
						   numCommands,
						   self.maxBindingLines,
						   self.maxBindingLineHeight
						   )
end

function myBindings:DeselectButton()
	myBindingsOptionsFrameOutputText:SetText("")
	myBindingsOptionsBindingsScrollFrame.selected	   = nil
	myBindingsOptionsBindingsScrollFrame.buttonPressed = nil
	myBindingsOptionsBindingsScrollFrame.keyID		   = nil
	self:BindingsUpdate()
end

function myBindings:BindingOnClick(button)
	if( myBindingsOptionsBindingsScrollFrame.buttonPressed == this ) then
		-- Code to be able to deselect or select another key to bind
		if( button == "LeftButton" or button == "RightButton" ) then
			-- Deselect button if it was the pressed previously pressed
			self:DeselectButton()
		else
			self:OnKeyDown(button)
		end
	else
		myBindingsOptionsFrameUnbindButton:Enable()
		myBindingsOptionsBindingsScrollFrame.selected	   = this.commandName
		myBindingsOptionsBindingsScrollFrame.buttonPressed = this
		myBindingsOptionsBindingsScrollFrame.keyID		   = this:GetID()
		myBindingsOptionsFrameOutputText:SetText(
			format(BIND_KEY_TO_COMMAND,
				   KeyBindingFrame_GetLocalizedName(this.commandName, "BINDING_NAME_")
				   )
			)
		self:BindingsUpdate()
	end
end

function myBindings:OnKeyDown(button)
	if( arg1 == "PRINTSCREEN" ) then
		Screenshot()
		return
	end

	-- Convert the mouse button names
	if( button == "LeftButton" ) then
		button = "BUTTON1"
	elseif( button == "RightButton" ) then
		button = "BUTTON2"
	elseif( button == "MiddleButton" ) then
		button = "BUTTON3"
	elseif( button == "Button4" ) then
		button = "BUTTON4"
	elseif( button == "Button5" ) then
		button = "BUTTON5"
	end

	if( myBindingsOptionsBindingsScrollFrame.selected ) then
		local keyPressed = arg1

		if( button ) then
			if( button == "BUTTON1" or button == "BUTTON2" ) then
				return
			end
			keyPressed = button
		else
			keyPressed = arg1
		end

		if( keyPressed == "UNKNOWN" ) then
			return
		end
		if( keyPressed == "SHIFT" or keyPressed == "CTRL" or keyPressed == "ALT") then
			return
		end
		if( IsShiftKeyDown() ) then
			keyPressed = "SHIFT-"..keyPressed
		end
		if( IsControlKeyDown() ) then
			keyPressed = "CTRL-"..keyPressed
		end
		if( IsAltKeyDown() ) then
			keyPressed = "ALT-"..keyPressed
		end

		local oldAction = GetBindingAction(keyPressed)
		if( (oldAction ~= "") and (oldAction ~= myBindingsOptionsBindingsScrollFrame.selected) ) then
			local key1, key2 = GetBindingKey(oldAction)
			if( (not key1 or key1 == keyPressed) and ((not key2) or (key2 == keyPressed)) ) then
				--Error message
				myBindingsOptionsFrameOutputText:SetText(
					format(MYBINDINGS_BOUND_ERROR,
						   keyPressed,
						   KeyBindingFrame_GetLocalizedName(oldAction, "BINDING_NAME_")
						   )
					)
				self.confirmKeyBind = TRUE
			end
		end

		if( self.confirmKeyBind ) then
			myBindingsOptionsFrameConfirmBindButton:Show()
			myBindingsOptionsFrameConfirmBindButton.keyPressed = keyPressed
			myBindingsOptionsFrameCancelBindButton:Show()
		else
			self:BindKey(keyPressed)
		end
	else
		if( arg1 == "ESCAPE" ) then
			LoadBindings(GetCurrentBindingSet())
			myBindingsOptionsFrameOutputText:SetText("")
			myBindingsOptionsBindingsScrollFrame.selected = nil
			HideUIPanel(this)
		end
	end
end

function myBindings:BindKey(keyPressed)
	local key1, key2 = GetBindingKey(myBindingsOptionsBindingsScrollFrame.selected)

	if( key1 ) then SetBinding(key1); end
	if( key2 ) then SetBinding(key2); end

	if( myBindingsOptionsBindingsScrollFrame.keyID == 1 ) then
		self:SetBinding(keyPressed, myBindingsOptionsBindingsScrollFrame.selected, key1)
		if( key2 ) then
			SetBinding(key2, myBindingsOptionsBindingsScrollFrame.selected)
		end
	else
		if( key1 ) then
			self:SetBinding(key1, myBindingsOptionsBindingsScrollFrame.selected)
		end
		self:SetBinding(keyPressed, myBindingsOptionsBindingsScrollFrame.selected, key2)
	end

	myBindingsOptionsBindingsScrollFrame.selected	   = nil
	myBindingsOptionsBindingsScrollFrame.buttonPressed = nil
	self:BindingsUpdate()
	myBindingsOptionsFrameOutputText:SetText(KEY_BOUND)
end

function myBindings:SetBinding(key, selectedBinding, oldKey)
	if( SetBinding(key, selectedBinding) ) then
		return
	else
		if( oldKey ) then
			SetBinding(oldKey, selectedBinding)
		end
		--Error message
		myBindingsOptionsFrameOutputText:SetText(
			"Can't bind mousewheel to actions with up and down states"
			)
	end
end

function myBindings:ConfirmKeyBind()
	self:BindKey(this.keyPressed)
end

function myBindings:CancelKeyBind()
	self.confirmKeyBind = FALSE

	-- Button highlighting stuff
	myBindingsOptionsBindingsScrollFrame.selected = nil
	if( myBindingsOptionsBindingsScrollFrame.buttonPressed ) then
		myBindingsOptionsBindingsScrollFrame.buttonPressed:UnlockHighlight()
		myBindingsOptionsBindingsScrollFrame.buttonPressed = nil
	end

	myBindingsOptionsFrameConfirmBindButton:Hide()
	myBindingsOptionsFrameConfirmBindButton.keyPressed = nil
	myBindingsOptionsFrameCancelBindButton:Hide()
	myBindingsOptionsFrameUnbindButton:Disable()
	myBindingsOptionsFrameOutputText:SetText("")
end

function myBindings:UnbindKey()
	if( not myBindingsOptionsBindingsScrollFrame.selected ) then return end

	local key1, key2 = GetBindingKey(myBindingsOptionsBindingsScrollFrame.selected)

	if( myBindingsOptionsBindingsScrollFrame.keyID == 1 ) then
		if( key1 ) then SetBinding(key1) end
		if( key2 ) then
			SetBinding(key2, myBindingsOptionsBindingsScrollFrame.selected)
		end
	elseif( key2 ) then SetBinding(key2)
	end

	self:CancelKeyBind()
	self:BindingsUpdate()
end


--[[--------------------------------------------------------------------------
  Binding Methods
-----------------------------------------------------------------------------]]

function myBindings:LoadGameDefaultBindings()
	LoadBindings(DEFAULT_BINDINGS)
	self:BindingsUpdate()
end

function myBindings:LoadBindings()
	-- If there's no binding set in the current profile, don't do anything or this
	-- will wipe out all settings, leaving mouse-control of the game only.
	if( not self:GetBind() ) then return end

	local commandName, binding1, binding2, command

	for index = 1, GetNumBindings(), 1 do
		commandName, binding1, binding2 = GetBinding(index)

		-- I don't know why, but if the bindings aren't first erased, then attempting
		-- to overwrite the values from the stored values will wipe out all the second
		-- key bindings. They need clearing anyway in case the stored binding set
		-- doesn't have values, meaning these bindings should be empty.
		if( binding1 ) then SetBinding(binding1) end
		if( binding2 ) then SetBinding(binding2) end

		command = self:GetBind(commandName)
		if( command ) then
			if( command.bind1 ) then SetBinding(command.bind1, commandName, binding1) end
			if( command.bind2 ) then SetBinding(command.bind2, commandName, binding2) end
		end
	end

	SaveBindings(GetCurrentBindingSet())
	self:BindingsUpdate()
end

function myBindings:SaveBindings()
	-- Save the bindings in the system first.
	SaveBindings(GetCurrentBindingSet())

	local commandName, binding1, binding2

	-- Empty the stored bindings first.
	self:ClearBinds()

	for index = 1, GetNumBindings(), 1 do
		commandName, binding1, binding2 = GetBinding(index)
		local key1, key2 = GetBindingKey(commandName)
		-- Don't save empty bindings
		if( binding1 or binding2 ) then
			self:SetBind(commandName, {bind1 = binding1, bind2 = binding2})
		end
	end

	self:CloseInterface()
end


--[[--------------------------------------------------------------------------
  Display Methods
-----------------------------------------------------------------------------]]

function myBindings:UpdateLoadedLabel()
	myBindingsOptionsFrameBindingsLoadedLabel:SetText(
		format(MYBINDINGS_LABEL_BINDINGS_LOADED, self.profilePath[2])
	)
end

function myBindings:OpenInterface()
	if( self.disabled ) then return; end

	if( not self.frame:IsVisible() ) then
		ShowUIPanel(self.frame)
		self.dontOpenGameMenu = TRUE
		self:HeadingsUpdate()
		self:BindingsUpdate()
	end
end

function myBindings:CloseInterface()
	myBindingsOptionsBindingsScrollFrame.selected = nil
	HideUIPanel(self.frame)
end

function myBindings:OnShow()
	self:HeadingsUpdate()
	self:BindingsUpdate()
end

function myBindings:OnHide()
	self:CancelKeyBind()

	-- Check if it's currently showing an options frame or the myAddOns options frame.
	if( (not MYADDONS_ACTIVE_OPTIONSFRAME) and
		 (not self.dontOpenGameMenu) and
		 ( (not myAddOnsFrame) or (not myAddOnsFrame:IsVisible())) ) then
		ShowUIPanel(GameMenuFrame)
				-- Check if the options frame was opened by myAddOns
	elseif( MYADDONS_ACTIVE_OPTIONSFRAME == this ) then
		ShowUIPanel(myAddOnsFrame)
	end

	self.dontOpenGameMenu = FALSE
end

--[[--------------------------------------------------------------------------
  Chat Handlers
-----------------------------------------------------------------------------]]

function myBindings:SetCategory(opt)
	local header, cat = unpack(ace.ParseWords(opt))

	if( (not header) or (not cat) ) then
		self.Error(MYBINDINGS_TEXT_INVALID_ENTRY)
		return
	elseif( not getglobal("ACE_CATEGORY_"..strupper(cat)) ) then
		self.Error(MYBINDINGS_TEXT_CAT_INVALID, cat)
		return
	end

	local try, valid = getglobal("BINDING_HEADER_"..header)
	if( try ) then
		valid = header
	else
		try = getglobal("BINDING_HEADER_"..strlower(header))
		if( try ) then
			valid = strlower(header)
		else
			try = getglobal("BINDING_HEADER_"..strupper(header))
			if( try ) then
				valid = strupper(header)
			else
				self.Error(MYBINDINGS_TEXT_HDR_INVALID, header)
				return
			end
		end
	end

	self:SetCat(valid, cat)
	self:ParseBindings()
	self.Msg(MYBINDINGS_TEXT_CAT_SET, valid, getglobal("ACE_CATEGORY_"..strupper(cat)))
end

function myBindings:SetBindOpt(opt)
	local oldaction = nil
	local key, action = unpack(ace.ParseWords(opt))
	key = string.upper(key)
	-- Attempt to clear the binding. If this is an invalid key, it'll fail.
	oldaction = GetBindingAction( key )
	if not SetBinding(key, nil) then
		if not SetBinding(key, oldaction) then
			self.cmd:msg( "Error - " .. key .. " is not a valid key!" )
		end
	elseif action then
		if SetBinding(key, action) then
			self.cmd:msg( "Key " .. key .. " successfully bound to action " .. action .. ".")
		else
			self.cmd:msg( "Action " .. action .. " is not valid!" )
			SetBinding(key, oldaction)
		end
	else
		self.cmd:msg( "Key " .. key .. " cleared." )
	end
end
