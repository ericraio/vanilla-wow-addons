-- Global Stuff
local InspectorMode = "Character";
local RotationMode = "None";
local ModelRotation = 0;
local RotationAmount = 0.2;
local FrameRateRotationModifier = 10/3;

local WaitingForHonor = 0;
local InHonorRange = 0;
local timePassed = 0;
local timeUpdateOK = 1;
local timePassedTotal = 0;
local honorRequestTimeout = 3;
local honorRequested = 0;

local mouseIsOverButton = 0;
local keyTimer = 0;
local keyTimerMax = 20;
local version = "Inspector v0.9";


-- Binding info
BINDING_HEADER_INSPECTOR = "Inspector";
BINDING_NAME_INSPECTOR_BINDING = "Inspect Target";


-- Slash Commands
SLASH_INSPECTOR1 = "/in";
SLASH_INSPECTOR_HELP1 = "/inspector";
SlashCmdList["INSPECTOR"] = InspectorCommand;
SlashCmdList["INSPECTOR_HELP"] = InspectorHelp;


-- Holds all types of info on the slots
local InventorySlots = {
	{ name="InspectorHeadButton",		slot="HeadSlot",	 item=nil, defaultTexture="Head",	displayName="Head" },
	{ name="InspectorNeckButton",		slot="NeckSlot",	 item=nil, defaultTexture="Neck",	displayName="Neck" },
	{ name="InspectorShoulderButton",	slot="ShoulderSlot",	 item=nil, defaultTexture="Shoulder",	displayName="Shoulder" },
	{ name="InspectorShirtButton",		slot="ShirtSlot",	 item=nil, defaultTexture="Shirt",	displayName="Shirt" },
	{ name="InspectorChestButton",		slot="ChestSlot",	 item=nil, defaultTexture="Chest",	displayName="Chest" },
	{ name="InspectorWaistButton",		slot="WaistSlot",	 item=nil, defaultTexture="Waist",	displayName="Waist" },
	{ name="InspectorLegsButton",		slot="LegsSlot",	 item=nil, defaultTexture="Legs",	displayName="Legs" },
	{ name="InspectorFeetButton",		slot="FeetSlot",	 item=nil, defaultTexture="Feet",	displayName="Feet" },
	{ name="InspectorWristButton",		slot="WristSlot",	 item=nil, defaultTexture="Wrists",	displayName="Wrists" },
	{ name="InspectorHandsButton",		slot="HandsSlot",	 item=nil, defaultTexture="Hands",	displayName="Hands" },
	{ name="InspectorFinger1Button",	slot="Finger0Slot",	 item=nil, defaultTexture="Finger",	displayName="Finger" },
	{ name="InspectorFinger2Button",	slot="Finger1Slot",	 item=nil, defaultTexture="Finger",	displayName="Finger" },
	{ name="InspectorTrinket1Button",	slot="Trinket0Slot",	 item=nil, defaultTexture="Trinket",	displayName="Trinket" },
	{ name="InspectorTrinket2Button",	slot="Trinket1Slot",	 item=nil, defaultTexture="Trinket",	displayName="Trinket" },
	{ name="InspectorBackButton",		slot="BackSlot",	 item=nil, defaultTexture="Chest",	displayName="Back" },
	{ name="InspectorMainHandButton",	slot="MainHandSlot",	 item=nil, defaultTexture="MainHand",	displayName="Main Hand" },
	{ name="InspectorSecondaryHandButton",	slot="SecondaryHandSlot",item=nil, defaultTexture="SecondaryHand", displayName="Off Hand" },
	{ name="InspectorRangedButton",		slot="RangedSlot",	 item=nil, defaultTexture="Ranged",	displayName="Ranged" },
	{ name="InspectorTabardButton",		slot="TabardSlot",	 item=nil, defaultTexture="Tabard",	displayName="Tabard" }
};




------------ InspectorFrame_OnLoad -------------
-- What to do when the frame is loaded
------------------------------------------------
function InspectorFrame_OnLoad()
	-- Make the frame pushable by other frames
	UIPanelWindows["InspectorFrame"] = { area = "left", pushable = 5 };
	chatMessage( version.." Loaded!", 0.2, 0.6, 1.0 );
	chatMessage( "Type /inspector for info",  0.2, 0.6, 1.0 );

	-- Hide the honor stuff
	InspectorHideHonor();
end



