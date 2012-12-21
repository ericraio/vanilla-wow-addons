function eCastingBarMirror_Show(timer, value, maxvalue, scale, paused, label)

	-- Pick a free dialog to use
	local dialog = nil;
	if ( not dialog ) then
		-- Find an open dialog of the requested type
		for index = 1, MIRRORTIMER_NUMTIMERS, 1 do
			local frame = getglobal("eCastingBarMirror"..index);
			if ( frame:IsVisible() and (frame.timer == timer) ) then
				dialog = frame;
				break;
			end
		end
	end
	if ( not dialog ) then
		-- Find a free dialog
		for index = 1, STATICPOPUP_NUMDIALOGS, 1 do
			local frame = getglobal("eCastingBarMirror"..index);
			if ( not frame:IsVisible() ) then
				dialog = frame;
				break;
			end
		end
	end
	if ( not dialog ) then
		return nil;
	end

  dialog.flash = nil
  dialog.fadeOut = nil
  dialog.mode = ""
	dialog.timer = timer;
	dialog.value = (value / 1000);
	dialog.scale = scale;
	if ( paused > 0 ) then
		dialog.paused = 1;
	else
		dialog.paused = nil;
	end

	-- Set the text of the dialog
	local text = getglobal(dialog:GetName().."StatusBarText");
	text:SetText(label);

	-- Set the status bar of the dialog
	local statusbar = getglobal(dialog:GetName().."StatusBar");
	statusbar:SetMinMaxValues(0, (maxvalue / 1000));
	statusbar:SetValue(dialog.value);

  local Red, Green, Blue, Alpha
  if (timer == "FEIGNDEATH") then
    Red, Green, Blue, Alpha = unpack(eCastingBar_Saved[eCastingBar_Player].FeignDeathColor)
  elseif (timer == "EXHAUSTION") then
    Red, Green, Blue, Alpha = unpack(eCastingBar_Saved[eCastingBar_Player].ExhaustionColor)
  elseif (timer == "BREATH") then
    Red, Green, Blue, Alpha = unpack(eCastingBar_Saved[eCastingBar_Player].BreathColor)
  else
    Red, Green, Blue, Alpha = unpack(eCastingBar_Saved[eCastingBar_Player].ChannelColor)
  end
	statusbar:SetStatusBarColor(Red, Green, Blue, Alpha);

  -- show the spark
	getglobal(statusbar:GetName().."Spark"):Show( )

  -- set the text to the spell name
  -- figure out how much to show
  if ( eCastingBar_Saved[eCastingBar_Player].MirrorSpellLength == -1 ) then
    -- show all
  	getglobal(statusbar:GetName().."Text"):SetText( label )
  elseif ( eCastingBar_Saved[eCastingBar_Player].MirrroSpellLength == 0) then
    -- dont show it
    getglobal(statusbar:GetName().."Text"):SetText( "" ) 
  else
    -- if the size of the name is less than or equal to the max size, just show it all
    if ( string.len(label) <= eCastingBar_Saved[eCastingBar_Player].MirrorSpellLength ) then
    	getglobal(statusbar:GetName().."Text"):SetText( label )
    else
      getglobal(statusbar:GetName().."Text"):SetText( string.sub(label , 1, eCastingBar_Saved[eCastingBar_Player].MirrorSpellLength) )
    end
  end
	
	-- set the bar to fully opaque
	dialog:SetAlpha( 1.0 )

	dialog:Show();

	return dialog;
end


function eCastingBarMirror_OnEvent()
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		this:Hide();
		this.timer = nil;
	end
	if ( not this:IsShown() or (arg1 ~= this.timer) ) then
		return;
	end
	if ( event == "MIRROR_TIMER_PAUSE" ) then
		if ( arg1 > 0 ) then
			this.paused = 1;
		else
			this.paused = nil;
		end
		return;
	end
	if ( event == "MIRROR_TIMER_STOP" ) then
    -- start the flash state
		getglobal(this:GetName().."Flash"):SetAlpha( 0.0 )
		getglobal(this:GetName().."Flash"):Show( )
		this.flash = 1
		this.fadeOut = 1
		this.mode = "flash"
	end
end

