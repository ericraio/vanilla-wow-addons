--[[

TargetOfTarget: Keeps Target of Target shown below TargetFrame

Copyright (c) 2005 Itchyban of Veeshan

Version 2.1 Beta 1

$Header: /usr/local/cvsroot/WoW/Interface/AddOns/TargetOfTarget/TargetOfTarget.lua,v 1.122 2005/05/30 17:43:33 jeff Exp $


]]


---
--- Where should the dead/ghost/corpse be done?
---

-------------------------
--- Versioning params ---
-------------------------

---
--- WARNING
---
--- Checking this into CVS or RCS without -ko can screw this up for now
---
--- (If you don't know what CVS or RCS are, you can ignore that)
---

local version_table_data = {};

version_table_data.object = "1.0";
version_table_data.apps = {};
version_table_data.apps.TargetOfTarget = {};
version_table_data.apps.TargetOfTarget.params = "2.0";
version_table_data.apps.TargetOfTarget.lua_CVS = "$Revision: 1.122 $";  
version_table_data.apps.TargetOfTarget.XML_CVS = "";  



-------------------------------------------------------
--- Check for existing globals before declaring any ---
-------------------------------------------------------

local globals_to_check = {
"HoTT_Aggro_Callback",
"HoTT_Debug",
"HoTT_Display",
"HoTT_Display_Bar",
"HoTT_Display_Bar_OnEvent",
"HoTT_Display_Bar_OnUpdate",
"HoTT_Display_Bar_OnValueChanged",
"HoTT_Display_NameArea",
"HoTT_Display_NameArea_Text",
"HoTT_Display_OnClick",
"HoTT_Display_OnEvent",
"HoTT_Display_OnUpdate",
"HoTT_InputBoxTemplate",
"HoTT_InputBoxTemplateLeft",
"HoTT_InputBoxTemplateMiddle",
"HoTT_InputBoxTemplateRight",
"HoTT_MainFrame",
"HoTT_MainFrame_OnEvent",
"HoTT_MainFrame_OnLoad",
"HoTT_Params",
"HoTT_Params_FourDigitInputBox",
"HoTT_Params_Frame",
"HoTT_Params_Frame_AggroMessage_Changed",
"HoTT_Params_Frame_AggroMessage_EditBox",
"HoTT_Params_Frame_AggroText",
"HoTT_Params_Frame_AlertsText",
"HoTT_Params_Frame_Alignment_Changed",
"HoTT_Params_Frame_BuffsText",
"HoTT_Params_Frame_BuffsText0",
"HoTT_Params_Frame_BuffsText1",
"HoTT_Params_Frame_BuffsText2",
"HoTT_Params_Frame_ButtonCenter",
"HoTT_Params_Frame_ButtonCenterText",
"HoTT_Params_Frame_ButtonLeft",
"HoTT_Params_Frame_ButtonLeftText",
"HoTT_Params_Frame_ButtonRight",
"HoTT_Params_Frame_ButtonRightText",
"HoTT_Params_Frame_Cancel",
"HoTT_Params_Frame_CheckRefocus",
"HoTT_Params_Frame_ClearFocus",
"HoTT_Params_Frame_Defaults",
"HoTT_Params_Frame_DisplayInsetsText",
"HoTT_Params_Frame_DisplayLeft_Changed",
"HoTT_Params_Frame_DisplayLeft_EditBox",
"HoTT_Params_Frame_DisplayLeft_EditBoxLeft",
"HoTT_Params_Frame_DisplayLeft_EditBoxMiddle",
"HoTT_Params_Frame_DisplayLeft_EditBoxRight",
"HoTT_Params_Frame_DisplayRight_Changed",
"HoTT_Params_Frame_DisplayRight_EditBox",
"HoTT_Params_Frame_DisplayRight_EditBoxLeft",
"HoTT_Params_Frame_DisplayRight_EditBoxMiddle",
"HoTT_Params_Frame_DisplayRight_EditBoxRight",
"HoTT_Params_Frame_Drop0_Changed",
"HoTT_Params_Frame_Drop0_EditBox",
"HoTT_Params_Frame_Drop0_EditBoxLeft",
"HoTT_Params_Frame_Drop0_EditBoxMiddle",
"HoTT_Params_Frame_Drop0_EditBoxRight",
"HoTT_Params_Frame_Drop1_Changed",
"HoTT_Params_Frame_Drop1_EditBox",
"HoTT_Params_Frame_Drop1_EditBoxLeft",
"HoTT_Params_Frame_Drop1_EditBoxMiddle",
"HoTT_Params_Frame_Drop1_EditBoxRight",
"HoTT_Params_Frame_Drop2_Changed",
"HoTT_Params_Frame_Drop2_EditBox",
"HoTT_Params_Frame_Drop2_EditBoxLeft",
"HoTT_Params_Frame_Drop2_EditBoxMiddle",
"HoTT_Params_Frame_Drop2_EditBoxRight",
"HoTT_Params_Frame_DropsText",
"HoTT_Params_Frame_LoadValues",
"HoTT_Params_Frame_ObjectName_Changed",
"HoTT_Params_Frame_ObjectName_EditBox",
"HoTT_Params_Frame_ObjectName_EditBoxLeft",
"HoTT_Params_Frame_ObjectName_EditBoxMiddle",
"HoTT_Params_Frame_ObjectName_EditBoxRight",
"HoTT_Params_Frame_ObjectText",
"HoTT_Params_Frame_Okay",
"HoTT_Params_Frame_OnCancel",
"HoTT_Params_Frame_OnDefaults",
"HoTT_Params_Frame_OnOkay",
"HoTT_Params_Frame_PositioningText",
"HoTT_Params_Frame_Scale_Changed",
"HoTT_Params_Frame_Scale_EditBox",
"HoTT_Params_Frame_Scale_EditBoxLeft",
"HoTT_Params_Frame_Scale_EditBoxMiddle",
"HoTT_Params_Frame_Scale_EditBoxRight",
"HoTT_Params_Frame_ShowAlignmentFrame",
"HoTT_Params_Frame_Title",
"HoTT_Params_Frame_Title_Text",
"HoTT_Params_Frame_TextInsetsText",
"HoTT_Params_Frame_TextLeft_Changed",
"HoTT_Params_Frame_TextLeft_EditBox",
"HoTT_Params_Frame_TextLeft_EditBoxLeft",
"HoTT_Params_Frame_TextLeft_EditBoxMiddle",
"HoTT_Params_Frame_TextLeft_EditBoxRight",
"HoTT_Params_Frame_TextRight_Changed",
"HoTT_Params_Frame_TextRight_EditBox",
"HoTT_Params_Frame_TextRight_EditBoxLeft",
"HoTT_Params_Frame_TextRight_EditBoxMiddle",
"HoTT_Params_Frame_TextRight_EditBoxRight",
"HoTT_Set_XML_CVS",
"HoTT_Settings",
"HoTT_Settings_Unparsed",
"SLASH_TARGETOFTARGET_TOT1",
"SLASH_TARGETOFTARGET_TOT2",
"SLASH_TARGETOFTARGET_TOTOFF1",
"SLASH_TARGETOFTARGET_TOTON1",
"SlashCmdList[\"TARGETOFTARGET_TOT\"]",
"SlashCmdList[\"TARGETOFTARGET_TOTON\"]",
"SlashCmdList[\"TARGETOFTARGET_TOTOFF\"]",
}

local slash_commands_to_check = {
"/tot",
"/toton",
"/totoff",
"/hott"
}

local all_checked_globals = {};

local k,v
   
for k,v in pairs (globals_to_check) do
   table.insert(all_checked_globals, v);
end

for k,v in pairs (slash_commands_to_check) do
   table.insert(all_checked_globals, v);
end





local global_check_failures = nil;

for k,v in pairs(globals_to_check) do
   
   if ( type(getglobal(v)) ~= "nil" ) then
      if ( type(global_check_failures) == "nil" ) then
	 global_check_failures = {};
      end
      table.insert(global_check_failures, v);
   end
   
end



---
--- NOTE: This is not quite right yet, as slash_commands_to_check 
---       somehow needs to be localized in the process
---


---
--- check_localized_slash_commands
---


local function check_localized_slash_commands ()

   for k,v in pairs(slash_commands_to_check) do
      
      local scl_key, scl_value;
      
      for scl_key, scl_value in pairs(SlashCmdList) do
	 
	 
	 local idx = 1;
	 local slash_var = "SLASH_"..scl_key..idx;
	 local slash_cmd_string = getglobal(slash_var);
	 
	 repeat
	    if ( slash_cmd_string == v ) then
	       if ( type(global_check_failures) == "nil" ) then
		  global_check_failures = {};
	       end
	       table.insert(global_check_failures, 
			    v .. "( == " .. slash_cmd_string .. " )");
	    end
	    idx = idx+1;
	    slash_var = "SLASH_"..scl_key..idx;
	    slash_cmd_string = getglobal(slash_var);
	    
	 until ( not slash_cmd_string )
	 
      end
      
   end

end


---
--- "Safe" to declare globals now 
---  at least we know what we are going to clobber!
---




---
--- Stray Global, here for clarity
---
--- HoTT_Set_XML_CVS
---

--- Called <OnLoad> in the XML file
--- Should probably make sure that it "flows through" properly 
--- before I start relying on it for anything

function HoTT_Set_XML_CVS (version_string)
   version_table_data.apps.TargetOfTarget.XML_CVS = version_string;

   return version_table_data.apps.TargetOfTarget.XML_CVS;
end


---
--- HoTT_Patch_Warning
---

local function HoTT_Patch_Warning ()

   local patch_not_ok = (type(UnitIsVisible) ~= "function");

   if ( patch_not_ok  ) then
      message("This version requires patch 1.5.0, not present on this server. Enjoy this version on Test, but run the latest 1.x version here for now.");
   end

   return patch_not_ok;
end


---------------------------
--- Localizable Strings ---
---------------------------

local no_target_string = "";
local stunned_string = "(stunned)";
local undetermined_string = "(undetermined)";

local aggro_message = "--- AGGRO --- AGGRO ---";

local ras_format = "Duplicate UnitID for %s; %s, %s";

local toton_string = "/toton";
local totoff_string = "/totoff";

local loaded_string = "Itchy's TargetOfTarget AddOn loaded";
local loaded_variables_string = "TargetOfTarget SavedVariables settings restored"

local shift_at_load_string = "TargetOfTarget [Shift] at load";
local invalid_settings_string = "TargetOfTarget invalid saved settings. Copied to HoTT_Settings_Unparsed";

local on_string = "TargetOfTarget is now " .. GREEN_FONT_COLOR_CODE .. "ON";
local off_string = "TargetOfTarget is now OFF";

local saved_format = "TargetOfTarget saved settings: %s";
local save_failed_format = "TargetOfTarget no settings to save for: %s";

local restored_defaults = "TargetOfTarget restored default settings";
local restored_format = "TargetOfTarget restored settings: %s";
local restore_failed_format = "TargetOfTarget no settings to restore for: %s";

local help_message = [[
Itchy's ToT

/tot on -- enable ToT (or /toton)
/tot off -- disable ToT (or /totoff)

/tot params -- brings up dialog to edit aggro message and position display.
/tot version -- displays file versions. Please report these with any bugs or suggestions.]];

local help_ui = "/tot ui is obsolete. Use /tot params";

local string_global_check_failed = "TargetOfTarget found possible " ..
	 RED_FONT_COLOR_CODE .. "global variable conflict" .. 
	 FONT_COLOR_CODE_CLOSE .. " on loading. For details, /tot globals";

local string_global_list = "TargetOfTarget global variable check list is in TargetOfTarget.lua, if you are curious."

local string_global_check_explanation = "TargetOfTarget checks that the global variables it uses are not already in use when it loads. If they are already present, it is likely that another AddOn will conflict with TargetOfTarget, or you have two versions loading. The following variables were found in conflict:";
local string_global_variable_check_trailer = "If there are a lot of variables listed, it is likely that you have another copy of TargetOfTarget loading. Please check your AddOns."

local string_assert_set_exists_fmt = "Change settings to %s, no set returned";
local string_assert_no_player = "Player name unexpectedly missing";
local string_assert_no_realm = "Realm name unexpectedly missing";

local fmt_no_such_object = "%s does not exist in this UI. Use '/tot ui default' to restore defaults, or '/tot ui' to see other options";

local string_no_ui_description = "(no description given)"

local string_cleared_ui = "Cleared ToT UI parameters";
local string_default_ui_copied = "Copied default ToT UI parameters to your active set";

local fmt_copied_ui = "Copied ToT UI parameters to your active set: %s -- %s";

local fmt_no_such_ui = "No such ToT UI parameters, %s,  available. For help, /tot ui";

local string_help_cmd = "help";
local string_on_cmd = "on";
local string_off_cmd = "off";
local string_ui_cmd = "ui";
local string_version_cmd = "version";
local string_globals_cmd = "globals";
local string_params_cmd = "params"

local string_unrecognized_cmd_help = "Unrecognized command -- try /tot help";

local string_slash_tot = "/tot"
local string_slash_hott = "/hott"

local ellipsis = "...";    -- Used as suffix in shortened names

local fmt_ro_access = "No write access to %s permitted.";
local fmt_not_a_table = "%s not a table, passed as %s";

local fmt_too_narrow = "Too narrow a window. %s set to previous value.";
local fmt_no_obj_edit = "%s does not exist in this UI. Previous value restored.";



-----------------------------------------
--- Parameter list and default values ---
-----------------------------------------


--- Application defaults
---
--- DO NOT CHANGE THESE HERE
---
--- Use HoTT_Params handle to keep overrides in SavedVariables
---

local default_params = {};

default_params.bar_unreliable_time = 0.500;    -- time after which bar 
                                               -- is marked "unreliable"

default_params.poll_timer_period = 0.400;      -- check ToT/health this often
                                               -- (Only if not getting events)

default_params.aggro_message = aggro_message;  -- or false or blank to disable

default_params.ui = {};

default_params.ui.display = {};

default_params.ui.display.relative_to = "TargetFrameHealthBar";

default_params.ui.display.scale = 1.0;

default_params.ui.display.inset = {};

default_params.ui.display.inset.left = -5;
default_params.ui.display.inset.right = -3;


default_params.ui.display.drops = {};

default_params.ui.display.drops[0] = 12;
default_params.ui.display.drops[1] = 36;
default_params.ui.display.drops[2] = 58;

default_params.ui.display.tot_name = {};

default_params.ui.display.tot_name.min_width = 20;    -- prevent dynamic
                                                      -- adjustment too small

default_params.ui.display.tot_name.alignment = "CENTER";

default_params.ui.display.tot_name.inset = {};

default_params.ui.display.tot_name.inset.left = 6;    -- padding for trimming
default_params.ui.display.tot_name.inset.right = 6;   -- of strings to fit



--------------------------------
--- Locking tables read-only ---
--------------------------------

---
--- format_table_key
---

local function format_table_key (table_string, k)
   
   local table_key;

   if ( type(k) == "string" ) then
      table_key = string.format("%s.%s", table_string, k);
   else
      table_key = string.format("%s[%s]", table_string, tostring(k));
   end

   return table_key;
end




---
--- wrap_readonly
---

local function wrap_readonly (table1, table_name)

   if ( type(table_name) ~= "string" ) then
      table_name = "";
   end
   
   local wrapper = {};
   local ro_mt = {};
   ro_mt.__index = table1;
   ro_mt.__newindex = function (t,k,v)
			 error(string.format(fmt_ro_access, 
					     format_table_key(table_name, k)),
			       2);
		       end;

   setmetatable(wrapper, ro_mt);
   
   return wrapper;
end



---
--- wrap_readonly_recursively
---

local function wrap_readonly_recursively (table1, table_name, visited)

   local k,v;
   local next_table_name;
   local wrapper;

   if ( type(table_name) ~= "string" ) then
      table_name = "";
   end
   
   if ( not visited ) then
      visited = {};
      visited[table1] = true;
   end

   for k,v in pairs(table1) do
      if ( ( type(v) == "table" ) and
	   ( not visited[v] )         ) then
	 next_table_name = format_table_key(table_name, k);
	 table1[k] = wrap_readonly_recursively (v, next_table_name, visited)
      end
   end
   
   wrapper = wrap_readonly(table1, table_name);

   return wrapper;
end



---
--- Lock default_params
---

default_params = wrap_readonly_recursively(default_params, "default_params");

					     



-----------------------------
--- Local state variables ---
-----------------------------

local hott_is_on;                -- master

local t_target_info = {};        -- the "target" for which ToT applies
local tot_target_info = {};      -- the ToT itself

local player_name;
local realm_name;

local last_tot;                  -- name of the last ToT for "AGGRO" messaging
local this_tot;

local roster = {};               -- reverse lookup for UnitIDs
local roster_assertion_seen;     -- so as to only show an error once

local time_since_bar_update = 0;     -- internal for bar coloring
local bar_set_unreliable = nil;      -- internal for bar coloring

local variables_loaded = false;        -- Event has fired
local saved_variables_loaded = false;  -- Event responded to completely

local this_frame_tot;            -- internals for detecting most target changes
local last_frame_tot;

local poll_timer = 0;            -- handles the cases events don't cover
local poll_timer_fired = false;

local placed_names = {};         -- cache for name strings that fit

local refocus_object = nil;      -- Params frame object that needs focus





------------------------
--- Local parameters ---
------------------------



--- UnitIDs that generate UNIT_HEALTH events (health bar reliability check)

local units_getting_events = {};

units_getting_events.player = true;
units_getting_events.pet = true;

for idx = 1, 4 do
   units_getting_events[format("party%i",idx)] = true;
   units_getting_events[format("partypet%i",idx)] = true;
end

for idx = 1, 40 do
   units_getting_events[format("raid%i",idx)] = true;
   units_getting_events[format("raidpet%i",idx)] = true;
end



--- Colors for bars and for text

local colors = {};

colors.bar = {};

colors.bar.unreliable = { r = 1.00, g = 1.00, b = 1.00 };

colors.name = {};

colors.name.dead    = { r = 0.50, g = 0.50, b = 0.50 };

colors.name.normal        = { r = NORMAL_FONT_COLOR.r,
                              g = NORMAL_FONT_COLOR.g,
                              b = NORMAL_FONT_COLOR.b };

colors.name.unreliable    = { r = 1.00, g = 1.00, b = 1.00 };

colors.name.unreliable_no_unit    = { r = 0.83, g = 0.83, b = 0.83 };

colors.name.undetermined  = { r = NORMAL_FONT_COLOR.r,
                              g = NORMAL_FONT_COLOR.g,
                              b = NORMAL_FONT_COLOR.b };




----------------------------------------------------------------
--- Globals for pre-release testing/tuning without reloading ---
----------------------------------------------------------------

HoTT_Debug = {};

HoTT_Debug.enabled = false;

HoTT_Debug.pn = placed_names;

HoTT_Debug.pnt = {};


---
--- dprint
---

local function dprint (message)

   if ( HoTT_Debug.enabled ) then

      if ( type(print) == "function" ) then
	 print(message);
      else
	 DEFAULT_CHAT_FRAME:AddMessage(message)
      end

   end

end




---
--- tprint
---

local function tprint (message, relative_time)

   if ( HoTT_Debug.enabled ) then
   
      if ( not relative_time ) then
	 relative_time = 0;
      end
      
      dprint(format("%7.3f %s",
		    GetTime() - relative_time,
		    tostring(message)));
      
   end

end




-------------------------------
--- Stubbed local functions ---
-------------------------------


local refresh_ui_positions;
local position_display;

local update_tot;
local update_tot_health;

local reset_poll_timer;

local launch_params_browser;



--------------------
--- Other locals ---
--------------------

--local current_params;




---------------------
--- Table utility ---
---------------------

---
--- clear_table
---

local function clear_table (table1)

   local k,v;

   for k,v in pairs(table1) do
      table1[k] = nil;
   end

   return table;
end



---
--- copy_table_recursively
---

--- only used by add_settings_object_versioning()
--- will not copy non-iteratable tables

local function copy_table_recursively (table1, table2, missing_keys_only)

   ---
   --- NOTE: Is this kind of potential self-copy "safe" in Lua?
   ---       Would be if iterator is static -- CHECK THIS!
   ---       Also applies to copy_table()
   ---
   
   ---
   --- NOTE: Lua logic means that a nil entry in the destination
   ---       is always overwritten, even with missing_keys_only true
   ---

   ---
   --- NOTE: Should really not copy field if dest == source 
   ---       This should prevent infinite recursion as well
   ---

   local k,v, copy_this

   for k,v in pairs (table1) do

      copy_this = ( table2[k] ~= v ) and
	          ( ( not missing_keys_only )                 or
		    ( ( table2[k] == nil ) and ( v ~= nil ) )    );

      if ( type(v) == "table" ) then
	 if ( copy_this ) then
	    table2[k] = {};
	 end
	 copy_table_recursively(v, table2[k], missing_keys_only);

      else
	 if ( copy_this ) then
	    table2[k] = v;
	 end
      end

   end

   return table2;
end



---
--- copy_table_structure
---

local function copy_table_structure (table1, table2, visited_nodes)

   local k,v

   if ( not visited_nodes ) then 
      visited_nodes = {};
      visited_nodes[tostring(table1)] = true;
   end

   for k,v in pairs (table1) do

      if ( ( type(v) == "table" )                and
	  ( not ( visited_nodes[tostring(v)] ) )     ) then

	 if ( not ( type(table2[k]) == "table" ) ) then
	    table2[k] = {};
	 end

	 visited_nodes[tostring(v)] = true;
	 copy_table_structure(v, table2[k], visited_nodes);

      end

   end

   return table2;
end



----------------------------
--- Handling params sets ---
----------------------------

local params = {};          -- will point to the current params object
HoTT_Params = {};           -- as well as a global handle to it

local scratch_params = {};  -- need something before HoTT_Settings is ready



---
--- set_deferral
---

local function set_deferral (child, parent, child_name, parent_name)

   if ( type(child_name) ~= "string" ) then
      child_name = "";
   end

   if ( type(parent_name) ~= "string" ) then
      parent_name = "";
   end

   if ( type(child) ~= "table" ) then
      error(string.format(fmt_not_a_table, child_name, "child"));
   end

   if ( type(parent) ~= "table" ) then
      error(string.format(fmt_not_a_table, parent_name, "parent"));
   end

   local mt_defer = {};

   mt_defer.__index = function (t, k)

			 local retval;
			 local pv = parent[k];
			 
			 if ( type(pv) == "table" ) then
			    t[k] = {};
			    set_deferral(t[k], parent[k], 
					 child_name, parent_name);
			    retval = t[k];
			    
			 else
			    retval = pv;
			    
			 end
			 
			 return retval;
		      end;
   
--    mt_defer.__newindex = function (t, k, v)
--			    
-- 			    local pv = parent[k];
--			    
-- 			    if ( pv ) then
-- 			       rawset(t, k, v);  -- need rawset!
--			       
-- 			    else
-- 			       error(string.format(fmt_no_such_field,
-- 				          format_table_key(parent_name, k)),
-- 				     2);
-- 			    end
--			    
-- 			 end;

   
   setmetatable(child, mt_defer);
   
   return child;
end



---
--- set_deferral_recursively
---

local function set_deferral_recursively (child, parent, 
				   child_name, parent_name, visited)


   local k,v;
   local next_child_name;
   local next_parent_name;

   if ( type(child_name) ~= "string" ) then
      child_name = "";
   end

   if ( type(parent_name) ~= "string" ) then
      parent_name = "";
   end
   
   if ( type(child) ~= "table" ) then
      error(string.format(fmt_not_a_table, child_name, "child"));
   end

   if ( type(parent) ~= "table" ) then
      error(string.format(fmt_not_a_table, parent_name, "parent"));
   end

   if ( not visited ) then
      visited = {};
      visited[child] = true;
   end


   for k,v in pairs(child) do
      if ( ( type(v) == "table" ) and
	   ( not visited[v] )         ) then

	 if ( type(parent[k]) ~= "table" ) then

	    ---
	    --- WARNING: This wipes masking data
	    ---

	    child[k] = nil;

	 else
	    next_child_name = format_table_key(child_name, k);
	    next_parent_name = format_table_key(parent_name, k);

	    set_deferral_recursively (v, parent[k],
				      next_child_name, 
				      next_parent_name,
				      visited);

	 end

      end

   end
   
   set_deferral(child, parent, child_name, parent_name);

   return child;
end



---
--- init_preload_params
---

local function init_preload_params ()

   set_deferral_recursively(scratch_params, default_params, 
			    "scratch_params", "default_params");
   
   params = scratch_params;
   HoTT_Params = scratch_params;

   return params;
end

--- and init_preload_params for safety!

init_preload_params();




---
--- get_settings_set
---

local function get_settings_set (set_name)

   return HoTT_Settings._sets[set_name];
end



---
--- change_settings
---

local function change_settings (set_name)

   -- Assumes set_name exists and is valid

   local new_settings_set = get_settings_set(set_name);

   assert(new_settings_set, format(string_assert_set_exists_fmt, 
				   tostring(set_name)));

   set_deferral_recursively(new_settings_set, default_params,
			    "HoTT_Params", "default_params");

--   params.hott_was_on = hott_is_on; -- this borks on-load behavior?
   
   params = new_settings_set;
   HoTT_Params = new_settings_set;

   refresh_ui_positions();
   
   return params;
end



---
--- restore_defaults
---

local function restore_defaults ()

   clear_table(params);

   refresh_ui_positions();

   -- DEFAULT_CHAT_FRAME:AddMessage(restored_defaults);
   
   return params;
end







-----------------------------------------------
--- Parameters sets and persistent settings ---
-----------------------------------------------


---
--- NOTE: I should split these out some day
---
--- outside variables refered to:
---
---    player_name
---    realm_name
---    HoTT_Settings
---
---    various strings
---



---
--- The following methods assume that the object is initalized
--- and is self-consistent
---



---
--- get_default_settings_set_name
---

local function get_default_settings_set_name ()

   --- DO NOT LOCALIZE THIS FORMAT STRING
   --- Doing so will invalidate settings if the player changes locale

   return format("%s of %s", player_name, realm_name);
end



---
--- settings_set_exists
---

local function settings_set_exists (set_name)

   return HoTT_Settings._sets[set_name];
end



---
--- init_settings_set
---

local function init_settings_set (set_name)

   HoTT_Settings._sets[set_name] = {};

   return HoTT_Settings._sets[set_name];
end



---
--- get_active_settings_set_name
---

local function get_active_settings_set_name ()

   return HoTT_Settings._players[realm_name][player_name].active_set;
end



---
--- change_active_settings_set
---

local function change_active_settings_set (set_name)

   HoTT_Settings._players[realm_name][player_name].active_set = set_name;

   return HoTT_Settings._sets[set_name];
end



---
--- get_active_settings_set
---

local function get_active_settings_set ()

   return get_settings_set(get_active_settings_set_name());
end



---
--- add_settings_object_versioning
---

local function add_settings_object_versioning (settings_object)

   if ( type(settings_object._version) == "table" ) then
      clear_table(settings_object._version)
   else
      settings_object._version = {};
   end

   copy_table_recursively(version_table_data, settings_object._version);

   return settings_object;
end



---
--- NOTE: These will need serious re-working
---


---
--- valid_settings_object
---

local function valid_settings_object (settings_object)

   return ( type(settings_object) == "table")           and 
          ( type(settings_object._version) == "table" ) and
	  ( string.sub(settings_object._version.object, 1, 2) == "1." )
	  ;
end



---
--- repopulate_settings_object
---

local function repopulate_settings_object (settings_object)

   -- nothing to do right now
   return settings_object;
end



---                             ########################################
--- update_settings_object      ##### THIS ONE NEEDS TO BE CHANGED #####
---                             ########################################

local function update_settings_object (settings_object)

   -- nothing to do right now, only one valid version
   return settings_object;
end




---
--- load_saved_settings
---

local function load_saved_settings ()


   ---
   --- A mish-mosh of validation, object creation, initialization
   --- error reporting, and some application-specific tie-ins
   ---
   --- Will need to be cleaned up a lot to split out
   ---

   ---
   --- Should really use getglobal(), but can't find "setglobal()"
   ---


   local player_ptr;
   local set_ptr;

   local default_set_name;
   local active_set_name;


   if ( not valid_settings_object(HoTT_Settings) ) then

      if (HoTT_Settings) then

	 HoTT_Settings_Unparsed = HoTT_Settings;

	 DEFAULT_CHAT_FRAME:AddMessage(invalid_settings_string);

      end


      -- Initialize from scratch
      dprint("initializing object");

      HoTT_Settings = {};

      add_settings_object_versioning(HoTT_Settings);

      HoTT_Settings._players = {};
      HoTT_Settings._sets = {};

   end


   -- Add anything that is lost in the write/read cycle
   -- Ok, we have a valid, but possibly outdated settings object
   dprint("repopulate and update");

   repopulate_settings_object(HoTT_Settings);
   update_settings_object(HoTT_Settings);


   -- Now its good to go, though possibly empty


   assert(player_name, string_assert_no_player);
   assert(realm_name, string_assert_no_realm);


   -- Make sure this player's default set exists first


   default_set_name = get_default_settings_set_name();
   dprint("default_set_name: "..tostring(default_set_name));
   if ( not settings_set_exists(default_set_name) ) then
      dprint("initializing default set for "..tostring(default_set_name));
      init_settings_set(default_set_name);
   end


   -- Then make sure the player exists


   if ( not HoTT_Settings._players[realm_name] ) then
      dprint("._players");
      HoTT_Settings._players[realm_name] = {};
   end

   if ( not HoTT_Settings._players[realm_name][player_name] ) then
      dprint("._players."..tostring(realm_name));
      HoTT_Settings._players[realm_name][player_name] = {};
   end

   if ( not HoTT_Settings._players[realm_name][player_name] ) then
      dprint("._players."..tostring(realm_name)..tostring(player_name));
      HoTT_Settings._players[realm_name][player_name] = {};
   end


   -- and tie them to their default set if they don't have one already

   
   active_set_name = get_active_settings_set_name();

   if ( not active_set_name ) then
      dprint("change to default");
      change_active_settings_set(default_set_name);
   end


   -- Realm, player, and default set should be present now
   -- Check that their active set is a good one


   active_set_name = get_active_settings_set_name();



   if ( not settings_set_exists(active_set_name) ) then

      -- Go to their default set

      DEFAULT_CHAT_FRAME:AddMessage(format(restore_failed_format, 
					   active_set_name));

      change_active_settings_set(default_set_name);

      DEFAULT_CHAT_FRAME:AddMessage(format(restored_format,
					   active_set_name));

   end

   -- which really exists
   dprint("Change to: "..tostring(active_set_name));
   return change_settings(active_set_name);
end



-----------------------
-----------------------
--- LOCAL FUNCTIONS ---
-----------------------
-----------------------


--------------------------
--- target_info tables ---
--------------------------

---
--- clear_target_info
---

local function clear_target_info (target_info)

   clear_table(target_info);

   return target_info;
end



---
--- copy_target_info
---

local function copy_target_info (target_info1, target_info2)

   local k,v;

   clear_target_info(target_info2);
   for k,v in pairs(target_info1) do
      target_info2[k] = v;
   end

   return target_info2;
end



---
--- exact_target_info
---

local function exact_target_info (target_info1, target_info2)

   return ( target_info1.name == target_info2.name )                 and
          ( target_info1.level == target_info2.level )               and
          ( target_info1.sex == target_info2.sex )                   and
          ( target_info1.player == target_info2.player )             and
          ( target_info1.enemy == target_info2.enemy )               and
          ( target_info1.canattack == target_info2.canattack )       and
          ( target_info1.canattackme == target_info2.canattackme )   and
          ( target_info1.friend == target_info2.friend )             and
          ( target_info1.shapeshifted == target_info2.shapeshifted );
    end



---
--- clear_t
---

local function clear_t ()

   clear_target_info(t_target_info);

   return t_target_info;
end



---
--- clear_tot
---

local function clear_tot ()

   last_tot = tot_target_info.name;

   clear_target_info(tot_target_info);

   this_tot = nil;

   return tot_target_info;
end



---
--- target_to_t
---

local function target_to_t ()

   if ( UnitExists("target") ) then 

      t_target_info.name = UnitName("target");
      t_target_info.level = UnitLevel("target");
      t_target_info.sex = UnitSex("target");
      t_target_info.player = UnitIsPlayer("target");
      t_target_info.enemy = UnitIsEnemy("target", "player");
      t_target_info.canattack = UnitCanAttack("player", "target");
      t_target_info.canattackme = UnitCanAttack("target", "player");
      t_target_info.friend = UnitIsFriend("target", "player");
      t_target_info.shapeshifted = nil; -- for later expansion

   else
      clear_t();

   end

   return t_target_info;
end



---
--- targettarget_to_tot
---

local function targettarget_to_tot ()

   last_tot = tot_target_info.name;
      
   if ( UnitExists("targettarget") ) then 
      
      tot_target_info.name = UnitName("targettarget");
      tot_target_info.level = UnitLevel("targettarget");
      tot_target_info.sex = UnitSex("targettarget");
      tot_target_info.player = UnitIsPlayer("targettarget");
      tot_target_info.enemy = UnitIsEnemy("targettarget", "player");
      tot_target_info.canattack = UnitCanAttack("player", "targettarget");
      tot_target_info.canattackme = UnitCanAttack("targettarget", "player");
      tot_target_info.friend = UnitIsFriend("targettarget", "player");
      tot_target_info.shapeshifted = nil; -- for later expansion

   else
      clear_tot();

   end

   this_tot = tot_target_info.name;

   return tot_target_info;
end



---
--- self_to_tot
---

local function self_to_tot ()

   -- Yep, this could be simpler, but leave it be for clarity
   -- It shouldn't be called except on target change to self 
   -- and then when the idle check times out

   last_tot = tot_target_info.name;
      
   if ( UnitExists("player") ) then 
      
      tot_target_info.name = UnitName("player");
      tot_target_info.level = UnitLevel("player");
      tot_target_info.sex = UnitSex("player");
      tot_target_info.player = UnitIsPlayer("player");
      tot_target_info.enemy = UnitIsEnemy("player", "player");
      tot_target_info.canattack = UnitCanAttack("player", "player");
      tot_target_info.canattackme = UnitCanAttack("player", "player");
      tot_target_info.friend = UnitIsFriend("player", "player");
      tot_target_info.shapeshifted = nil; -- for later expansion

   else
      clear_tot();

   end

   this_tot = tot_target_info.name;

   return tot_target_info;
end



---
--- new_target_appears_same_as_before
---

local function new_target_appears_same_as_before ()

   local retval = UnitExists("target");

   if ( retval ) then

      local target_sex = UnitSex("target");

      if ( ( UnitName("target") ~= t_target_info.name )   or
	  ( UnitLevel("target") ~= t_target_info.level )    ) then
	 retval = false;
	 
      elseif ( target_sex == t_target_info.sex ) then
	 retval = true; 
	 
	 -- well, except for shapeshifted mobs, 
	 -- which we very poorly handle with
	 
      elseif ( (target_sex == 2) or (t_target_info.sex == 2) ) then
	 retval = true;
	 
      else
	 retval = false;
	 
      end

   end

   return retval;
end



------------------------------------
--- Maintain a roster of UnitIDs ---
------------------------------------

---
--- insert_possible_unit
---

local function insert_possible_unit (unit, type)

   local retval = true;

   local name = UnitName(unit);
   local existing_unit;

   if ( name and (name ~= UNKNOWNOBJECT) and (name ~= UKNOWNBEING) ) then 

      existing_unit = roster[name];

      if ( existing_unit and 
	  ( string.sub(existing_unit, 1, string.len(type)) == type ) ) then
	 assert(roster_assertion_seen, 
		format(ras_format,
		       name, existing_unit, unit));
	 roster_assertion_seen = true;
	 retval = nil;
      else
	 roster[name] = unit;
	 retval = name;
      end
      
   end

   return retval;
end



---
--- update_roster
---

local function update_roster ()

   local retval = true;
   local this_ok;

   local unit, name, idx;
   local nraid = GetNumRaidMembers();
   local nparty = GetNumPartyMembers();

   clear_table(roster);

   if ( nraid > 1 ) then

      for idx = 1, 40 do  -- as they are by slot, and may not be sequential
	 unit = format("raid%i",idx);
	 this_ok = insert_possible_unit(unit, "raid");
	 retval = retval and this_ok;
	 unit = format("raidpet%i",idx);
	 this_ok = insert_possible_unit(unit, "raidpet");
	 retval = retval and this_ok;
      end

   end
   
   if ( nparty > 1 ) then

      for idx = 1, 4 do  -- its only 4 and nparty-1 was seemingly one short
	 unit = format("party%i",idx);
	 this_ok =insert_possible_unit(unit, "party");
	 retval = retval and this_ok;
	 unit = format("partypet%i",idx);
	 this_ok =insert_possible_unit(unit, "partypet");
	 retval = retval and this_ok;
      end

   end

   this_ok = insert_possible_unit("player", "player");
   retval = retval and this_ok;
   this_ok = insert_possible_unit("pet", "pet");
   retval = retval and this_ok;

   return retval;
end



---
--- best_tot_unit
---

local function best_tot_unit()

   local retval = nil;

   if ( ( UnitExists("targettarget") ) and
        ( UnitName("targettarget") == tot_target_info.name ) ) then
      retval = "targettarget";
      
   else
      retval = roster[tot_target_info.name];

   end

   return retval;
end




---
--- update_bar_unit
---

local function update_bar_unit()

   -- Returns true unless "real" unit is known not to have changed

   local try_unit = roster[tot_target_info.name];
   local old_unit = HoTT_Display_Bar.unit;
   if ( not units_getting_events[try_unit] ) then
      try_unit = nil;
   end
   HoTT_Display_Bar.unit = try_unit;
   if ( HoTT_Debug.UBU and ( HoTT_Display_Bar.unit ~= old_unit) ) then
      dprint("Bar now using "..tostring(HoTT_Display_Bar.unit));
   end

   return not (  HoTT_Display_Bar.unit and 
	         (  HoTT_Display_Bar.unit == old_unit ) 
	      );
end



---
--- clear_bar
---

local function clear_bar ()

   HoTT_Display_Bar.unit = nil;
   HoTT_Display_Bar:SetValue(0);
   HoTT_Display_Dead:Hide();

end



---
--- available_name_width
---

local function available_name_width ()

   local right = HoTT_Display:GetRight();
   local left = HoTT_Display:GetLeft();
   
   local anw = 115;  -- Covers start-up nil problem

   if ( right and left ) then
      anw = (right - left)
	 - params.ui.display.tot_name.inset.right
         - params.ui.display.tot_name.inset.left;
   end

   return anw;
      
end



---
--- set_display_name_color
---

--- Typcially ~ 5 ms for a new name and a reasonably-sized window
--- About 10-15 ms to truncate down a long name to nothing
--- regexp is not the culprit

local function set_display_name_color(name, color)


   if ( name ) then

      if ( placed_names.available_name_width ~= available_name_width() ) then
	 clear_table(placed_names);
	 placed_names.available_name_width = available_name_width();
	 
      end
      
      local fits = placed_names[name];
      
      if ( fits ) then 
	 HoTT_Display_NameArea_Text:SetText(fits);
	 
      else
	 
	 local now;
	 
	 if ( HoTT_Debug.name_time ) then
	    now = GetTime();
	 end
	 
	 HoTT_Display_NameArea_Text:SetText(name);
	 if ( ( HoTT_Display_NameArea_Text:GetStringWidth() <=
	       placed_names.available_name_width           ) or
		( string.len(name) <= 2 )                              
	  ) then
	    fits = name;
	    
	 else
	    
	    local try = string.sub(name, 1, -2);
	    local ellipsis_chars = string.len(ellipsis);
	    
	    while ( not fits ) do
	       HoTT_Display_NameArea_Text:SetText(try);
	       if ( ( HoTT_Display_NameArea_Text:GetStringWidth() <=
		     placed_names.available_name_width           ) or
		      ( string.len(try) <= 2 )        
		) then
		  fits = try;
	       else
		  try = string.sub(try, 1, -2);
	       end
	    end
	    
	    try = string.sub(try, 1, -2) .. ellipsis;
	    fits = false;
	    
	    while ( not fits ) do
	       HoTT_Display_NameArea_Text:SetText(try);
	       if ( ( HoTT_Display_NameArea_Text:GetStringWidth() <=
		     placed_names.available_name_width           ) or
		      ( string.len(try) <= ( 1 + ellipsis_chars ) )        
		) then
		  fits = try;
	       else
		  try = string.sub(try, 1, -2-ellipsis_chars) .. ellipsis;
	       end
	    end
	    
	    fits = string.gsub(fits, "%s"..ellipsis.."$", ellipsis);
	    
	 end   -- did name fit first time
	 
	 placed_names[name] = fits;
	 if ( HoTT_Debug.name_time ) then
	    local dt = GetTime() - now;
	    if ( dt > 0.0015 ) then
	       HoTT_Debug.pnt[name] = format("%5.3f",GetTime() - now);
	    end
	    tprint("Name time", now);
	 end
	 HoTT_Display_NameArea_Text:SetText(fits);
	 
      end
      
   end
   
   if ( color ) then 
      HoTT_Display_NameArea_Text:SetTextColor(color.r,
					       color.g,
					       color.b);
   end

   return true;
end



---
--- position_display 
---

-- local
function position_display ()

   local buff_rows_shown;
   local anw = available_name_width();

   local puid = params.ui.display;
   local relative_to = puid.relative_to;
   local relative_to_object = getglobal(relative_to);

   if ( not relative_to_object ) then 
      message(format(fmt_no_such_object, puid.relative_to));
      
      return false;
   end


   if ( HoTT_Debug.PD ) then
      dprint("Positioning for " .. ( UnitName("target") or "<nil>"));
   end
   

   local has_buffs = UnitBuff("target",1);
   local has_debuffs = UnitDebuff("target",1);
   local is_friend = UnitIsFriend("player", "target");

   if ( not ( has_buffs or has_debuffs ) ) then
      buff_rows_shown = 0;
      
   elseif ( ( has_debuffs and is_friend   ) or 
	    ( has_buffs and not is_friend )    ) then
      buff_rows_shown = 2;
      
   else
      buff_rows_shown = 1;
      
   end

   -- Check for "too narrow" problems and silently rectify

   if ( anw < puid.tot_name.min_width ) then
      puid.inset.right = puid.inset.right + ( puid.tot_name.min_width - anw );
   end


   --- Need to adjust relative offsets to UIParent scale

   local s = 1/params.ui.display.scale;


   if ( ( relative_to_object == UIParent )   or 
        ( relative_to_object == WorldFrame )    ) then

      HoTT_Display:SetPoint("TOPLEFT", 
			    puid.relative_to,
			    "TOPLEFT",
			    s*puid.inset.left,
			    -s*puid.drops[buff_rows_shown]);
   
      HoTT_Display:SetPoint("TOPRIGHT", 
			    puid.relative_to,
			    "TOPRIGHT",
			    -s*puid.inset.right,
			    -s*puid.drops[buff_rows_shown]);

   else

      HoTT_Display:SetPoint("TOPLEFT", 
			    puid.relative_to,
			    "BOTTOMLEFT",
			    s*puid.inset.left,
			    -s*puid.drops[buff_rows_shown]);
      
      HoTT_Display:SetPoint("TOPRIGHT", 
			    puid.relative_to,
			    "BOTTOMRIGHT",
			    -s*puid.inset.right,
			    -s*puid.drops[buff_rows_shown]);

   end
   
   return true;
end



---
--- refresh_ui_positions
---

---
--- NOTE: Call on /tot ui, and any time settings change
---

-- stubbed local earlier:
--
-- local
function refresh_ui_positions ()

   local name_offset;

   local puid = params.ui.display;
   
   HoTT_Display:SetScale(puid.scale * UIParent:GetScale());

   HoTT_Display_NameArea_Text:SetPoint("LEFT", 
				       "HoTT_Display_NameArea",
				       "LEFT", 
				       puid.tot_name.inset.left, 0);

   HoTT_Display_NameArea_Text:SetPoint("RIGHT", 
				       "HoTT_Display_NameArea",
				       "RIGHT", 
				       -puid.tot_name.inset.right, 0);

   HoTT_Display_NameArea_Text:SetJustifyH(puid.tot_name.alignment);

   position_display();

   return true;
end



---
--- global_check_warning
---

local function global_check_warning ()

   local global_check_failed = ( type(global_check_failures) ~= "nil" );

   if ( global_check_failed ) then
      DEFAULT_CHAT_FRAME:AddMessage(string_global_check_failed);
   end

   return global_check_failed;
end


---
--- hott_init
---

local function hott_init ()

   clear_t();
   clear_tot();
   hott_is_on = false;
   last_tot = nil;
   last_frame_tot = nil;

   clear_table(roster);

   clear_bar();

   reset_poll_timer();

   set_display_name_color(undetermined_string, colors.name.undetermined);

   return true;
end



---
--- hott_off
---

local function hott_off ()

   global_check_warning();

   hott_init();

   HoTT_Display:Hide();

   params.hott_was_on = false;
   
   -- DEFAULT_CHAT_FRAME:AddMessage(off_string);

   return true;
end



---
--- hott_on
---

local function hott_on ()

   global_check_warning();

   if ( HoTT_Patch_Warning() ) then
      return;
   end

   if ( not hott_is_on ) then
      hott_init();
      update_roster();
   end

   hott_is_on = true;
   
   update_tot();

   refresh_ui_positions();

   if UnitExists("target") then 
      HoTT_Display:Show();
   end

   params.hott_was_on = true;

   -- DEFAULT_CHAT_FRAME:AddMessage(on_string);

   return true;
end



---
--- better_target_by_name
---

local function better_target_by_name (desiredTarget, second_pass)

   local oldTarget = UnitName("target");
   local newTarget;
   local retval;

   local reverse_unit = roster[desiredTarget];
   if ( UnitName("targettarget") == desiredTarget ) then
      TargetUnit("targettarget");

   elseif (reverse_unit) then
      TargetUnit(reverse_unit);

   else
      TargetByName(desiredTarget);

   end

   newTarget = UnitName("target");

   if ( newTarget == desiredTarget ) then

      retval = newTarget;

   else 
      -- restore target to the "best" option, return nil

      if ( not second_pass ) then
	 better_target_by_name(oldTarget, true);

      else
	 ClearTarget();

      end

      retval = nil;

   end

   return retval;

end



---
--- bar_set_unreliable_callback
---

local function bar_set_unreliable_callback ()
   -- placeholder
end



---
--- load_saved_variables
---

local function load_saved_variables ()

   ---
   --- On entering this, VARIABLES_LOADED should have fired
   --- and the flag indicating this has run should not be set
   ---
   --- Return a true value to set that flag
   ---

   load_saved_settings();
	 
   if ( IsShiftKeyDown() ) then

      DEFAULT_CHAT_FRAME:AddMessage(shift_at_load_string);

      hott_off();

   else

      if ( params.hott_was_on ) then

	 hott_on();

      else

	 hott_off();

      end

   end

   return true;
end



------------------------------------
--- Command parsing and dispatch ---
------------------------------------


---
--- HoTT_Command_Dispatch
---

local function command_dispatch (command_string)

   local i1, i2;
   local command, command_arguments

   command_string = string.gsub(string.lower(command_string), "^%s*", "");
   command_string = string.gsub(command_string, "%s*$", "");

   i1, i2, command, command_arguments = 
      string.find(command_string, "^(%w+)%s*(.*)$");


   if ( ( command == string_help_cmd ) or ( command == nil ) ) then
      DEFAULT_CHAT_FRAME:AddMessage(help_message);


   elseif ( command == string_on_cmd ) then
      hott_on();
      

   elseif ( command == string_off_cmd ) then
      hott_off();
      

   elseif ( command == string_ui_cmd ) then
      DEFAULT_CHAT_FRAME:AddMessage(help_ui);


   elseif ( command == string_version_cmd ) then
      DEFAULT_CHAT_FRAME:AddMessage(
         format("ToT CVS versions:\nLua: %s\nXML: %s",
		version_table_data.apps.TargetOfTarget.lua_CVS,
		version_table_data.apps.TargetOfTarget.XML_CVS));


   elseif ( command == string_globals_cmd ) then

      if ( not global_check_failures ) then
	 DEFAULT_CHAT_FRAME:AddMessage(string_global_list);

      else
	 DEFAULT_CHAT_FRAME:AddMessage(string_global_check_explanation);
	 table_to_list = global_check_failures;
	 for k,v in pairs(global_check_failures) do
	    DEFAULT_CHAT_FRAME:AddMessage(v);
	 end
	 DEFAULT_CHAT_FRAME:AddMessage(string_global_variable_check_trailer);

      end


   elseif ( command == string_params_cmd ) then
      launch_params_browser();
	 
      
   else 
      DEFAULT_CHAT_FRAME:AddMessage(string_unrecognized_cmd_help);
      
   end
   
end







------------------------
------------------------
--- GLOBAL FUNCTIONS ---
------------------------
------------------------


----------------------
--- Event Handlers ---
----------------------


-------------------
--- HoTT Itself ---
-------------------


---
--- HoTT_MainFrame_OnLoad
---

function HoTT_MainFrame_OnLoad ()

   check_localized_slash_commands();

   init_preload_params();
   restore_defaults();
   hott_init();

   -- Register slash commands

   SLASH_TARGETOFTARGET_TOTON1 = toton_string;
   SlashCmdList["TARGETOFTARGET_TOTON"] = function ()
					     hott_on();
					  end

   SLASH_TARGETOFTARGET_TOTOFF1 = totoff_string;
   SlashCmdList["TARGETOFTARGET_TOTOFF"] = function ()
					      hott_off();
					   end
   
   SLASH_TARGETOFTARGET_TOT1 = string_slash_tot;
   SLASH_TARGETOFTARGET_TOT2 = string_slash_hott;
   SlashCmdList["TARGETOFTARGET_TOT"] = function (command_string)
					   command_dispatch(command_string);
					end

   player_name = UnitName("player");
   realm_name = GetCVar("realmName");

   
   -- Register for events

   this:RegisterEvent("VARIABLES_LOADED");
   this:RegisterEvent("PLAYER_ENTERING_WORLD");
   this:RegisterEvent("UNIT_NAME_UPDATE");

   this:RegisterEvent("PARTY_MEMBERS_CHANGED");
   this:RegisterEvent("RAID_ROSTER_UPDATE");

   this:RegisterEvent("PLAYER_TARGET_CHANGED");

   this:RegisterEvent("UNIT_AURA");

	if(UltimateUI_RegisterButton) then
		UltimateUI_RegisterButton ( 
			"TargetofTarget", 
			"Params", 
			"|cFF00CC00TargetOfTarget|r\nShows the target of the target! To use, type\n /tot on", 
			"Interface\\Icons\\Spell_Holy_SealOfSalvation", 
			launch_params_browser 
		);
	end


   --DEFAULT_CHAT_FRAME:AddMessage(loaded_string);

end



---
--- HoTT_MainFrame_OnEvent
---

function HoTT_MainFrame_OnEvent()


   if ( event == "VARIABLES_LOADED" ) then
      load_saved_variables();
   end
      

   if ( not hott_is_on ) then

      -- we shouldn't be doing anything else...

   else

      if ( ( event == "PLAYER_ENTERING_WORLD" ) or
	   ( event == "UNIT_NAME_UPDATE" )      or
	   ( event == "PARTY_MEMBERS_CHANGED" ) or 
	   ( event == "RAID_ROSTER_UPDATE" )       ) then
      
	 update_roster();
	 if ( update_bar_unit() ) then update_tot_health() end;
      
      end
	 
      if ( ( event == "PLAYER_TARGET_CHANGED" ) or
	   ( event == "PLAYER_ENTERING_WORLD" )    ) then
	 dprint("PTC or PEW event");
	 update_tot();
	 position_display();

      end

      if ( ( event == "UNIT_AURA" ) and ( arg1 == "target" ) ) then

	 position_display();

      end

   end    -- hott_is_on

end



---------------
--- Display ---
---------------

---
--- HoTT_Display_OnClick
---

function HoTT_Display_OnClick(button)

   local name = tot_target_info.name;
   local unit = best_tot_unit();

   if ( button == "RightButton") then
      return;
   end
      
   if ( button == "LeftButton" ) then

      if ( SpellIsTargeting() and unit ) then
	 SpellTargetUnit(unit);
	 
      elseif ( unit ) then
	 TargetUnit(unit);

      else
	 better_target_by_name(name);  -- think about glowy hand impact...

      end

   end    -- LeftButton
   
end



---
--- reset_poll_timer
---

-- local 
function reset_poll_timer()

   poll_timer = 0;
   poll_timer_fired = false;

   return true;
end



---
--- HoTT_Display_OnUpdate
---

function HoTT_Display_OnUpdate (interval)

   if ( not UnitExists("target") ) then
      last_frame_tot = nil;
      reset_poll_timer();
      this:Hide();
      
   else

      poll_timer = poll_timer + interval;  -- can be moved inside .unit test
                                           -- left here for debugging output
      
      this_frame_tot = UnitName("targettarget");

      if ( this_frame_tot ~= last_frame_tot ) then    -- fast, but...
	 dprint("tot change");
	 update_tot();

      elseif ( ( not HoTT_Display_Bar.unit ) and
	       ( UnitIsPlayer("target") or
		 UnitAffectingCombat("target") ) ) then    

	 -- Bar.unit take care of their own health and should have unique names
	 -- Only players or in-combat NPCs can change health or targets

	 if ( ( poll_timer > params.poll_timer_period ) and 
	       ( not poll_timer_fired )                     ) then
	 

	 elseif ( tot_target_info.player ) then
	    dprint("player timeout");
	    update_tot_health();

	 else
	    dprint("NPC timeout")
	    update_tot();

	 end

	 poll_timer_fired = true;

      end    -- tot changed or Bar.unit exists
	 
      last_frame_tot = this_frame_tot;

   end    -- target exists

end



---
--- HoTT_Display_OnEvent
---

function HoTT_Display_OnEvent ()

   if ( UnitExists("target") and hott_is_on ) then
      this:Show();
   else
      this:Hide();
   end
   
end

      



------------------
--- Health Bar ---
------------------


---
--- HoTT_Display_Bar_OnEvent
---

function HoTT_Display_Bar_OnEvent (event_arg1)

   if (this.unit and ( event_arg1 == this.unit ) and hott_is_on ) then
      UnitFrameHealthBar_Update(this, this.unit)
   end

   return true;
end



---
--- HoTT_Display_Bar_OnValueChanged
---

function HoTT_Display_Bar_OnValueChanged (new_value)

   if ( HoTT_Debug.BOVC                   and
        units_getting_events[this.unit]     and 
	( time_since_bar_update > 0.001 )     ) then
      dprint(format("Bar update interval: %7.3f", time_since_bar_update))
   end

   HealthBar_OnValueChanged(new_value, true);
   time_since_bar_update = 0;
   bar_set_unreliable = false;

   return true;
end



---
--- HoTT_Display_Bar_OnUpdate
---
   
function HoTT_Display_Bar_OnUpdate (interval)

   time_since_bar_update = time_since_bar_update + interval;

   if ( ( not this.unit )                                      and
        ( time_since_bar_update > params.bar_unreliable_time ) and
	( not bar_set_unreliable )                          
      ) then
      this:SetStatusBarColor(colors.bar.unreliable.r,
			     colors.bar.unreliable.g,
			     colors.bar.unreliable.b);
      bar_set_unreliable = true;
      if ( type(bar_set_unreliable_callback) == "function" ) then
	 bar_set_unreliable_callback(this);
      end
      
   end

   return true;
end



--------------------------
--- Core functionality ---
--------------------------

--- NOTE: These need to be moved and made local, once confirmed working

---
--- update_tot_health
---

function update_tot_health ()
   local now = GetTime();
   local retval = UnitExists("targettarget");

   if ( retval ) then
      HoTT_Display_Bar:SetMinMaxValues(0, UnitHealthMax("targettarget"));
      HoTT_Display_Bar:SetValue(UnitHealth("targettarget"));
      if ( UnitIsCorpse("targettarget") or
	   UnitIsDeadOrGhost("targettarget") ) then
	 HoTT_Display_Dead:Show();
      else
	 HoTT_Display_Dead:Hide();
      end
   end

   reset_poll_timer();
   tprint("update_tot_health", now);
   return retval;
end
   


---
--- update_tot    
---

function update_tot ()
   local now = GetTime();
   local retval;
   local may_be_stunned_mob;

   if ( not UnitExists("target") ) then

      dprint("No target to check");

      clear_t();
      clear_tot();
      clear_bar();
      set_display_name_color(no_target_string, colors.name.normal);
      HoTT_Display_Bar:Hide();


   elseif ( ( not UnitIsPlayer("target") )        and
	    ( not UnitAffectingCombat("target") )     ) then

      dprint("Non-aggro NPC");

      clear_t();
      clear_tot();
      clear_bar();
      set_display_name_color(no_target_string, colors.name.normal);
      HoTT_Display_Bar:Hide();


   elseif ( UnitIsUnit("target", "player") ) then

      dprint("Self-target case");

      target_to_t();
      self_to_tot();
      if ( update_bar_unit() ) then update_tot_health() end;
      set_display_name_color(tot_target_info.name, colors.name.normal);
      HoTT_Display_Bar:Show();


   else

      -- Check stunned mob while we have "target" reliably

      may_be_stunned_mob = ( ( not UnitIsPlayer("target") )    and 
			     ( UnitAffectingCombat("target") )     );

      -- then go ahead and do the check
	 
      if ( UnitExists("targettarget") ) then

	 target_to_t();
	 targettarget_to_tot();
	 if ( update_bar_unit() ) then update_tot_health() end;
	 set_display_name_color(tot_target_info.name, colors.name.normal);
	 HoTT_Display_Bar:Show();



      elseif ( may_be_stunned_mob ) then

	 if ( new_target_appears_same_as_before() ) then

	    dprint("Assuming stunned - same mob");
	    
	    -- and keep the old info
	    -- NOTE THAT THIS DOES NOT UPDATE HEALTH BAR!
	    
	    if ( roster[tot_target_info.name] ) then
	       set_display_name_color(nil, colors.name.unreliable);
	    else
	       set_display_name_color(nil, colors.name.unreliable_no_unit);
	    end


	 else
	 
	    dprint("Assuming stunned - new mob");
	    
	    set_display_name_color(stunned_string, 
				   colors.name.unreliable);

	 end

	 
      else
	 --
	 -- Target probably doesn't have a target (or is stunned PC)
	 --
	 
	 dprint("No target of target found");
	 
	 target_to_t();
	 clear_tot();
	 clear_bar();
	 set_display_name_color(no_target_string, colors.name.normal);
	 HoTT_Display_Bar:Hide();
	 
      end
      
      
   end

   if ( ( this_tot )                  and
        ( this_tot == player_name )   and
	( this_tot ~= last_tot )      and
	( t_target_info.canattackme )     ) then

      if ( params.aggro_message                     and 
	   string.find(params.aggro_message, "%S" )     )  then
	 UIErrorsFrame:AddMessage(params.aggro_message,
				  1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
      end

      if ( type(HoTT_Aggro_Callback) == "function" ) then
	 HoTT_Aggro_Callback();
      end
      
   end
   
   reset_poll_timer();
   tprint("update_tot", now);
   return tot_target_info;
      
end


---------------------------------
--- Params Frame here for now ---
---------------------------------



--[[

window_offset[		=> ui.display.drops[
window_offset.right	=> ui.display.inset.right
window_offset.left	=> ui.display.inset.left
window_offset.object	=> ui.display.relative_to
window_offset.scale	=> ui.display.scale
name_alignment		=> ui.display.tot_name.alignment
name_inset_left  	=> ui.display.tot_name.inset.left
name_inset_right 	=> ui.display.tot_name.inset.right


sign changes needed:

-window_offset[0]    => ui.display.drops[0]
-window_offset[1]    => ui.display.drops[1]
-window_offset[2]    => ui.display.drops[2]
-window_offset.right => ui.display.inset.right


specials:

window_offset.text_offset:

  "CENTER" => (ignore)
  "LEFT"   =>  ui.display.tot_name.inset.left
  "RIGHT"  => -ui.display.tot_name.inset.right



]]



---
--- params_refresh
---

local function params_refresh ()
   refresh_ui_positions();

end



---
--- params_frame_int_check
---

local function params_frame_int_check (str, err_str)

   local retval;

   if ( string.find(str, "^-?%d+$") ) then
      retval = tonumber(str);

   else
      message(string.format("%s must be an integer. Previous value restored.", 
			    err_str));
      HoTT_Params_Frame_LoadValues();
      retval = false;
   end

   return retval;
end



---
--- anw_check
---

local function anw_check (obj, dl, dr, tl, tr, field_name_string)

   obj = getglobal(obj or params.ui.display.relative_to);
   dl = dl or params.ui.display.inset.left;
   dr = dr or params.ui.display.inset.right;
   tl = tl or params.ui.display.tot_name.inset.left;
   tr = tr or params.ui.display.tot_name.inset.right;

   local retval;
   
   if ( ( obj:GetRight() - obj:GetLeft() - dl - dr - tl - tr ) < 
       params.ui.display.tot_name.min_width ) then

      message(string.format(fmt_too_narrow, field_name_string));
      HoTT_Params_Frame_LoadValues();
      retval = false;

   else
      retval = true;

   end

   return retval;
end



---
--- HoTT_Params_Frame_LoadValues
---

function HoTT_Params_Frame_LoadValues ()

   local puid = params.ui.display;

   HoTT_Params_Frame_ObjectName_EditBox:SetText(tostring(puid.relative_to));

   HoTT_Params_Frame_DisplayLeft_EditBox:SetText(tostring(puid.inset.left));
   HoTT_Params_Frame_DisplayRight_EditBox:SetText(tostring(puid.inset.right));
   HoTT_Params_Frame_TextLeft_EditBox:SetText(
					 tostring(puid.tot_name.inset.left));
   HoTT_Params_Frame_TextRight_EditBox:SetText(
					  tostring(puid.tot_name.inset.right));

   HoTT_Params_Frame_ButtonLeft:SetChecked(false);
   HoTT_Params_Frame_ButtonCenter:SetChecked(false);
   HoTT_Params_Frame_ButtonRight:SetChecked(false);

   if ( puid.tot_name.alignment == "CENTER" ) then
      HoTT_Params_Frame_ButtonCenter:SetChecked(true);

   elseif ( puid.tot_name.alignment == "LEFT" ) then 
      HoTT_Params_Frame_ButtonLeft:SetChecked(true);

   elseif ( puid.tot_name.alignment == "RIGHT" ) then 
      HoTT_Params_Frame_ButtonRight:SetChecked(true);

   end

   HoTT_Params_Frame_Scale_EditBox:SetText(format("%5.3f", puid.scale));

   HoTT_Params_Frame_Drop0_EditBox:SetText(tostring(puid.drops[0]));
   HoTT_Params_Frame_Drop1_EditBox:SetText(tostring(puid.drops[1]));
   HoTT_Params_Frame_Drop2_EditBox:SetText(tostring(puid.drops[2]));


   HoTT_Params_Frame_AggroMessage_EditBox:SetText(params.aggro_message);

end




---
--- HoTT_Params_Frame_ObjectName_Changed
---

function HoTT_Params_Frame_ObjectName_Changed (new_text)

   local obj = getglobal(new_text);

   if ( not ( obj and 
	      ( type(obj.GetRight == "function") ) and 
	      ( type(obj.GetLeft == "function") )
	    ) 
      ) then 

      message(string.format(fmt_no_obj_edit, new_text));
      HoTT_Params_Frame_LoadValues();
      refocus_object = HoTT_Params_Frame_ObjectName_EditBox;

   elseif ( anw_check(new_text, nil, nil, nil, nil, "Relative-to object") 
	) then

      params.ui.display.relative_to = new_text;
      params_refresh();

   else
      refocus_object = HoTT_Params_Frame_ObjectName_EditBox;

   end

end



---
--- HoTT_Params_Frame_DisplayLeft_Changed
---

function HoTT_Params_Frame_DisplayLeft_Changed (new_string)

   local new_number = params_frame_int_check(new_string, "Left display inset");

   if ( new_number and
        anw_check(nil, new_number, nil, nil, nil, "Left display inset") 
     ) then
      params.ui.display.inset.left = new_number;
      params_refresh();

   else
      refocus_object = HoTT_Params_Frame_DisplayLeft_EditBox;

   end

end


   
---
--- HoTT_Params_Frame_DisplayRight_Changed
---

function HoTT_Params_Frame_DisplayRight_Changed (new_string)

   local new_number = params_frame_int_check(new_string,"Right display inset");

   if ( new_number and
        anw_check(nil, nil, new_number, nil, nil, "Right display inset" ) 
     ) then
      params.ui.display.inset.right = new_number;
      params_refresh();

   else
      refocus_object = HoTT_Params_Frame_DisplayRight_EditBox;

   end

end


   
---
--- HoTT_Params_Frame_TextLeft_Changed
---

function HoTT_Params_Frame_TextLeft_Changed (new_string)

   local new_number = params_frame_int_check(new_string, "Left text inset");

   if ( new_number and
        anw_check(nil, nil, nil, new_number, nil, "Left text inset") 
    ) then
      params.ui.display.tot_name.inset.left = new_number;
      params_refresh();

   else
      refocus_object = HoTT_Params_Frame_TextLeft_EditBox;

   end

end


   
---
--- HoTT_Params_Frame_TextRight_Changed
---

function HoTT_Params_Frame_TextRight_Changed (new_string)

   local new_number = params_frame_int_check(new_string, "Right text inset");

   if ( new_number and
        anw_check(nil, nil, nil, nil, new_number, "Right text inset" ) 
    ) then
      params.ui.display.tot_name.inset.right = new_number;
      params_refresh();

   else
      refocus_object = HoTT_Params_Frame_TextRight_EditBox;

   end

end


   
---
--- HoTT_Params_Frame_Alignment_Changed
---

function HoTT_Params_Frame_Alignment_Changed (new_alignment)

   params.ui.display.tot_name.alignment = new_alignment;
   params_refresh();

end



---
--- HoTT_Params_Frame_Scale_Changed
---

function HoTT_Params_Frame_Scale_Changed (new_string)

   local new_number = tonumber(new_string);

   if ( new_number and ( new_number > 0 ) ) then
      params.ui.display.scale = new_number;
      params_refresh();

   else
      message("Scale must be a positive value. Previous value restored.");
      HoTT_Params_Frame_LoadValues();
      refocus_object = HoTT_Params_Frame_Scale_EditBox;
      retval = false;
   end

end



---
--- HoTT_Params_Frame_Drop0_Changed
---

function HoTT_Params_Frame_Drop0_Changed (new_string)

   local new_number = params_frame_int_check(new_string, "No-buff drop");

   if ( new_number ) then
      params.ui.display.drops[0] = new_number;
      params_refresh();

   else
      refocus_object = HoTT_Params_Frame_Drop0_EditBox;

   end

end


   
---
--- HoTT_Params_Frame_Drop1_Changed
---

function HoTT_Params_Frame_Drop1_Changed (new_string)

   local new_number = params_frame_int_check(new_string, "First-row drop");

   if ( new_number ) then
      params.ui.display.drops[1] = new_number;
      params_refresh();

   else
      refocus_object = HoTT_Params_Frame_Drop1_EditBox;

   end

end



---
--- HoTT_Params_Frame_Drop2_Changed
---

function HoTT_Params_Frame_Drop2_Changed (new_string)

   local new_number = params_frame_int_check(new_string, "Second-row drop");

   if ( new_number ) then
      params.ui.display.drops[2] = new_number;
      params_refresh();

   else
      refocus_object = HoTT_Params_Frame_Drop2_EditBox;

   end

end


  
---
--- HoTT_Params_Frame_AggroMessage_Changed
---

function HoTT_Params_Frame_AggroMessage_Changed (new_text)

   params.aggro_message = new_text;
   params_refresh();

end



---
--- launch_params_browser
---

-- local
function launch_params_browser ()

   scratch_params = {};

   current_params = params;

   set_deferral_recursively(scratch_params, params,
			    "scratch_params", "current_params");

   params = scratch_params;
   HoTT_Params = scratch_params;

   HoTT_Params_Frame:Show();

end



---
--- HoTT_Params_Frame_OnCancel
---

function HoTT_Params_Frame_OnCancel ()

   HoTT_Params_Frame_LoadValues(); -- to prevent error messaging
   PlaySound("gsTitleOptionExit");
   HideUIPanel(HoTT_Params_Frame);

   params = current_params;
   HoTT_Params = current_params;

   params_refresh();

end



---
--- HoTT_Params_Frame_OnDefaults
---

function HoTT_Params_Frame_OnDefaults ()

   params.aggro_message = default_params.aggro_message;

   -- copy_table_recursively(default_params.ui, params.ui);
   -- fails as default_params is write-locked and can't be iterated over

   local dpuid = default_params.ui.display;
   local puid = params.ui.display;

   puid.relative_to = dpuid.relative_to;
   puid.scale = dpuid.scale;
   puid.inset.left = dpuid.inset.left;
   puid.inset.right = dpuid.inset.right;
   puid.drops[0] = dpuid.drops[0];
   puid.drops[1] = dpuid.drops[1];
   puid.drops[2] = dpuid.drops[2];
   puid.tot_name.alignment = dpuid.tot_name.alignment;
   puid.tot_name.inset.left = dpuid.tot_name.inset.left;
   puid.tot_name.inset.right = dpuid.tot_name.inset.right;


   HoTT_Params_Frame_LoadValues();

   params_refresh();

end



---
--- HoTT_Params_Frame_OnOkay
---

function HoTT_Params_Frame_OnOkay ()

   ---
   --- Can't blindly accept and close!
   ---

   HoTT_Params_Frame_ClearFocus();

   if ( refocus_object ) then
      refocus_object:SetFocus();
      refocus_object = nil;

   else


      if ( current_params.aggro_message ~= params.aggro_message ) then
	 current_params.aggro_message = params.aggro_message;
      else
	 current_params.aggro_message = nil;    -- defer to defaults
      end
      
      local puid = params.ui.display;
      local cpuid = current_params.ui.display;
      local dpuid = default_params.ui.display;
      
      
      if ( ( puid.relative_to ~= dpuid.relative_to ) or
	  ( puid.scale ~= dpuid.scale ) or
	     ( puid.inset.left ~= dpuid.inset.left ) or
	     ( puid.inset.right ~= dpuid.inset.right ) or
	     ( puid.drops[0] ~= dpuid.drops[0] ) or
	     ( puid.drops[1] ~= dpuid.drops[1] ) or
	     ( puid.drops[2] ~= dpuid.drops[2] ) or
	     ( puid.tot_name.alignment ~= dpuid.tot_name.alignment ) or
	     ( puid.tot_name.inset.left ~= dpuid.tot_name.inset.left ) or
	     ( puid.tot_name.inset.right ~= dpuid.tot_name.inset.right )
       ) then
	 
	 cpuid.relative_to = puid.relative_to;
	 cpuid.scale = puid.scale;
	 cpuid.inset.left = puid.inset.left;
	 cpuid.inset.right = puid.inset.right;
	 cpuid.drops[0] = puid.drops[0];
	 cpuid.drops[1] = puid.drops[1];
	 cpuid.drops[2] = puid.drops[2];
	 cpuid.tot_name.alignment = puid.tot_name.alignment;
	 cpuid.tot_name.inset.left = puid.tot_name.inset.left;
	 cpuid.tot_name.inset.right = puid.tot_name.inset.right;
	 
      else
	 
	 current_params.ui = nil;    -- defer to defaults
	 
      end
      
      PlaySound("gsTitleOptionOK");
      HideUIPanel(HoTT_Params_Frame);
      
      
      params = current_params;
      HoTT_Params = current_params;
            
   end

   params_refresh();

end



---
--- HoTT_Params_Frame_ClearFocus
---

function HoTT_Params_Frame_ClearFocus ()

   HoTT_Params_Frame_ObjectName_EditBox:ClearFocus();
   HoTT_Params_Frame_DisplayLeft_EditBox:ClearFocus();
   HoTT_Params_Frame_DisplayRight_EditBox:ClearFocus();
   HoTT_Params_Frame_TextLeft_EditBox:ClearFocus();
   HoTT_Params_Frame_TextRight_EditBox:ClearFocus();
   HoTT_Params_Frame_Scale_EditBox:ClearFocus();
   HoTT_Params_Frame_Drop0_EditBox:ClearFocus();
   HoTT_Params_Frame_Drop1_EditBox:ClearFocus();
   HoTT_Params_Frame_Drop2_EditBox:ClearFocus();
   HoTT_Params_Frame_AggroMessage_EditBox:ClearFocus();

end



---
--- HoTT_Params_Frame_CheckRefocus
---

function HoTT_Params_Frame_CheckRefocus ()

   if ( refocus_object ) then
      refocus_object:SetFocus();
      refocus_object = nil;
   end

end
