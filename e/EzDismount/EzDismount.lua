-- EzDismount : A quick and dirty dismounting mod, useful for PVP or herb/ore collecting
-- By Gaddur of the Eonar Server
-- Modified v2.01 by nathan

local EzDClass
local EzDPlayer

EzDismount_ver = "v2.03";
EzDismount_fullver = ("EzDismount " .. EzDismount_ver);

BINDING_HEADER_EZDISMOUNT  = "EzDismount";
BINDING_NAME_EZDISMOUNT    = "Dismount";

---------------------------------
-- Stuff to do when Mod is loaded
---------------------------------
function EzDismount_onload()

	EzDClass = UnitClass("player");
	EzDPlayer = (UnitName("player").." of "..GetCVar("realmName"))
	EZDismount_DetPlayer:SetText(EzDPlayer.." Server");

	--Create user table if it doesnt exist
	if (EzDismount_Config == nil) then
		EzDismount_Config = {};
	end

	if (EzDismount_Config[EzDPlayer] == nil) then
		EzDismount_reset();
	end

  	DEFAULT_CHAT_FRAME:AddMessage("## " .. EzDismount_fullver .. " Loaded ##  Use /ezd or /ezd help", 0.0, 1.0, 0.0);

  	SlashCmdList["EZDISMOUNT"] = EzDismount_options;
   	SLASH_EZDISMOUNT1 = "/ezd";
   	SLASH_EZDISMOUNT2 = "/ezdismount";

	-- Set Default Colors
	EZDismount_ShamanTitle:SetTextColor(255,255,255,255);
	EZDismount_DruidTitle:SetTextColor(255,255,255,255);
    	EZDismount_PriestTitle:SetTextColor(255,255,255,255);
	EzDismount_Text_Status_VOFF:SetTextColor(255,0,0,255);
	EzDismount_Text_Status_VON:SetTextColor(0,255,0,255);
	EzDismount_Text_Shaman_VOFF:SetTextColor(255,0,0,255);
	EzDismount_Text_Shaman_VON:SetTextColor(0,255,0,255);
	EzDismount_Text_Druid_VOFF:SetTextColor(255,0,0,255);
	EzDismount_Text_Druid_VON:SetTextColor(0,255,0,255);
	EzDismount_Text_Moonkin_VOFF:SetTextColor(255,0,0,255);
	EzDismount_Text_Moonkin_VON:SetTextColor(0,255,0,255);
  	EzDismount_Text_Shadowform_VOFF:SetTextColor(255,0,0,255);
	EzDismount_Text_Shadowform_VON:SetTextColor(0,255,0,255);
	EzDismount_Text_Stand_VOFF:SetTextColor(255,0,0,255);
	EzDismount_Text_Stand_VON:SetTextColor(0,255,0,255);
	EzDismount_Text_Auction_VOFF:SetTextColor(255,0,0,255);
	EzDismount_Text_Auction_VON:SetTextColor(0,255,0,255);
	EZDismount_DetPlayer:SetTextColor(255,255,255,255);

 end

----------------------------------
-- Parse out option from / Command
----------------------------------
function EzDismount_options(msg)

        -- Show Config Menu
	if (msg == "") then
         	EzDismount_Toggle();
        end

        -- Dump Textures to chatwindow
	if (string.lower(msg) == "debug") then
		EzDismount_dumpbuff();
  	end

	 -- Reload UI
	if (string.lower(msg) == "reload") then
		ReloadUI();
  	end

  	-- Reset Settings
	if (string.lower(msg) == "reset") then
		EzDismount_reset();
  	end

        -- Help
	if (string.lower(msg) == "help") or (msg == "?") then
		EzDismount_help();
  	end


end

------------------
-- Reset Variables
------------------
function EzDismount_reset()

        EzDismount_Config[EzDPlayer] = {
			["Dismount"]   = "ON";
			["Druid"]      = "ON";
                        ["Shadowform"] = "ON";
			["Wolf"]       = "ON";
			["Moonkin"]    = "ON";
			["Stand"]      = "ON";
                        ["Auction"]    = "ON";
	}