function eCastingBarMirror_OnUpdate(frame, elapsed)
	if ( frame.paused ) then
		return;
	end
  
  if( frame.flash ) then
    -- yes, sest the flash alpha
    local intAlpha = getglobal(frame:GetName().."Flash"):GetAlpha( ) + CASTING_BAR_FLASH_STEP
    
    -- reset the text
    getglobal(frame:GetName().."StatusBar_Time"):SetText( "" )
    
    -- is the flash alpha < 1?
    if( intAlpha < 1 ) then
    
      -- yes, step it up
      getglobal(frame:GetName().."Flash"):SetAlpha( intAlpha )
      
    else
    
      -- no, which means its 1 or greater, and we are at full alpha and done.
      frame.flash = nil
      
    end
    
  -- no, are we fading out now?
  elseif ( frame.fadeOut ) then
    --yes, set the CastingBar alpha
    local intAlpha = frame:GetAlpha( ) - CASTING_BAR_ALPHA_STEP
    
    -- is the bar alpha > 0?
    if( intAlpha > 0 ) then
    
      -- step it down
      frame:SetAlpha( intAlpha )
      
    else
    
      -- no, which means its 0 or larger, and we are at fully transparent so we are done and hide the bar.
      frame.fadeOut = nil
      frame.timer = nil
      frame:Hide( )
      
    end
    
  else
    local statusbar = getglobal(frame:GetName().."StatusBar");
    frame.value = (frame.value + frame.scale * elapsed);
    statusbar:SetValue(frame.value);

    local intTimeLeft = frame.value
    local intBarValue = 0
    local min, max = statusbar:GetMinMaxValues();
    local intSparkPosition = max
      
    -- Thanks to wbb at Cursed for the lovely formating
    if (eCastingBar_Saved[eCastingBar_Player].MirrorShowTime == 1) then    	
      -- if we are over 1 minute, do minute:seconds
      local timeLeft = math.max( intTimeLeft - min, 0.0 )
      local timeMsg = nil

      local minutes = 0
      local seconds = 0

      if (timeLeft > max) then
        timeLeft = max
      end

      if (timeLeft > 60) then
        minutes = math.floor( ( timeLeft  / 60 ))
        local seconds = math.ceil( timeLeft - ( 60 * minutes ))

        if (seconds == 60) then
          minutes = minutes + 1
          seconds = 0
        end
        timeMsg = format("%s:%s", minutes, getFormattedNumber(seconds))
      else
        timeMsg = string.format( "%.1f", timeLeft )
      end

      --format(COOLDOWNCOUNT_MINUTES_SECONDS_FORMAT, minutes, CooldownCount_GetFormattedNumber(seconds))
      getglobal(statusbar:GetName().."_Time"):SetText( timeMsg )
    else
      getglobal(statusbar:GetName().."_Time"):SetText("")
    end
    
    -- is the time left greater than channeling end time?
    if( intTimeLeft > max ) then
    
      -- yes, set it to the channeling end time (this will happen if you get delayed longer than the time left on channeling)
      intTimeLeft = max
      
    end
      
    -- update the bar length
    intBarValue = intTimeLeft
    --getglobal("eCastingBar"..frame.."StatusBar"):SetValue( intBarValue )
    
    --reset the flash to hidden
    getglobal(frame:GetName().."Flash"):Hide( )
    
    -- updates the spark
    local width = getglobal(frame:GetName().."Background"):GetWidth()
    intSparkPosition = ( intBarValue / max ) * width
    getglobal(frame:GetName().."StatusBarSpark"):SetPoint( "CENTER", frame:GetName().."StatusBar", "LEFT", intSparkPosition, 0 )
  end
end

function eCastingBarMirror_MouseUp( strButton )

	if( eCastingBar_Saved[eCastingBar_Player].MirrorLocked == 0 ) then
		eCastingBarMirror_Outline:StopMovingOrSizing( )
    eCastingBar_Saved[eCastingBar_Player].MirrorLeft = eCastingBarMirror_Outline:GetLeft()
    eCastingBar_Saved[eCastingBar_Player].MirrorBottom = eCastingBarMirror_Outline:GetBottom()
    
    eCastingBarMirrorLeftSlider:SetValue(eCastingBar_Saved[eCastingBar_Player].MirrorLeft)
    eCastingBarMirrorBottomSlider:SetValue(eCastingBar_Saved[eCastingBar_Player].MirrorBottom)
	end
end

--[[ Stops moving the frame. ]]--
function eCastingBarMirror_MouseDown( strButton )
	if( strButton == "LeftButton" and (eCastingBar_Saved[eCastingBar_Player].MirrorLocked == 0 ) ) then
		eCastingBarMirror_Outline:StartMoving( )
	end
end