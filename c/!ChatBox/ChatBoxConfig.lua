----------------------------------------------------------------------------------------------------
-- ChatBox Slash Commands
----------------------------------------------------------------------------------------------------
function ChatBox_Commands(msg)
   if msg == nil then msg = "" end

   msg = string.lower(msg)

   -- No parameter or not one listed from above
   if msg == "" or msg == "?" or msg == string.lower(CB_OPTIONS) or msg == string.lower(CB_HELP) then

      cb_display("\n");
      cb_display(YEL..CB_HELPTITLE.."   /ts and /plm are also valid options.".."\n")
      cb_display(YEL .. CB_SHORTCUTS);
      cb_display(WHT .. CB_STICKY .. " : " .. RED .. ChatBox_check(ChatBox.setSticky) ..GRN.. CB_STICKY_HELP_TEXT)
      cb_display(WHT .. CB_SHORTLFG .. " : " .. RED ..  ChatBox_check(ChatBox.shortLFG) ..GRN..CB_SHORTLFG_HELP_TEXT)
      cb_display(WHT .. CB_HIDEBOTTOMBUTTON .. " : " .. RED .. ChatBox_check(ChatBox.hideBottomButton) ..GRN..CB_HIDEBOTTOMBUTTON_HELP_TEXT)
      cb_display(WHT .. CB_THROTTLE .. " : " .. RED .. ChatBox_check(ChatBox.throttle) ..GRN..CB_THROTTLE_HELP_TEXTA)
      cb_display(RED .. "                     0 "..GRN..CB_THROTTLE_HELP_TEXTB..RED.."1-20"..GRN..CB_THROTTLE_HELP_TEXTC)
      cb_display(WHT .. CB_GTHROTTLE .. " : " .. RED .. ChatBox_check(ChatBox.gthrottle) ..GRN..CB_GTHROTTLE_HELP_TEXTA)
      cb_display(RED .. "                     0 "..GRN..CB_GTHROTTLE_HELP_TEXTB..RED.."1-30"..GRN..CB_GTHROTTLE_HELP_TEXTC)
      cb_display(WHT .. CB_HIDEGOSSIP .. " : " .. RED .. ChatBox_check(ChatBox.hideGossip) ..GRN..CB_HIDEGOSSIP_HELP_TEXT)
      cb_display(WHT .. CB_USEARROWS .. " : " .. RED .. ChatBox_check(ChatBox.useArrows) ..GRN..CB_USEARROWS_HELP_TEXT)
      cb_display(WHT .. CB_EDITATTOP .. " : " .. RED .. ChatBox_check(ChatBox.editAtTop) ..GRN..CB_EDITATTOP_HELP_TEXT)
      cb_display(WHT .. CB_HIDEEMOTEBUTTON .. " : " .. RED .. ChatBox_check(ChatBox.hideEmoteButton) ..GRN..CB_HIDEEMOTEBUTTON_HELP_TEXT)
      cb_display(WHT .. CB_MENUSIDE .. " : " .. RED .. ChatBox_check(ChatBox.menuOnLeft) ..GRN..CB_MENUSIDE_HELP_TEXT)
      cb_display(WHT .. CB_COLORNAMES .. " : " .. RED .. ChatBox_check(ChatBox.colorNames) ..GRN..CB_COLORNAMES_HELP_TEXT)
      cb_display(WHT .. CB_COLORRANDOM .. " : " .. RED .. ChatBox_check(ChatBox.colorRandom) ..GRN..CB_COLORRANDOM_HELP_TEXT)
      cb_display(WHT .. CB_LONGSTRINGS .. " : " .. RED .. ChatBox_check(ChatBox.longStrings) ..GRN..CB_LONGSTRINGS_HELP_TEXT)
      cb_display(WHT .. CB_TRUNCLENGTH .. " : " .. RED .. ChatBox_check(ChatBox.truncLength) ..GRN..CB_TRUNCLENGTH_HELP_TEXTA)
      cb_display(RED .. "                     100 "..GRN..CB_TRUNCLENGTH_HELP_TEXTB..RED.."0-20"..GRN..CB_TRUNCLENGTH_HELP_TEXTC)
      cb_display(WHT .. CB_CLINK .. " : " .. RED .. ChatBox_check(ChatBox.CLINK) ..GRN..CB_CLINK_HELP_TEXT)
      cb_display(WHT .. CB_NORRIS .. " : " .. RED .. ChatBox_check(ChatBox.chuckNorris) ..GRN..CB_NORRIS_HELP_TEXT)

   --to change the sticky
   elseif ( string.find(msg, string.lower(CB_STICKY_SHORT))) then
      if ChatBox.setSticky then
         cb_display(WHT..CB_STICKY_TEXT..RED..CB_OFF);
         ChatBox.setSticky = false;
      else
         cb_display(WHT..CB_STICKY_TEXT..RED..CB_ON);
         ChatBox.setSticky = true;
      end
      ChatBox_SetSticky();


   --to change the shortLFG tag (Change LookingForGroup to LFG) TODO possilby add more. (G, T, WD, LD)?
   elseif ( string.find(msg, string.lower(CB_SHORTLFG_SHORT))) then
      if ChatBox.shortLFG then
         cb_display(WHT..CB_SHORTLFG_TEXT..RED..CB_OFF);
         ChatBox.shortLFG = false;
      else
         cb_display(WHT..CB_SHORTLFG_TEXT..RED..CB_ON);
         ChatBox.shortLFG = true;
      end

   --to change the scroll to bottom button display
   elseif ( string.find(msg, string.lower(CB_HIDEBOTTOMBUTTON_SHORT))) then
      if ChatBox.hideBottomButton then
         cb_display(WHT..CB_HIDEBOTTOMBUTTON_TEXT..RED..CB_ON);
         ChatBox.hideBottomButton = false;
      else
         cb_display(WHT..CB_HIDEBOTTOMBUTTON_TEXT..RED..CB_OFF);
         ChatBox.hideBottomButton = true;
      end


   --to change the emote/language button display
   elseif ( string.find(msg, string.lower(CB_HIDEEMOTEBUTTON_SHORT))) then
      if ChatBox.hideEmoteButton then
         cb_display(WHT..CB_HIDEEMOTEBUTTON_TEXT..RED..CB_ON);
         ChatFrameMenuButton:Show();
         ChatBox.hideEmoteButton = false;
      else
         cb_display(WHT..CB_HIDEEMOTEBUTTON_TEXT..RED..CB_OFF);
         ChatFrameMenuButton:Hide();
         ChatBox.hideEmoteButton = true;
      end


   --to change the hideGossip display
   elseif ( string.find(msg, string.lower(CB_HIDEGOSSIP_SHORT))) then
      if ChatBox.hideGossip then
         cb_display(WHT..CB_HIDEGOSSIP_TEXT..RED..CB_OFF);
         ChatBox.hideGossip = false;
      else
         cb_display(WHT..CB_HIDEGOSSIP_TEXT..RED..CB_ON);
         ChatBox.hideGossip = true;
      end

   --to change the useArrows behavior
   elseif ( string.find(msg, string.lower(CB_USEARROWS_SHORT))) then
      if ChatBox.useArrows then
         cb_display(WHT..CB_USEARROWS_TEXT.. RED .. CB_OFF);
         ChatFrameEditBox:SetAltArrowKeyMode(true);
         ChatBox.useArrows = false;
      else
         cb_display(WHT..CB_USEARROWS_TEXT .. RED .. CB_ON);
         ChatFrameEditBox:SetAltArrowKeyMode(false);
         ChatBox.useArrows = true;
      end

   --to change the editAtTop display
   elseif ( string.find(msg, string.lower(CB_EDITATTOP_SHORT)) ) then
      if ChatBox.editAtTop then
         cb_display(WHT..CB_EDITATTOP_TEXTA..RED..CB_BOTTOM..WHT..CB_EDITATTOP_TEXTB);
         ChatFrameEditBox:ClearAllPoints();
         ChatFrameEditBox:SetPoint("TOPLEFT", "ChatFrame1", "BOTTOMLEFT", 0, 2);
         ChatFrameEditBox:SetPoint("TOPRIGHT", "ChatFrame1", "BOTTOMRIGHT", 0, 2);
         ChatBox.editAtTop = false;
      else
         cb_display(WHT..CB_EDITATTOP_TEXTA..RED..CB_TOP..WHT..CB_EDITATTOP_TEXTB);
         ChatFrameEditBox:ClearAllPoints();
         ChatFrameEditBox:SetPoint("BOTTOMLEFT", "ChatFrame1", "TOPLEFT", 0, 2);
         ChatFrameEditBox:SetPoint("BOTTOMRIGHT", "ChatFrame1", "TOPRIGHT", 0, 2);
         ChatBox.editAtTop = true;
      end


   --to change the throttle
   elseif ( string.find(msg, string.lower(CB_THROTTLE_SHORT)) ) then
       local index = string.find(msg, " ");
        if (index) then
            local test = tonumber(strsub(msg, index+1));
            if ( test and test == 0 ) then
               cb_display(WHT..CB_THROTTLE_TEXTA..RED..CB_OFF);
               ChatBox.throttle = false;
            elseif ( test and test > 0 and test < 21 ) then
               ChatBox.throttle = test;
               cb_display(WHT..CB_THROTTLE_TEXTA..RED..ChatBox.throttle);
            else
               cb_display(WHT..CB_THROTTLE_TEXTB..RED.."1-20");
            end
        else
            cb_display(WHT..CB_THROTTLE_TEXTA..RED..ChatBox_check(ChatBox.throttle));
        end

   --to change the guild throttle
   elseif ( string.find(msg, string.lower(CB_GTHROTTLE_SHORT)) ) then
       local index = string.find(msg, " ");
        if (index) then
            local test = tonumber(strsub(msg, index+1));
            if ( test and test == 0 ) then
               cb_display(WHT..CB_GTHROTTLE_TEXTA..RED..CB_OFF);
               ChatBox.gthrottle = false;
            elseif ( test and test > 0 and test < 31 ) then
               ChatBox.gthrottle = test;
               cb_display(WHT..CB_GTHROTTLE_TEXTA..RED..ChatBox.gthrottle);
            else
               cb_display(WHT..CB_GTHROTTLE_TEXTB..RED.."1-30");
            end
        else
            cb_display(WHT..CB_GTHROTTLE_TEXTA..RED..ChatBox_check(ChatBox.gthrottle));
        end

   --to change the truncLength for channel names in chat
   elseif ( string.find(msg, string.lower(CB_TRUNCLENGTH_SHORT)) ) then
       local index = string.find(msg, " ");
        if (index) then
            local test = tonumber(strsub(msg, index+1));
            if ( test and test == 100 ) then
               cb_display(WHT..CB_TRUNCLENGTH_TEXTA..RED..CB_OFF);
               ChatBox.truncLength = 100;
            elseif ( test and test >= 0 and test < 21 ) then
               ChatBox.truncLength = test;
               cb_display(WHT..CB_TRUNCLENGTH_TEXTA..RED..ChatBox.truncLength);
            else
               cb_display(WHT..CB_TRUNCLENGTH_TEXTB..RED.."0-20");
            end
        else
            cb_display(WHT..CB_TRUNCLENGTH_TEXTA..RED..ChatBox_check(ChatBox.truncLength));
        end

   --to change which side the buttons are on.
   elseif ( string.find(msg, string.lower(CB_MENUSIDE_SHORT)) ) then
      if ChatBox.menuOnLeft then
         cb_display(WHT..CB_MENUSIDE_TEXT.. RED .. CB_OFF);
         ChatBox.menuOnLeft = false;
      else
         cb_display(WHT..CB_MENUSIDE_TEXT .. RED .. CB_ON);
         ChatBox.menuOnLeft = true;
      end
      ChatBox_Relocate_Buttons()

   --to change the color of names in chat behavior
   elseif ( string.find(msg, string.lower(CB_COLORNAMES_SHORT))) then
      if ChatBox.colorNames then
         cb_display(WHT..CB_COLORNAMES_TEXT.. RED .. CB_OFF);
         ChatBox.colorNames = false;
      else
         cb_display(WHT..CB_COLORNAMES_TEXT .. RED .. CB_ON);
         ChatBox.colorNames = true;
      end
      ChatBox_SetStrings();

   --to change the RANDOM color of names in chat behavior
   elseif ( string.find(msg, string.lower(CB_COLORRANDOM_SHORT))) then
      if ChatBox.colorRandom then
         cb_display(WHT..CB_COLORRANDOM_TEXT.. RED .. CB_OFF);
         ChatBox.colorRandom = false;
      else
         cb_display(WHT..CB_COLORRANDOM_TEXT .. RED .. CB_ON);
         ChatBox.colorRandom = true;
      end

   --to change showing [Party] [Guild] [Raid] in chat.
   elseif ( string.find(msg, string.lower(CB_LONGSTRINGS_SHORT))) then
      if ChatBox.longStrings then
         cb_display(WHT..CB_LONGSTRINGS_TEXT.. RED .. CB_OFF);
         ChatBox.longStrings = false;
      else
         cb_display(WHT..CB_LONGSTRINGS_TEXT .. RED .. CB_ON);
         ChatBox.longStrings = true;
      end
      ChatBox_SetStrings();

   --to change if you want to use the CLINK tag
   elseif ( string.find(msg, string.lower(CB_CLINK_SHORT))) then
      if ChatBox.CLINK then
         cb_display(WHT..CB_CLINK_TEXT..RED..CB_OFF);
         ChatBox.CLINK = false;
      else
         cb_display(WHT..CB_CLINK_TEXT..RED..CB_ON);
         ChatBox.CLINK = true;
      end

    --to change if you want to use the Chuck Norris spam nuker
   elseif ( string.find(msg, string.lower(CB_NORRIS_SHORT))) then
      if ( string.find(msg, string.lower(CB_VERBOSE))) then
            cb_display(WHT..CB_NORRIS_TEXT..RED..CB_ON.." ("..CB_VERBOSE..")");
            ChatBox.chuckNorris = CB_VERBOSE;
      else
         if ChatBox.chuckNorris then
            cb_display(WHT..CB_NORRIS_TEXT..RED..CB_OFF);
            ChatBox.chuckNorris = false;
	      else
             cb_display(WHT..CB_NORRIS_TEXT..RED..CB_ON);
             ChatBox.chuckNorris = true;
	      end
      end

    --no idea what they typed!!!
   else
      cb_display(RED .. CB_ERRORMSG)
   end