------------ InspectorFrameShow -------------
-- Show the frame and play a sound
---------------------------------------------
function InspectorFrameShow()
	PlaySound("igCharacterInfoOpen");
	ShowUIPanel(InspectorFrame);
end



------------ InspectorFrameHide -------------
-- Hide the frame and play a sound
---------------------------------------------
function InspectorFrameHide()
	PlaySound("igCharacterInfoClose");
	HideUIPanel(InspectorFrame);
end



------------ InspectorHideHonor ------------
-- Hide all the honor stuff
--------------------------------------------
function InspectorHideHonor()
	InspectorMode = "Character";
	InspectorSwitchMode:SetText("Show Honor");
	InspectorPlayerPVPTodayText:Hide();
	InspectorPlayerPVPTodayHKText:Hide();
	InspectorPlayerPVPTodayHK:Hide();
	InspectorPlayerPVPTodayDKText:Hide();
	InspectorPlayerPVPTodayDK:Hide();
	InspectorPlayerPVPYesterdayText:Hide();
	InspectorPlayerPVPYesterdayHKText:Hide();
	InspectorPlayerPVPYesterdayHK:Hide();
	InspectorPlayerPVPYesterdayHonorText:Hide();
	InspectorPlayerPVPYesterdayHonor:Hide();
	InspectorPlayerPVPThisWeekText:Hide();
	InspectorPlayerPVPThisWeekHKText:Hide();
	InspectorPlayerPVPThisWeekHK:Hide();
	InspectorPlayerPVPThisWeekHonorText:Hide();
	InspectorPlayerPVPThisWeekHonor:Hide();
	InspectorPlayerPVPLastWeekText:Hide();
	InspectorPlayerPVPLastWeekHKText:Hide();
	InspectorPlayerPVPLastWeekHK:Hide();
	InspectorPlayerPVPLastWeekHonorText:Hide();
	InspectorPlayerPVPLastWeekHonor:Hide();
	InspectorPlayerPVPLastWeekStandingText:Hide();
	InspectorPlayerPVPLastWeekStanding:Hide();
	InspectorPlayerPVPLifetimeText:Hide();
	InspectorPlayerPVPLifetimeHKText:Hide();
	InspectorPlayerPVPLifetimeHK:Hide();
	InspectorPlayerPVPLifetimeDKText:Hide();
	InspectorPlayerPVPLifetimeDK:Hide();
	InspectorPlayerPVPLifetimeRankText:Hide();
	InspectorPlayerPVPLifetimeRank:Hide();
	InspectorPlayerPVPRangeText:Hide();
end



------------ InspectorShowHonor ------------
-- Hide all the honor stuff
--------------------------------------------
function InspectorShowHonor()
	InspectorMode = "Honor";
	InspectorSwitchMode:SetText("Show Model");
	InspectorPlayerPVPTodayText:Show();
	InspectorPlayerPVPTodayHKText:Show();
	InspectorPlayerPVPTodayHK:Show();
	InspectorPlayerPVPTodayDKText:Show();
	InspectorPlayerPVPTodayDK:Show();
	InspectorPlayerPVPYesterdayText:Show();
	InspectorPlayerPVPYesterdayHKText:Show();
	InspectorPlayerPVPYesterdayHK:Show();
	InspectorPlayerPVPYesterdayHonorText:Show();
	InspectorPlayerPVPYesterdayHonor:Show();
	InspectorPlayerPVPThisWeekText:Show();
	InspectorPlayerPVPThisWeekHKText:Show();
	InspectorPlayerPVPThisWeekHK:Show();
	InspectorPlayerPVPThisWeekHonorText:Show();
	InspectorPlayerPVPThisWeekHonor:Show();
	InspectorPlayerPVPLastWeekText:Show();
	InspectorPlayerPVPLastWeekHKText:Show();
	InspectorPlayerPVPLastWeekHK:Show();
	InspectorPlayerPVPLastWeekHonorText:Show();
	InspectorPlayerPVPLastWeekHonor:Show();
	InspectorPlayerPVPLastWeekStandingText:Show();
	InspectorPlayerPVPLastWeekStanding:Show();
	InspectorPlayerPVPLifetimeText:Show();
	InspectorPlayerPVPLifetimeHKText:Show();
	InspectorPlayerPVPLifetimeHK:Show();
	InspectorPlayerPVPLifetimeDKText:Show();
	InspectorPlayerPVPLifetimeDK:Show();
	InspectorPlayerPVPLifetimeRankText:Show();
	InspectorPlayerPVPLifetimeRank:Show();
	InspectorPlayerPVPRangeText:Show();