end

----------------
-- Toggle Values
----------------
function EzDismount_ChgValue(msg)


	local NewVal = ""

   -- Auto-dismount toggle
	if (string.lower(msg) == "on/off") then

		if (EzDismount_Config[EzDPlayer]["Dismount"] == "ON") then
			EzDismount_Config[EzDPlayer]["Dismount"] = "TAXI";
			NewVal = "Y";
		end

		if ((EzDismount_Config[EzDPlayer]["Dismount"] == "TAXI") and (NewVal == "")) then
			EzDismount_Config[EzDPlayer]["Dismount"] = "OFF";
			NewVal = "Y";
		end

		if ((EzDismount_Config[EzDPlayer]["Dismount"] == "OFF") and (NewVal == "")) then
			EzDismount_Config[EzDPlayer]["Dismount"] = "ON";
         NewVal = "Y";
		end

        -- Auctioneer toggle
	elseif (string.lower(msg) == "auction") then

		if (EzDismount_Config[EzDPlayer]["Auction"] == "ON") then
			EzDismount_Config[EzDPlayer]["Auction"] = "OFF";
		else
			EzDismount_Config[EzDPlayer]["Auction"] = "ON";
		end

  	-- Stand toggle
	elseif (string.lower(msg) == "stand") then

		if (EzDismount_Config[EzDPlayer]["Stand"] == "ON") then
			EzDismount_Config[EzDPlayer]["Stand"] = "OFF";
		else
			EzDismount_Config[EzDPlayer]["Stand"] = "ON";
		end


   -- Druid toggle
	elseif (string.lower(msg) == "druid") then

		if (EzDismount_Config[EzDPlayer]["Druid"] == "ON") then
			EzDismount_Config[EzDPlayer]["Druid"] = "OFF";
		else
			EzDismount_Config[EzDPlayer]["Druid"] = "ON";
		end

	-- Shaman toggle
	elseif (string.lower(msg) == "wolf") then

		if (EzDismount_Config[EzDPlayer]["Wolf"] == "ON") then
			EzDismount_Config[EzDPlayer]["Wolf"] = "OFF";
		else
			EzDismount_Config[EzDPlayer]["Wolf"] = "ON";
		end


	-- Moonkin toggle
	elseif (string.lower(msg) == "moonkin") then

		if (EzDismount_Config[EzDPlayer]["Moonkin"] == "ON") then
			EzDismount_Config[EzDPlayer]["Moonkin"] = "OFF";
		else
			EzDismount_Config[EzDPlayer]["Moonkin"] = "ON";
		end


   -- Shadowform toggle
	elseif (string.lower(msg) == "shadowform") then

		if (EzDismount_Config[EzDPlayer]["Shadowform"] == "ON") then
			EzDismount_Config[EzDPlayer]["Shadowform"] = "OFF";
		else
			EzDismount_Config[EzDPlayer]["Shadowform"] = "ON";
		end

  	end

	EzDismount_Refresh();

end


-------------------------------
-- Check UI_ERROR_MESSAGE Event
-------------------------------
function EzDismount_chkerror(arg1)


   -- See if auto dismount is enabled
	if (EzDismount_Config[EzDPlayer]["Dismount"] ~= "OFF") then

      EzDismount_chkandgetdown("Dismount", EzDMountErr.Error, arg1, true);

      if ( arg1 == "TAXI") then
         EzDismount_getdown(true);
      end;
      
   end

   -- Auctioneer Dismount enabled
	if (EzDismount_Config[EzDPlayer]["Auction"] ~= "OFF") then

      if ( arg1 == "AUCTION") then
         EzDismount_getdown(true);
      end
   end

	-- Stand up if you are trying to do something while sitting
	if (EzDismount_Config[EzDPlayer]["Stand"] ~= "OFF") then

		if ( arg1 == EzDSitErr)  then
         SitOrStand();
		end
   end

   -- Check class specific things
	if (EzDClass == "Druid") then
      EzDismount_chkandgetdown("Druid", EzDShiftErr.Error, arg1);
      EzDismount_chkandgetdown("Moonkin", EzDShiftErr.Error, arg1);

   elseif (EzDClass == "Shaman") then
      EzDismount_chkandgetdown("Wolf", EzDShiftErr.Error, arg1);


   elseif (EzDClass == "Priest") then
      EzDismount_chkandgetdown("Shadowform", EzDShiftErr.Error, arg1);


   end