end

----------------------------------------------------------------------------------------------------
-- TimeStamp Commands
----------------------------------------------------------------------------------------------------

-- Handles a slash command
function ChatBox_TimeStamp_Commands(msg)

   if msg == nil then msg = "" end

   if not (string.find(msg, CB_TS_FORMAT)) then
      msg = string.lower(msg)
   end

   -- No parameter or not one listed from above
   if msg == "" or msg == "?" or msg == string.lower(CB_OPTIONS) or msg == string.lower(CB_HELP) then

      cb_display("\n");
      cb_display(YEL..CB_TS_HELPTITLE.."   /cb and /plm are also valid options.".."\n")
      -- List all chat frames and their status
		for i = 1, 7 do
		   local name = "ChatFrame"..i;
		   local status = ChatBox.TimeStamp_Settings.frames[name];
			local tabtext  =  getglobal(name .. "TabText"):GetText();
			if (tabtext) then
				name = name .. " (" .. tabtext .. ")";
			end
			if (status and status == CB_ON) then
			   cb_display(string.format("    " .. CB_TS_FRAMESTATUS_TEXT, WHT .. name .. END, GRN .. CB_ON));
			else
			   cb_display(string.format("    " .. CB_TS_FRAMESTATUS_TEXT, WHT .. name .. END, RED .. CB_OFF));
			end
		end
		cb_display(YEL .. "        " .. CB_TIMESTAMP_FRAME_HELP1);
		cb_display(YEL .. "        " .. CB_TIMESTAMP_FRAME_HELP2);
		cb_display("\n");

      cb_display(WHT .. CB_TS_COLOR .. " : " .. ChatBox_check_color() ..GRN.. CB_TS_COLOR_HELP_TEXT)
      cb_display(WHT .. CB_TS_FORMAT .. " : " .. RED .. ChatBox_check(ChatBox.TimeStamp_Settings.format).. GRN.. CB_TS_FORMAT_HELP_TEXTA)
      cb_display(WHT .. CB_TS_FORMAT_HELP_TEXTB);
      cb_display(WHT .. CB_TS_RESET .. GRN.. CB_TS_RESET_HELP_TEXT)



	elseif (msg == CB_TS_COLOR) then
		-- Change the color of the timestamps using a color picker
		ChatBox_TimeStamp_ColorPicker();

	elseif (msg == CB_TS_COLOR .. " " .. string.lower(CB_OFF)) then
		-- Disable the coloring of the timestamps
		ChatBox.TimeStamp_Settings.color = false;
		--ChatBox_TimeStamp_Set(CB_TS_COLOR, CB_OFF);
		cb_display(WHT..CB_TS_COLOR_TEXT .. " " .. ChatBox_check_color());

	elseif (string.find(msg, CB_TS_FORMAT)) then
	   local index = string.find(msg, " ");
        if (index) then
            local test = string.sub(msg, index+1)
            if ( test ) then
               ChatBox.TimeStamp_Settings.format = test;
            else
               ChatBox.TimeStamp_Settings.format = "[%H:%M:%S]";
            end
        else
           ChatBox.TimeStamp_Settings.format = "[%H:%M:%S]";
        end

		-- Show a message notifying the user what happened
		cb_display(WHT..CB_TS_FORMAT_TEXT .. " " .. RED .. ChatBox.TimeStamp_Settings.format);

	elseif (string.find(msg, string.lower(CB_ON))) then
      local index = string.find(msg, " ");
      if (index) then
         local test = string.sub(msg, index+1)
         if ( test ) then
            test = "ChatFrame"..tostring(test)
            ChatBox.TimeStamp_Settings.frames[test] = CB_ON;
            cb_display(string.format(CB_TIMESTAMP_FRAMEENABLED, GRN .. test .. END));
         else
            cb_display(RED .. CB_ERRORMSG)
         end
      else
         cb_display(RED .. CB_ERRORMSG)
      end

   elseif (string.find(msg, string.lower(CB_OFF))) then
      local index = string.find(msg, " ");
      if (index) then
         local test = string.sub(msg, index+1)
         if ( test ) then
            test = "ChatFrame"..tostring(test)
            ChatBox.TimeStamp_Settings.frames[test] = CB_OFF;
            cb_display(string.format(CB_TIMESTAMP_FRAMEDISABLED, GRN .. test .. END));
         else
            cb_display(RED .. CB_ERRORMSG)
         end
      else
         cb_display(RED .. CB_ERRORMSG)
      end

	elseif (msg == CB_TS_RESET) then
		-- Reset the settings of the current character back to defaults
		ChatBox.TimeStamp_Settings = {
   		color = false,
   		format = "[%H:%M:%S]",
   		frames = {
   			ChatFrame1 = CB_OFF,
   			ChatFrame2 = CB_OFF,
   			ChatFrame3 = CB_OFF,
   			ChatFrame4 = CB_OFF,
   			ChatFrame5 = CB_OFF,
   			ChatFrame6 = CB_OFF,
   			ChatFrame7 = CB_OFF,
   		   },
   		};

		-- Show a message notifying the user what happened
		cb_display(RED .. CB_TS_RESET_TEXT);

	--no idea what they typed!!!
   else
      cb_display(RED .. CB_ERRORMSG)
   end