end



------------ InspectorShowModel -------------
-- Show the character's model
---------------------------------------------
function InspectorShowModel()
	InspectorPlayerModel:Show();
	InspectorModelRotationButtonRight:Show();
	InspectorModelRotationButtonLeft:Show();
end


------------ InspectorHideModel -------------
-- Hide the character's model
---------------------------------------------
function InspectorHideModel()
	InspectorPlayerModel:Hide();
	InspectorModelRotationButtonRight:Hide();
	InspectorModelRotationButtonLeft:Hide();
end


------------ GetInspectorMode ------------
-- Returns the current mode
------------------------------------------
function GetInspectorMode()
	return InspectorMode;
end



------------- GetModelRotation ------------
-- Get the model's rotation
-------------------------------------------
function GetModelRotation()
	return ModelRotation;
end



------------- SetRotationMode -------------
-- Sets the rotation mode for the model
-- Values: None, Left, Right
-------------------------------------------
function SetRotationMode( newMode )
	RotationMode = newMode;
end


------------- SetModelRotation ------------
-- Set the model's rotation
-------------------------------------------
function SetModelRotation( newRot )
	ModelRotation = newRot;

	-- Check for valid rotations (between zero and 2pi)
	if( ModelRotation > (math.pi * 2) ) then
		ModelRotation = ModelRotation - (math.pi * 2);
	elseif( ModelRotation < 0.0 ) then
		ModelRotation = ModelRotation + (math.pi * 2);
	end

	InspectorPlayerModel:SetRotation( ModelRotation );
end



------------- IncrementModelRotation -------------
-- Increases the model's rotation value
--------------------------------------------------
function IncrementModelRotation()
	SetModelRotation( GetModelRotation() + RotationAmount );
end



------------- DecrementModelRotation ----------------
-- Decreases the model's rotation value
-----------------------------------------------------
function DecrementModelRotation()
	SetModelRotation( GetModelRotation() - RotationAmount );
end




------------ InspectorCheckRotation --------------
-- I was gonna do a "timer", but it looks much
-- better if you rotate every frame.  So, just
-- check the mode and Do It Go!
--------------------------------------------------
function InspectorCheckRotation()

	-- Are we rotating?  
	if( RotationMode == "Left" ) then
		-- Update the rotation speed
		RotationAmount = ( 1/GetFramerate() ) * FrameRateRotationModifier;
		DecrementModelRotation();
	elseif( RotationMode == "Right" ) then
		RotationAmount = ( 1/GetFramerate() ) * FrameRateRotationModifier;
		IncrementModelRotation();
	end

end



------------ InspectorCheckCursor -------------
-- Do we need to change the cursor (for the
-- dressing room stuff?)
-----------------------------------------------
function InspectorCheckCursor( checkType )
	if( checkType == "Key" ) then
		if( IsControlKeyDown() and mouseIsOverButton == 1 ) then
			ShowInspectCursor();
		else
			ResetCursor();
		end
	elseif (checkType == "Mouse" ) then
		mouseIsOverButton = 1;
		if( IsControlKeyDown() ) then
			ShowInspectCursor();
		else
			ResetCursor();
		end
	elseif ( checkType == "Off" ) then
		mouseIsOverButton = 0;
		ResetCursor();
	end

end


------------ KeyTimerUpdate --------------
-- I need this cause the OnKeyDown and
-- OnKeyUp events eat all my key presses
------------------------------------------
function KeyTimerUpdate()

	keyTimer = keyTimer + 1;

	-- Timer up?
	if ( keyTimer >= keyTimerMax ) then
		-- Yes!  Reset and return true
		keyTimer = 0;
		return 1;
	else
		-- No, return false
		return 0;
	end

end


----------- InspectorHelp ----------
-- Show some help on the mod
------------------------------------
function InspectorHelp()
	chatMessage(" ", 1.0, 1.0, 1.0);
	chatMessage(version,  0.2, 0.6, 1.0 );
	chatMessage("/inspector - Show this message", 1.0, 1.0, 1.0);
	chatMessage("/in - Inspect your current target", 1.0, 1.0, 1.0);
	chatMessage("/in <target's name> - Tries to inspect the target you specify (or the closest match)", 1.0, 1.0, 1.0);
	chatMessage("You can also bind a key ('i' for example) to inspect a target", 1.0, 1.0, 1.0);
	chatMessage(" ", 1.0, 1.0, 1.0);