end


function EzDismount_chkandgetdown(chkType, errorTable, msg, mount)

   -- See if chkType is enabled
   if (EzDismount_Config[EzDPlayer][chkType] ~= "OFF") then

      -- If not on Taxi
      if ( not UnitOnTaxi("player") ) then
           for _, value in pairs(errorTable) do
             if ( msg == value) then
                EzDismount_getdown(mount);
                break;
             end
         end

      end
   end
end


-----------------------------------------
-- Look for Mount Buff Icon and cancel it
-----------------------------------------
function EzDismount_getdown(mount)

	local currBuffTex;
	local pallyhorse  = "spell_nature_swiftness";
  	local regMount    = "_mount_";
  	local bearform    = "ability_racial_bearform";
	local catform     = "ability_druid_catform";
	local travelform  = "ability_druid_travelform";
   	local shadowform  = "spell_shadow_shadowform";
   	local spiritwolf  = "spell_nature_spiritwolf";
	local moonkin     = "spell_nature_forceofnature";
   	local aqmount     = "_qirajicrystal_"
   	local aquaticform = "ability_druid_aquaticform";


   -- was this a dismount request or a shapeshift request?
   if mount then
      for i=0,15,1 do

         currBuffTex = GetPlayerBuffTexture(i);

         if (currBuffTex and (not EzD_exclude(i))) then

            -- Mount (or level 40 pally horse) or Qiraji Mounts
            if ((string.find(string.lower(currBuffTex), regMount) or string.find(string.lower(currBuffTex), pallyhorse)) or (string.find(string.lower(currBuffTex), aqmount))) then
               if ((EzDismount_Config[EzDPlayer]["Dismount"] == "ON") or (EzDismount_Config[EzDPlayer]["Dismount"] == "TAXI")) then
                  CancelPlayerBuff(i);
               end
            end
         end
      end

   else
      for i=0,15,1 do

         currBuffTex = GetPlayerBuffTexture(i);

         if (currBuffTex and (not EzD_exclude(i))) then

            -- GhostWolf
            if (string.find(string.lower(currBuffTex), spiritwolf)) then
               if (EzDismount_Config[EzDPlayer]["Wolf"] == "ON") then
                  CancelPlayerBuff(i);
                  break;
               end

            -- Bear Form
            elseif (string.find(string.lower(currBuffTex), bearform)) then
               if (EzDismount_Config[EzDPlayer]["Druid"] == "ON") then
                  CancelPlayerBuff(i);
                  break;
               end

            -- Cat Form
            elseif (string.find(string.lower(currBuffTex), catform)) then
               if (EzDismount_Config[EzDPlayer]["Druid"] == "ON") then
                  CancelPlayerBuff(i);
                  break;
               end

            -- Travel Form
            elseif (string.find(string.lower(currBuffTex), travelform)) then
               if (EzDismount_Config[EzDPlayer]["Druid"] == "ON") then
                  CancelPlayerBuff(i);
                  break;
               end

            -- Aquatic Form
            elseif (string.find(string.lower(currBuffTex), aquaticform)) then
               if (EzDismount_Config[EzDPlayer]["Druid"] == "ON") then
                  CancelPlayerBuff(i);
                  break;
               end

            -- Moonkin Form
            elseif (string.find(string.lower(currBuffTex), moonkin)) then
               if (EzDismount_Config[EzDPlayer]["Moonkin"] == "ON") then
                  CancelPlayerBuff(i);
                  break;
               end

            -- Shadowform
            elseif (string.find(string.lower(currBuffTex), shadowform)) then
               if (EzDismount_Config[EzDPlayer]["Shadowform"] == "ON") then
                  CancelPlayerBuff(i);
                  break;
               end


            end
         end
      end
   end