end

----------------------------------------------------------------------------------------------------
-- PLM Slash Commands
----------------------------------------------------------------------------------------------------
function ChatBox_PLM_Commands(msg)
   if msg == nil then msg = "" end

   msg = string.lower(msg)

   -- No parameter or not one listed from above
   if msg == "" or msg == "?" or msg == string.lower(CB_OPTIONS) or msg == string.lower(CB_HELP) then
      cb_display("\n");
      cb_display(YEL..CB_HELPTITLE.."   /cb and /ts are also valid options.".."\n");
      cb_display(WHT .. CB_PLM_TEXT .. RED .. ChatBox_check(ChatBox.plm))
      cb_display("             " .. GRN .. CB_PLM_HELP_TEXT);
      cb_display(GRY .. CB_PLM_HELPA);
      cb_display(GRY .. CB_PLM_HELPB .. WHT .. CB_PLM_HELPC);
      cb_display(ORN .. CB_PLM_HELPD);
      cb_display("\n");
      cb_display(WHT .. CB_PLM_ALT_TEXT_HELP .. RED .. ChatBox_check(ChatBox.plm_alt_name));
      cb_display(WHT .. CB_PLM_SHIFT_TEXT_HELP .. RED .. ChatBox_check(ChatBox.plm_shift_name));
      cb_display(WHT .. CB_PLM_CTRL_TEXT_HELP .. RED .. ChatBox_check(ChatBox.plm_ctrl_name));


   --to toggle the Player Link Menu.
   elseif ( msg == string.lower(CB_ON) or msg == string.lower(CB_OFF) ) then
      if ChatBox.plm then
         cb_display(WHT..CB_PLM_TEXT..RED..CB_OFF);
         ChatBox.plm = false;
      else
         cb_display(WHT..CB_PLM_TEXT..RED..CB_ON);
         ChatBox.plm = true;
      end
      SetupPLM();


   --to change the alt key functionality
   elseif (string.find(msg, string.lower(CB_PLM_ALT))) then
      local index = string.find(msg, " ");
      if (index) then
         local test = string.sub(msg, index+1)
         if ( test ) then
            if test == string.lower(WHO) then
               ChatBox.plm_alt = ChatBox_specialSendWho;
               ChatBox.plm_alt_name = WHO;
            elseif test == string.lower(CB_TARGET) then
               ChatBox.plm_alt = TargetByName;
               ChatBox.plm_alt_name = CB_TARGET;
            elseif test == string.lower(WHISPER) then
               ChatBox.plm_alt = ChatFrame_SendTell;
               ChatBox.plm_alt_name = WHISPER;
            elseif test == string.lower(PARTY_INVITE) then
               ChatBox.plm_alt = InviteByName;
               ChatBox.plm_alt_name = PARTY_INVITE;
            elseif test == string.lower(IGNORE) then
               ChatBox.plm_alt = AddIgnore;
               ChatBox.plm_alt_name = IGNORE;
            end
         cb_display(WHT .. CB_PLM_ALT_TEXT_HELP .. RED .. ChatBox.plm_alt_name);
         end
      else
   		ChatBox.plm_alt = false;
   		ChatBox.plm_alt_name = CB_OFF;
	      cb_display(WHT .. CB_PLM_ALT_TEXT_HELP .. RED .. CB_OFF);
      end

  --to change the shift key functionality
   elseif (string.find(msg, string.lower(CB_PLM_SHIFT))) then
      local index = string.find(msg, " ");
      if (index) then
         local test = string.sub(msg, index+1)
         if ( test ) then
            if test == string.lower(WHO) then
               ChatBox.plm_shift = ChatBox_specialSendWho;
               ChatBox.plm_shift_name = WHO;
            elseif test == string.lower(CB_TARGET) then
               ChatBox.plm_shift = TargetByName;
               ChatBox.plm_shift_name = CB_TARGET;
            elseif test == string.lower(WHISPER) then
               ChatBox.plm_shift = ChatFrame_SendTell;
               ChatBox.plm_shift_name = WHISPER;
            elseif test == string.lower(PARTY_INVITE) then
               ChatBox.plm_shift = InviteByName;
               ChatBox.plm_shift_name = PARTY_INVITE;
            elseif test == string.lower(IGNORE) then
               ChatBox.plm_shift = AddIgnore;
               ChatBox.plm_shift_name = IGNORE;
            end
         cb_display(WHT .. CB_PLM_SHIFT_TEXT_HELP .. RED .. ChatBox.plm_shift_name);
         end
      else
   		ChatBox.plm_shift = false;
   		ChatBox.plm_shift_name = CB_OFF;
	      cb_display(WHT .. CB_PLM_SHIFT_TEXT_HELP .. RED .. CB_OFF);
      end

  --to change the control key functionality
   elseif (string.find(msg, string.lower(CB_PLM_CTRL))) then
      local index = string.find(msg, " ");
      if (index) then
         local test = string.sub(msg, index+1)
         if ( test ) then
            if test == string.lower(WHO) then
               ChatBox.plm_ctrl = ChatBox_specialSendWho;
               ChatBox.plm_ctrl_name = WHO;
            elseif test == string.lower(CB_TARGET) then
               ChatBox.plm_ctrl = TargetByName;
               ChatBox.plm_ctrl_name = CB_TARGET;
            elseif test == string.lower(WHISPER) then
               ChatBox.plm_ctrl = ChatFrame_SendTell;
               ChatBox.plm_ctrl_name = WHISPER;
            elseif test == string.lower(PARTY_INVITE) then
               ChatBox.plm_ctrl = InviteByName;
               ChatBox.plm_ctrl_name = PARTY_INVITE;
            elseif test == string.lower(IGNORE) then
               ChatBox.plm_ctrl = AddIgnore;
               ChatBox.plm_ctrl_name = IGNORE;
            end
         cb_display(WHT .. CB_PLM_CTRL_TEXT_HELP .. RED .. ChatBox.plm_ctrl_name );
         end
      else
   		ChatBox.plm_ctrl = false;
   		ChatBox.plm_ctrl_name = CB_OFF;
	      cb_display(WHT .. CB_PLM_CTRL_TEXT_HELP .. RED .. CB_OFF);
      end

   --no idea what they typed!!!
   else
      cb_display(RED .. CB_ERRORMSG)
   end
end