end


-------------- InspectorCommand ---------------
-- Process a slash command
-----------------------------------------------
function InspectorCommand( msg )

	-- Check the contents of the slash command
	if( msg == "" or msg == " " ) then
		-- No target specified
		InspectorCheckInspect();
	else

		-- We (hopefully) have a target specified, try to target them
		TargetByName( msg );
		InspectorCheckInspect();

	end

end



------------- InspectorCheckInspect -------------
-- Check to see if we can inspect, and if we can
-- then lets do it
-------------------------------------------------
function InspectorCheckInspect()

	-- Check to see if our target is valid
	if( checkTarget() == 1 ) then
		if( not InspectorFrame:IsVisible() ) then

			-- GET the inspect info
			InspectorInspect();

			-- SHOW the frame
			InspectorFrameShow();

		else

			-- HIDE the frame
			InspectorFrameHide();

		end
	end

end



---------------- InspectorInspect --------------
-- Actually inspect the target.  Here we'll 
-- get most of the info, aside from honor
-- stuff.  That has to be requested from the
-- server once inside normal inspect range
------------------------------------------------
function InspectorInspect()

	-- Set the model
	InspectorPlayerModel:SetUnit("target");

	-- Reset the model's rotation
	SetModelRotation( 0 );

	-- Set the portrait texture
	SetPortraitTexture( InspectorPortraitTexture, "target" );

	-- Get the target's name and display it
	targetName = UnitName("target");
	InspectorPlayerNameText:SetText( targetName );

	-- Get the info about the target
	targetLevel = UnitLevel("target");
	targetRace = UnitRace("target");
	targetClass = UnitClass("target");
	InspectorPlayerInfoText:SetText( "Level "..targetLevel.." "..targetRace.." "..targetClass );

	-- Get guild info about the target
	targetGuild, targetGuildRank = GetGuildInfo("target");
	if( targetGuild and targetGuildRank ) then
		InspectorPlayerGuildText:SetText( targetGuildRank.." of "..targetGuild );
	else 
		InspectorPlayerGuildText:SetText( " " );
	end


	-- Get the target's PvP Rank info
	targetRankName, targetRank = GetPVPRankInfo( UnitPVPRank("target"), "target" );
	if( targetRank and targetRankName ) then
		-- Set the text
		InspectorPlayerPVPRankText:SetText( targetRankName.." (Rank "..targetRank..")" );
		
		-- Set the texture
		InspectorPlayerPVPRankTexture:SetTexture(format("%s%02d", "Interface\\PvPRankBadges\\PvPRank", targetRank));
	else
		InspectorPlayerPVPRankText:SetText( "No PvP Rank" );
		InspectorPlayerPVPRankTexture:SetTexture( "" );
	end

	-- This part gets tricky, you need to be within inspect range to
	--  get the target's honor info
	
	WaitingForHonor = 1;
	if( CheckInteractDistance("target",1) ) then
		NotifyInspect("target");	
		RequestInspectHonorData();
		InHonorRange = 1;
		InspectorPlayerPVPRangeText:SetText("Requesting Honor Stats...");
		InspectorPlayerPVPRangeText:SetTextColor(1.0, 0.82, 0.0);
	else
		InHonorRange = 0;
		InspectorPlayerPVPRangeText:SetText("Move Closer To See Honor Stats");
		InspectorPlayerPVPRangeText:SetTextColor(1.0, 0.0, 0.0);
	end


	-- Reset the honor info to default values
	InspectorPlayerPVPTodayHK:SetText( "??" );
	InspectorPlayerPVPTodayDK:SetText( "??" );

	InspectorPlayerPVPYesterdayHK:SetText( "??" );
	InspectorPlayerPVPYesterdayHonor:SetText( "??" );

	InspectorPlayerPVPThisWeekHK:SetText( "??" );
	InspectorPlayerPVPThisWeekHonor:SetText( "??" );

	InspectorPlayerPVPLastWeekHK:SetText( "??" );
	InspectorPlayerPVPLastWeekHonor:SetText( "??" );
	InspectorPlayerPVPLastWeekStanding:SetText( "??" );

	InspectorPlayerPVPLifetimeHK:SetText( "??" );
	InspectorPlayerPVPLifetimeDK:SetText( "??" );
	InspectorPlayerPVPLifetimeRank:SetText( "??" );



	-- Go through all of the slots
	for counter = 1, 19, 1 do

		tempTexture = GetInventoryItemTexture( "target", counter );
		tempItem = GetInventoryItemLink( "target", counter );

		-- See if the item exists
		if ( tempItem ) then
			-- If it does, switch the display

			getglobal(InventorySlots[counter].name):SetNormalTexture( tempTexture );
			getglobal(InventorySlots[counter].name):SetPushedTexture( tempTexture );

			-- Also, save the item info
			InventorySlots[counter].item = tempItem;

		else 
			-- No item, don't display
			-- Clear the saved item info
			InventorySlots[counter].item = nil;

			getglobal(InventorySlots[counter].name):SetNormalTexture( "Interface\\PaperDoll\\UI-PaperDoll-Slot-"..InventorySlots[counter].defaultTexture );
			getglobal(InventorySlots[counter].name):SetPushedTexture( "Interface\\PaperDoll\\UI-PaperDoll-Slot-"..InventorySlots[counter].defaultTexture );

		end

	end
	