end

--------------------------------------
-- Exclude as mount based on buff name
--------------------------------------
function EzD_exclude(i)

   local buffname;
   local result = false;

   EzDTooltip:SetOwner(UIParent, "ANCHOR_NONE");

   EzDTooltip:ClearLines();
	EzDTooltip:SetPlayerBuff(i);
   buffname = EzDTooltipTextLeft1:GetText();

   if ( buffname ~= nil ) then
      for index=1, table.getn(EzDMountTable.Exclude), 1 do
         if ( EzDMountTable.Exclude[index] == string.lower(buffname) ) then
            result = true;
            break;
         end
      end
   end

   return result

end

----------------------------------------------------
-- Dump current Buff icon texture names (Debug Code)
----------------------------------------------------
function EzDismount_dumpbuff()

	local bufftext;
	local buffname;
  	local debugmsg;

   EzDTooltip:SetOwner(UIParent, "ANCHOR_NONE");

	for i=0,15,1 do

      EzDTooltip:ClearLines();
      EzDTooltip:SetPlayerBuff(i);

      buffname = EzDTooltipTextLeft1:GetText();
      bufftext = GetPlayerBuffTexture(i);

      if (bufftext ~= nil) then
         debugmsg = ("(" .. i .. ") [" ..buffname.. "]  "..bufftext);
         DEFAULT_CHAT_FRAME:AddMessage(debugmsg, 0.0, 1.0, 0.0);
      end

	end
end

--------------------------------------------------------------
-- Look for Mount Buff Icon and cancel it (Alternate Function)
--------------------------------------------------------------
function EzD_getdown()

   EzDismount_getdown(1);

end


------------------------
-- Cancel Buff by Name
------------------------
function EzD_drop(dropbuff)

   local buffname;

   if ( dropbuff ~= nil ) then

      EzDTooltip:SetOwner(UIParent, "ANCHOR_NONE");

      for i=0,15,1 do

         EzDTooltip:ClearLines();
         EzDTooltip:SetPlayerBuff(i);
         buffname = EzDTooltipTextLeft1:GetText();

         if (buffname ~= nil) then
            if string.find(string.lower(buffname), string.lower(dropbuff)) then
               CancelPlayerBuff(i);
               break;
            end
         end
      end

   end
end

------------------------
-- Check if Buff exists
------------------------
function EzD_buffexist(findbuff)

   local buffname;
   local result = false;

   if ( findbuff ~= nil ) then

      EzDTooltip:SetOwner(UIParent, "ANCHOR_NONE");

      for i=0,15,1 do

         EzDTooltip:ClearLines();
         EzDTooltip:SetPlayerBuff(i);
         buffname = EzDTooltipTextLeft1:GetText();

         if (buffname ~= nil) then
            if string.find(string.lower(buffname), string.lower(findbuff)) then
               result = true;
               break;
            end
         end
      end
	end

	return result;

end


-----------------------------------------
-- Toggles the showing/hiding of the Menu
-----------------------------------------
function EzDismount_Toggle()

	if ( EzDismount_Menu:IsVisible() ) then
		EzDismount_Menu:Hide();
	else
		EzDismount_Menu:Show();
	end

end

--------------------
-- Refresh Screen
--------------------