end






----------- InspectorCheckHonorStatus -------------
-- This is called each "OnUpdate" to check the 
-- status of the honor (if it was requested)
---------------------------------------------------
function InspectorCheckHonorStatus( timeSinceLastUpdate )

	-- See how much time has passed
	--  We're only doing honor stuff once a second
	timePassed = timePassed + timeSinceLastUpdate;

	-- If we're waiting for honor, see how much "total time" has passed
	if( WaitingForHonor == 1 ) then
		timePassedTotal = timePassedTotal + timeSinceLastUpdate;
	else
		timePassedTotal = 0;
	end

	-- Ok, it's been at least a second, check the honor
	if( timePassed > timeUpdateOK ) then

		-- Are we waiting for an honor update?
		if( WaitingForHonor == 1 ) then

			-- Not in honor range yet, so keep checking
			if( CheckInteractDistance("target",1) ) then
				-- If we're in range and need to request, request the data
				if( honorRequested == 0 ) then
					NotifyInspect("target");
					RequestInspectHonorData();
					honorRequested = 1;
				end
				InHonorRange = 1;
				InspectorPlayerPVPRangeText:SetText("Requesting Honor Stats...");
				InspectorPlayerPVPRangeText:SetTextColor(1.0, 0.82, 0.0);
			else
				InHonorRange = 0;
				InspectorPlayerPVPRangeText:SetText("Move Closer To See Honor Stats");
				InspectorPlayerPVPRangeText:SetTextColor(1.0, 0.0, 0.0);
			end

			-- Are we within range yet?
			if( InHonorRange == 1 ) then
				
				-- Check to see if we've gotten the honor info yet
				if( HasInspectHonorData() ) then
					
					-- We have the honor info, so lets go!
					-- Get the target's overall PvP info
					todayHK, todayDK, yesterdayHK, yesterdayHonor, thisweekHK, thisweekHonor, lastweekHK, lastweekHonor, lastweekStanding, lifetimeHK, lifetimeDK, lifetimeRank = GetInspectHonorData();

					InspectorPlayerPVPTodayHK:SetText( todayHK );
					InspectorPlayerPVPTodayDK:SetText( todayDK );

					InspectorPlayerPVPYesterdayHK:SetText( yesterdayHK );
					InspectorPlayerPVPYesterdayHonor:SetText( yesterdayHonor );

					InspectorPlayerPVPThisWeekHK:SetText( thisweekHK );
					InspectorPlayerPVPThisWeekHonor:SetText( thisweekHonor );

					InspectorPlayerPVPLastWeekHK:SetText( lastweekHK );
					InspectorPlayerPVPLastWeekHonor:SetText( lastweekHonor );
					InspectorPlayerPVPLastWeekStanding:SetText( lastweekStanding );

					InspectorPlayerPVPLifetimeHK:SetText( lifetimeHK );
					InspectorPlayerPVPLifetimeDK:SetText( lifetimeDK );
					rankName, rankNumber = GetPVPRankInfo(lifetimeRank);
					if( rankName and rankNumber ) then
						InspectorPlayerPVPLifetimeRank:SetText( rankName.." ("..rankNumber..")" );
					else
						InspectorPlayerPVPLifetimeRank:SetText( "None" );
					end

					-- We don't need to get the honor data again,
					--  so set the waiting variable to 0 (false)
					WaitingForHonor = 0;
					honorRequested = 0;
					InspectorPlayerPVPRangeText:SetText("Honor Stats Loaded");
					InspectorPlayerPVPRangeText:SetTextColor(0.0, 1.0, 0.0);
	
				elseif( timePassedTotal > honorRequestTimeout ) then
					-- Ok, it's taken too long to get the honor,
					--  so lets try to request it again
					NotifyInspect("player");
					NotifyInspect("target");
					RequestInspectHonorData();
					honorRequested = 1;
					InspectorPlayerPVPRangeText:SetText("Re-Requesting Honor Stats...");
					InspectorPlayerPVPRangeText:SetTextColor(1.0, 0.82, 0.0);

					timePassedTotal = 0;

				end

			end
		end

		-- Set the time back to zero (restart the timer basically)
		timePassed = 0;
	end

end



------------- InspectorDisplayItemLink --------------
-- Display the tooltip if the item we're hovering over
-----------------------------------------------------
function InspectorDisplayItemLink()

	-- Get the slot
	whichSlot = this:GetID();

	-- Get the item
	tempLink = InventorySlots[whichSlot].item;

	-- If the item exists, show it
	if( tempLink ) then
		-- Parse the item
		_,_,itemToShow = string.find(InventorySlots[whichSlot].item, "^.*|H(.*)%[.*%].*$");

		-- Show it
		GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
 		GameTooltip:SetHyperlink(itemToShow);
	else
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		GameTooltip:SetText(InventorySlots[whichSlot].displayName);
	end

end


------------- InspectorChatLinkItem ---------------
-- We need to set up a way for the user to make a
-- chat link from our nifty buttons.  As long as
-- all the requirements are met, we're all good
---------------------------------------------------
function InspectorChatLinkItem( whichButton )
	
	-- Check to see if everything is correct (left button, holding shift while talking)
	if( whichButton == "LeftButton" and IsShiftKeyDown() and ChatFrameEditBox:IsVisible() ) then
		
		-- Slot and item
		whichSlot = this:GetID();
		tempLink = InventorySlots[whichSlot].item;

		-- Link has to exist
		if( tempLink ) then
			ChatFrameEditBox:Insert(tempLink);
		end

	elseif( whichButton == "LeftButton" and IsControlKeyDown() ) then
		
		-- Slot and item
		whichSlot = this:GetID();
		tempLink = InventorySlots[whichSlot].item;

		-- Link has to exist
		if( tempLink ) then
			DressUpItemLink(tempLink);
		end

	end

end



------------ checkEvents ------------
-- Watch for events, and do what needs
-- to be done when an event is received
-------------------------------------
function checkEvents( event )

	if( event == "PLAYER_TARGET_CHANGED" ) then
		-- Check to see if the frame and/or the button needs to be closed

		-- Frame check
		if( checkTarget() == 1 and InspectorFrame:IsVisible() ) then
			InspectorInspect();
		elseif( checkTarget() == 0 and UnitName("target")  and InspectorFrame:IsVisible() ) then
			InspectorFrameHide();
		end


		-- See if we need to hide the button
		if( checkTarget() == 1  ) then
			-- SHOW
			InspectorButtonFrame:Show();	
		else
			-- HIDE
			InspectorButtonFrame:Hide();
		end
	end
end



-------------- checkTarget -------------
-- See if the target is valid
--
-- A valid target is one that is a player
-- and is not ourself
----------------------------------------
function checkTarget()
	if ( UnitIsPlayer('target') and (not UnitIsUnit("target","player")) ) then
		return 1;
	else
		return 0;
	end
end



---------------- chatMessage ---------------
-- Sends a message to the default chat frame
--
-- red, green, blue - the amount of each color
-- to use (0.0 - 1.0)
--------------------------------------------
function chatMessage( message, red, green, blue )
	DEFAULT_CHAT_FRAME:AddMessage( message, red, green, blue );
end


---------------- frameMessage ---------------
-- Sends a message to the default chat frame
--
-- red, green, blue, alpha - the amount of each color
-- to use (0.0 - 1.0)
-- fadeTime - how long until fade out
---------------------------------------------
function frameMessage( message, red, green, blue, alpha, fadeTime )
	UIErrorsFrame:AddMessage( message, red, green, blue, alpha, fadeTime );
end


----------- trace -------------
-- A simplified version of the
-- frameMessage function for
-- quick testing
-------------------------------
function trace( message )
	UIErrorsFrame:AddMessage(message, 1.0, 0.0, 0.0, 1.0, 1.0 );
end