function EzDismount_Refresh()

	EzDismount_Text_Status_VOFF:SetText("");
	EzDismount_Text_Status_VON:SetText("");
	EzDismount_Text_Shaman_VOFF:SetText("");
	EzDismount_Text_Shaman_VON:SetText("");
	EzDismount_Text_Druid_VOFF:SetText("");
	EzDismount_Text_Druid_VON:SetText("");
	EzDismount_Text_Moonkin_VOFF:SetText("");
	EzDismount_Text_Moonkin_VON:SetText("");
        EzDismount_Text_Shadowform_VOFF:SetText("");
	EzDismount_Text_Shadowform_VON:SetText("");
	EzDismount_Text_Stand_VOFF:SetText("");
	EzDismount_Text_Stand_VON:SetText("");
	EzDismount_Text_Auction_VOFF:SetText("");
	EzDismount_Text_Auction_VON:SetText("");

	-- Mounts
	EzDismount_Text_Status:SetText("Automatic dismounting is :");
	if ( EzDismount_Config[EzDPlayer]["Dismount"] == "OFF" ) then
		EzDismount_Text_Status_VOFF:SetText("[OFF]");
	end

	if (EzDismount_Config[EzDPlayer]["Dismount"] == "ON" ) then
		EzDismount_Text_Status_VON:SetText("[ON]");
	end

	if ( EzDismount_Config[EzDPlayer]["Dismount"] == "TAXI" ) then
		EzDismount_Text_Status_VON:SetText("[TAXI]");
	end

        -- Auctioneer Dismount
        EzDismount_Text_Auction:SetText("Automatic auctioneer dismount is :");
        if ( EzDismount_Config[EzDPlayer]["Auction"] == "OFF" ) then
		EzDismount_Text_Auction_VOFF:SetText("[OFF]");
        else
                EzDismount_Text_Auction_VON:SetText("[ON]");
	end

	-- Auto-Stand
	EzDismount_Text_Stand:SetText("Automatic stand from sit is :");
	if ( EzDismount_Config[EzDPlayer]["Stand"] == "OFF" ) then
		EzDismount_Text_Stand_VOFF:SetText("[OFF]");
        else
                EzDismount_Text_Stand_VON:SetText("[ON]");
	end

	-- Shaman
	EzDismount_Text_Shaman:SetText("Auto-cancel of Ghostwolf is :");
	if ( EzDismount_Config[EzDPlayer]["Wolf"] == "OFF" ) then
		EzDismount_Text_Shaman_VOFF:SetText("[OFF]");
	else
		EzDismount_Text_Shaman_VON:SetText("[ON]");
	end

	-- Druid
	EzDismount_Text_Druid:SetText("Auto-cancel of shapeshifts is :");
	if ( EzDismount_Config[EzDPlayer]["Druid"] == "OFF" ) then
		EzDismount_Text_Druid_VOFF:SetText("[OFF]");
	else
		EzDismount_Text_Druid_VON:SetText("[ON]");
	end

	-- Moonkin
	EzDismount_Text_Moonkin:SetText("Auto-cancel of Moonkin form :");
	if ( EzDismount_Config[EzDPlayer]["Moonkin"] == "OFF" ) then
		EzDismount_Text_Moonkin_VOFF:SetText("[OFF]");
	else
		EzDismount_Text_Moonkin_VON:SetText("[ON]");
	end

	-- Shadowform
	EzDismount_Text_Shadowform:SetText("Auto-cancel of Shadowform :");
	if ( EzDismount_Config[EzDPlayer]["Shadowform"] == "OFF" ) then
		EzDismount_Text_Shadowform_VOFF:SetText("[OFF]");
	else
		EzDismount_Text_Shadowform_VON:SetText("[ON]");
	end

end

--------------------------
-- Show slash command help
--------------------------
function EzDismount_help()

   DEFAULT_CHAT_FRAME:AddMessage("## " .. EzDismount_fullver .. " ##", 0.0, 1.0, 0.0);

   for index=1, table.getn(EzDHelp.List), 1 do
      DEFAULT_CHAT_FRAME:AddMessage(EzDHelp.List[index], 0.0, 1.0, 0.0);
   end;
end
