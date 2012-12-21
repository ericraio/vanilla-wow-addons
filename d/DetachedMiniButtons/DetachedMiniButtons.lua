

DetachedMiniButtonsData = {};

local FullSizeButtons = 	
{
	["MiniMapTrackingFrame"] = true,
};

local DefaultButtons = {
["MinimapZoomIn"] = "MinimapZoomIn",
["MinimapZoomOut"] = "MinimapZoomOut",
}

local SpecialButtons = {
 ["WIM_IconFrameButton"] = "WIM_IconFrameButton",
 ["MiniMapBattlefieldFrame"] = "MiniMapBattlefieldFrame",
 ["GameTimeFrame"] = "GameTimeFrame",
 ["GroupCalendarButton"] = "GroupCalendarButton",
 ["Gypsy_Button"] = "Gypsy_Button",
 ["WaterboyIcon"] = "WaterboyIcon",
 ["UberHealOnClick_Minimap"] = "UberHealOnClick_Minimap",
 ["GuildAdsMinimapButton"] = "GuildAdsMinimapButton",
 ["Slib_MinimapBtn"] = "Slib_MinimapBtn",
 ["Nurfed_LockButton"] = "Nurfed_LockButton",
 ["RecipeRadarMinimapButtonHighlightFrame"] = "RecipeRadarMinimapButtonHighlightFrame",
}
			
local _MASKS_ = 
{
	--["AtlasButton"] = "AtlasButtonFrame",
	--["CensusButton"] = "CensusButtonFrame",
	--["CT_RASets_Button"] = "CT_RASetsFrame",
	--["TheYatlasButton"] = "YatlasButtonFrame",
	["AM_MinimapButton"] = "AM_MinimapFrame",
	["CT_OptionBarFrame"] = "CT_OptionButton",
	["FishingBuddyMinimapFrame"] = "FishingBuddyMinimapButton",
	--["AtlasButtonFrame"] = "AtlasButton",
	["RecipeRadarMinimapButtonFrame"] = "RecipeRadarMinimapButton",
	["AccountantButtonFrame"] = "AccountantButton",	
	["OpiumButtonFrame"] = "OpiumButton",
	["Perl_Config_ButtonFrame"] = "PerlButton",
	--["SW_IconFrame"] = "SW_IconFrame_Button",
	--["CensusButtonFrame"] = "CensusButton",
	["CT_RASetsFrame"] = "CT_RASets_Button",
	["RaidRollButtonFrame"] = "RaidRollButtonFrameButton",
	["PanzaButtonFrame" ] = "PanzaButton",
	["YatlasButtonFrame"] = "TheYatlasButton",
	["LazyScriptMinimapFrame"] = "LazyScriptMinimapButton",
	["CritLineFrameMini"] = "CritLineButton",
	["CleanMinimapButtonFrame"] = "CleanMinimapButton",
	["MM_ButtonFrame"] = "MM_Button",
	["Wardrobe_IconFrame"] = "Wardrobe_IconFrame",
	["HAMinimapFrame"] = "HAMinimapButton",
	["kkbk_miniMap"] = "kkbk_miniMapButton1",
	["MusicPlayer_ButtonFrame"] = "MusicPlayer_Button",
	--["CECBMiniMapButtonFrame"] = "CECBMiniMapButton",
};

local _CLASS_ = "DetachedMiniButtons ";
local _VERSION_ = "0.9.22";
local _nodock = false;
local _lock = false;
local _initialized = false;
local _player = "";
local _realm = "";
local _frameList = {};
local _INITIALX_ = "INITIALX";
local _INITIALY_ = "INITIALY";
local _LASTX_    = "LASTX";
local _LASTY_    = "LASTY";
local _NAME_     = "NAME";
local _NODOCK_   = "NODOCK";
local _LOCK_     = "LOCK";
local _PARENT_   = "PARENT";
local _USED_     = "USED";
local _MASKED_   = {};
local _UIMAXX_   = 0;
local _UIMAXY_   = 0;

local _oldFishBuddyEnter;

_rescanned = false;
_starttime = 0;

local _DEBUG_    = false;


function DEBUG(s)
 if (_DEBUG_) then
	DEFAULT_CHAT_FRAME:AddMessage(_CLASS_ .. ":" .. s)
 end
end


-- --------------------------------------------------------------------
function DetachedMiniButtons_OnLoad()
	
	SLASH_DetachedMiniButtons1 = "/dmbs";
	
	SlashCmdList["DetachedMiniButtons"] = function (msg)
		DetachedMiniButtons_Slash(msg);
	end	
	this:RegisterEvent("PLAYER_ENTERING_WORLD");	
	_starttime = GetTime();
end

function DetachedMiniButtons_showHelp()
	DEFAULT_CHAT_FRAME:AddMessage(_CLASS_ .. " " .. _VERSION_);
	DEFAULT_CHAT_FRAME:AddMessage(SLASH_DetachedMiniButtons1 .. " or " .. SLASH_DetachedMiniButtons1 .. " help : these messages.");
	DEFAULT_CHAT_FRAME:AddMessage(SLASH_DetachedMiniButtons1 .. " reset : set buttons back to initial positions.");
	DEFAULT_CHAT_FRAME:AddMessage(SLASH_DetachedMiniButtons1 .. " cfg : show current settings.");
	DEFAULT_CHAT_FRAME:AddMessage(SLASH_DetachedMiniButtons1 .. " scan : rescan for minimap buttons.");
	DEFAULT_CHAT_FRAME:AddMessage(SLASH_DetachedMiniButtons1 .. " nodock : do not try to dock buttons near minimap.");
	DEFAULT_CHAT_FRAME:AddMessage(SLASH_DetachedMiniButtons1 .. " dock : try to dock buttons near minimap.");
	DEFAULT_CHAT_FRAME:AddMessage(SLASH_DetachedMiniButtons1 .. " lock : lock buttons in place.");
	DEFAULT_CHAT_FRAME:AddMessage(SLASH_DetachedMiniButtons1 .. " unlock : unlock the buttons.");
end

function DetachedMiniButtons_showSet()
	local onoff = "off";
	if (DetachedMiniButtonsData[_realm][_player][_LOCK_]) then
		onoff = "on";
	end;
	DEFAULT_CHAT_FRAME:AddMessage(_CLASS_ .. " locked buttons: " .. onoff);
	onoff = "off";
	if (DetachedMiniButtonsData[_realm][_player][_NODOCK_]) then
		onoff = "on";
	end;
	DEFAULT_CHAT_FRAME:AddMessage(_CLASS_ .. " attempt minimap docking: " .. onoff);

end
function DetachedMiniButtons_Slash(msg)

	if (not msg) then
		DetachedMiniButtons_showHelp();
		return;
	end;
	if (msg == "") then
		DetachedMiniButtons_showHelp();
		return;
	end;
	if (msg == "help") then
		DetachedMiniButtons_showHelp();
		return;
	end;
	if (msg == "cfg") then
		DetachedMiniButtons_showSet();
	end;
	if (msg == "scan") then
		DetachedMiniButtons_GetChildren(msg);
		return;
	end;
	if (msg == "nodock") then
		DEFAULT_CHAT_FRAME:AddMessage(_CLASS_ .."-This function is currently disabled");
		DetachedMiniButtonsData[_realm][_player][_NODOCK_] = true;
	end;
	if (msg == "dock") then
		DEFAULT_CHAT_FRAME:AddMessage(_CLASS_ .."-This function is currently disabled");
		DetachedMiniButtonsData[_realm][_player][_NODOCK_] = false;
	end;
	if (msg == "reset") then
		DetachedMiniButtons_reset(_frameList);
	end;
	if (msg == "lock") then
		DEFAULT_CHAT_FRAME:AddMessage(_CLASS_ .."-Buttons are now locked");
		DetachedMiniButtonsData[_realm][_player][_LOCK_] = true;
	end;
	if (msg == "unlock") then
		DEFAULT_CHAT_FRAME:AddMessage(_CLASS_ .."-Buttons are now unlocked");
		DetachedMiniButtonsData[_realm][_player][_LOCK_] = false;
	end;	
end

function DetachedMiniButtons_OnEvent(event)
	if (event == "PLAYER_ENTERING_WORLD") then
		if (not _initialized) then
			_UIMAXX_ = INT(UIParent:GetRight() - 16);
			_UIMAXY_ = INT(UIParent:GetTop());
			
			_realm = GetRealmName();			 -- get our realm
			_player = UnitName("player") 		 -- get our player name
		
			if (not DetachedMiniButtonsData) then 
				DetachedMiniButtonsData = {};
			end;
			if (not DetachedMiniButtonsData[_realm]) then
				DetachedMiniButtonsData[_realm] = {};
			end			
			if (not DetachedMiniButtonsData[_realm][_player]) then
				DetachedMiniButtonsData[_realm][_player] = {};
			end
			if (not DetachedMiniButtonsData[_realm][_player][_NODOCK_]) then
				DetachedMiniButtonsData[_realm][_player][_NODOCK_] = _nodock;
			end;
			if (not DetachedMiniButtonsData[_realm][_player][_LOCK_]) then
				DetachedMiniButtonsData[_realm][_player][_LOCK_] = _lock;
			end;

			if (FishingBuddy) then
				if (FishingBuddy.Minimap.Button_OnEnter) then
					_oldFishBuddyEnter = FishingBuddy.Minimap.Button_OnEnter;
					FishingBuddy.Minimap.Button_OnEnter=newFishBuddyEnter_OnEnter;
				else
					_oldFishBuddyEnter = nil;
				end;
			end;
			
			_initialized = true;
			DEFAULT_CHAT_FRAME:AddMessage(_CLASS_ .." " .. _VERSION_ .. " loaded.");
		end;	
	end
end;

function newFishBuddyEnter_OnEnter()
   if ( GameTooltip.fbmmbfinished ) then
      return;
   end
   if ( FishingBuddy.GetSetting("UseButtonHole") == 0 ) then
      GameTooltip.fbmmbfinished = 1;
      GameTooltip:SetOwner(FishingBuddyMinimapButton, "ANCHOR_LEFT");
      GameTooltip:AddLine(FishingBuddy.NAME);
      local text = FishingBuddy.TooltipBody("MinimapClickToSwitch");
      GameTooltip:AddLine(text,.8,.8,.8,1);
      GameTooltip:Show();
   end
end

function DetachedMiniButtons_cleanUp()
	local frame = Sea.util.getValue("RecipeRadarMinimapButtonHighlightFrame");
	if (frame) then
		local c = Sea.util.getValue("RecipeRadarMinimapButton");
		if (c) then
			frame:SetParent(c);
		end;
	end;
	frame = Sea.util.getValue("RogueTrackerPoisonButton");
	if (frame) then
		local c = Sea.util.getValue("RogueTrackerPoisonText");
		if (c) then
			c:SetParent(frame);
		end;
	end;
	frame = Sea.util.getValue("RogueTrackerBlindButton");
	if (frame) then
		local c = Sea.util.getValue("RogueTrackerBlindText");
		if (c) then
			c:SetParent(frame);
		end;
	end;
	frame = Sea.util.getValue("RogueTrackerVanishButton");
	if (frame) then
		local c = Sea.util.getValue("RogueTrackerVanishText");
		if (c) then
			c:SetParent(frame);
		end;
	end;
	frame = Sea.util.getValue("RogueTrackerFlashButton");
	if (frame) then
		local c = Sea.util.getValue("RogueTrackerFlashText");
		if (c) then
			c:SetParent(frame);
		end;
	end;
	frame = Sea.util.getValue("RogueTrackerTeaButton");
	if (frame) then
		local c = Sea.util.getValue("RogueTrackerTeaText");
		if (c) then
			c:SetParent(frame);
		end;
	end;
	
	if (SquareMinimap) then
		local nl = {};
		nl["MiniMapTrackingFrame"] = "MiniMapTrackingFrame";
		MiniMapTrackingFrame:SetScale(1)
		DetachedMiniButtons_resolveInitialValues(nl);
		DetachedMiniButtons_setMovable(nl);
		DetachedMiniButtons_setInitialRange(nl);
		DetachedMiniButtons_rePosition(nl);		
	end
	

end;

function DetachedMiniButtons_DoInit()
	local list = {};
	list = DetachedMiniButtons_AddDefaults(list);
	list = DetachedMiniButtons_findFrames(list);	
	DetachedMiniButtons_resolveInitialValues(list);
	DetachedMiniButtons_setMovable(list);
	DetachedMiniButtons_setInitialRange(list);
	DetachedMiniButtons_rePosition(list);
	DetachedMiniButtons_cleanUp();
end
-- -------------------------------------------------------------------
-- -------------------------------------------------------------------
-- HELPER FUNCTIONS
-- -------------------------------------------------------------------
function INT(x)
	if (x == nil) then
		return(nil)
	end
	return(math.floor(x + 0.5));
end

function INRANGEX(x)
	--DEBUG(_UIMAXX_)
	if (x == nil) then
	  return(true);
	end;
	if (x < 0) or (x > _UIMAXX_) then
		return(false);
	end;		
	return(true);
end

function INRANGEY(y)
	--DEBUG(_UIMAXY_)
	if (y == nil) then
	  return(true);
	end;
	if (y < 0) or (y > _UIMAXY_) then
		return(false);
	end;		
	return(true);
end

function INRANGEXY(x,y)
	if (x == nil) or (y == nil) then
	  return(true);
	end;
	if (x < 0) or (x > _UIMAXX_) or (y < 0) or (y > _UIMAXY_) then
		return(false);
	end;
		
	return(true);
end

function INRANGEFRAME(frame)
	if (frame) then
		if (frame.GetLeft and frame.GetTop) then
			local left = INT(frame:GetLeft());
			local top = INT(frame:GetTop());
			if (left ~= nil) and (top ~= nil) then
				if (left < -8) or (left > _UIMAXX_ - 8) or (top < -8) or (top > _UIMAXY_ - 8) then
					--DEBUG("NOT IN RANGE:" .. frame:GetName());
					return(false);
				end
			end;
		end
	end;
	return(true);
end

function RANGEX(x)
 if (x == nil) then
  return(nil)
 end;
 if (x < -8) then
   return(x);
 end;
 if (x > _UIMAXX_) then
  return(_UIMAXX_ - 2);
 end; 
 return(x);
end

function RANGEY(x)
 if (x == nil) then
  return(nil)
 end;
 if (x < -8) then
   return(x);
 end;
 if (x > _UIMAXY_ ) then
  return(_UIMAXY_);
 end; 
 return(x);
end

-- --------------------------------------------------------------------
-- 
-- --------------------------------------------------------------------
function isExclude(s)
	if (string.find(s,"GatherNote") ~= nil) then
		return(true);
	end;
	if (string.find(s,"PoisonPouch") ~= nil) then
		return(true);
	end;
	if (string.find(s,"IFrameManagerButton") ~= nil) then
		return(true);
	end;
	--if (string.find(s,"MiniMapTrackingFrame") ~= nil) then
	--	return(true);
	--end;
	if (string.find(s,"MM_CoreFrame") ~= nil) then
		return(true);
	end;
	if 	(string.find(s,"MiniMapBattlefieldDropDown") ~= nil) then
		return(true);
	end;
	if (string.find(s,"simpleMinimapFrame") ~= nil) then
		return(true);
	end;
	--if (string.find(s,"FuBarPlugin") ~= nil) then
	--	return(true);
	--end;
	if (string.find(s,"Sprocket") ~= nil) then
		return(true);
	end;
	if (string.find(s,"RogueTracker") ~= nil) and (string.find(s,"DraggingFrame") ~= nil) then
		return(true);
	end;
	return(false);
end

function isInclude(s)
	if (string.find(s,"SbQuestIcon") ~= nil) then							
		return(true);
	end
	if (string.find(s,"WIM") ~= nil) then							
		return(true);
	end
	if (string.find(s,"UI") ~= nil) then							
		return(true);
	end
	if (string.find(s,"Frame") ~= nil) then									
		return(true);
	end
	if (string.find(s,"Button") ~= nil) then									
		return(true);
	end
	if (string.find(s,"CT_") ~= nil) then
		return(true);
	end;
	if (string.find(s,"CTA_MinimapIcon") ~= nil) then
		return(true);
	end;
	if (string.find(s,"MetaMap") ~= nil) then
		return(true);
	end;
	if (string.find(s,"HunterVSNefarianIcon") ~= nil) then 
		return(true);
	end;
	if (string.find(s,"mgames_minimap") ~= nil) then 
		return(true);
	end;
	if (string.find(s,"kkbk_") ~= nil) then 
		return(true);
	end;
		
	return(false);
end

function DetachedMiniButtons_Mask(n)
	if (_MASKS_[n]) then
		_MASKED_[_MASKS_[n]] = n;
		return(_MASKS_[n]);
	end;		
	return(n);
end

function DetachedMiniButtons_ResolveMask(n,frame)
	if (_MASKS_[n]) then
		_MASKED_[_MASKS_[n]] = n;
		return(_MASKS_[n]);
	end;		
	local children = { frame:GetChildren()};
	--DEBUG("CHILDREN:" .. n .. table.getn(children));
	if (table.getn(children) == 1) then
		--DEBUG("ONE CHILD: " .. n);
		local child = children[1];
		_MASKS_[n] = child:GetName();
		return(child:GetName());	
	end
	
	return(n);
end


function DetachedMiniButtons_AddDefaults(list)
	for n in DefaultButtons do		
		if (DetachedMiniButtons_AddFrameName(n,n)) then
			list[n] = n;
		end
	end;
	return(list);
end

function DetachedMiniButtons_AddFrameName(n,p)
	local frame = Sea.util.getValue(n);
	if (frame) then
		if ((not frame.GetLeft) and (not frame.GetTop)) then
			return(false);
		end;
		if (frame:GetLeft() == nil) then
			return(false);
		end;
		if (frame:GetTop() == nil) then
			return(false);
		end;
	
		if (not _frameList[n]) then
			_frameList[n] = n;
		end;
		if (not DetachedMiniButtonsData[_realm][_player][n]) then		
			DetachedMiniButtonsData[_realm][_player][n] = {};
		end
		if (not DetachedMiniButtonsData[_realm][_player][n][_NAME_]) then
			DetachedMiniButtonsData[_realm][_player][n][_NAME_] = n;
		end;
		
		if (not DetachedMiniButtonsData[_realm][_player][n][_INITIALX_]) then
			DetachedMiniButtonsData[_realm][_player][n][_INITIALX_] = INT(frame:GetLeft());
		end
		if (not DetachedMiniButtonsData[_realm][_player][n][_INITIALY_]) then
			DetachedMiniButtonsData[_realm][_player][n][_INITIALY_] = INT(frame:GetTop());									  	
		end
		if (not DetachedMiniButtonsData[_realm][_player][n][_PARENT_]) then
			DetachedMiniButtonsData[_realm][_player][n][_PARENT_] = p;									  				
		end
		if (not DetachedMiniButtonsData[_realm][_player][n][_USED_]) then
			DetachedMiniButtonsData[_realm][_player][n][_USED_] = false;									  	
		end
		return(true);
	end;
	return(false);
end

function DetachedMiniButtons_findFrames(list)
	if (Minimap.GetChildren) then
		local children = { Minimap:GetChildren()};
		if (children) then
			for _, child in children do
				if (child.GetName and child:GetName()) then
					local n = child:GetName();	
                    local p = n;							
					if isInclude(n) and not isExclude(n) then							
						 --DEFAULT_CHAT_FRAME:AddMessage(n);
						 n = DetachedMiniButtons_ResolveMask(n,child);						 
						 if (DetachedMiniButtons_AddFrameName(n,p)) then
							list[n] = n;
						end;																
					end					
				end
			end
		end
	end
	if (MinimapBackdrop.GetChildren) then
		local children = { MinimapBackdrop:GetChildren()};
		if (children) then
			for _, child in children do
				if (child.GetName and child:GetName()) then
					local n = child:GetName();			
					local p = n;
					if isInclude(n) and not isExclude(n) then							
						--DEFAULT_CHAT_FRAME:AddMessage(n);
						 n = DetachedMiniButtons_ResolveMask(n,child);						
						 if (DetachedMiniButtons_AddFrameName(n,p)) then
							list[n] = n;
						end;																
					end					
				end
			end
		end
	end
	
	for n in SpecialButtons do
		local s = n;			
		local frame = Sea.util.getValue(s);
		if (frame) then
			if (DetachedMiniButtons_AddFrameName(s,s)) then
				list[s] = s;
			end;	
		end;
	
	end
	
	return(list);
end;

function DetachedMiniButtons_resolveInitialValues(list)
	for framename in list do
		if (DetachedMiniButtonsData[_realm][_player][framename][_INITIALX_] and
		    DetachedMiniButtonsData[_realm][_player][framename][_INITIALY_]) then
			
			if (not INRANGEX(DetachedMiniButtonsData[_realm][_player][framename][_INITIALX_])) then
				DetachedMiniButtonsData[_realm][_player][framename][_INITIALX_] =
				INT(RANGEX(DetachedMiniButtonsData[_realm][_player][framename][_INITIALX_])) - 10;
			end;
			if (not INRANGEY(DetachedMiniButtonsData[_realm][_player][framename][_INITIALY_])) then			  
				DetachedMiniButtonsData[_realm][_player][framename][_INITIALY_] = 
				INT(RANGEY(DetachedMiniButtonsData[_realm][_player][framename][_INITIALY_])) - 10;
			end;		
			
		end
	end
end

function DetachedMiniButtons_setInitialRange(list)
	local frame;
	for n in list do
		--DEFAULT_CHAT_FRAME:AddMessage("FRAME: " .. n);
		if (DetachedMiniButtonsData[_realm][_player][n]) then
		if (not DetachedMiniButtonsData[_realm][_player][n][_LASTX_] and 
			not DetachedMiniButtonsData[_realm][_player][n][_LASTY_]) then		
				--
			frame = Sea.util.getValue(n);
			if (frame) then 			
				if (not INRANGEFRAME(frame)) then
					--DEFAULT_CHAT_FRAME:AddMessage("CUR: " .. curx .. ":" .. frame:GetLeft());
					frame.currentX = INT(RANGEX(frame:GetLeft())) - 16;
					frame.currentY = INT(RANGEY(frame:GetTop()));	
					frame:ClearAllPoints();					
					frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT",frame.currentX, frame.currentY);									
					DetachedMiniButtonsData[_realm][_player][n][_INITIALX_] = INT(frame:GetLeft());
					DetachedMiniButtonsData[_realm][_player][n][_INITIALY_] = INT(frame:GetTop());									  	
				end;
			end		
		end;	
		end;
	end
end


function DetachedMiniButtons_setMovable(list)

	for framename in list do	
		local frame = Sea.util.getValue(framename);	
		if (frame) then
			--DEFAULT_CHAT_FRAME:AddMessage(framename);					
			frame:RegisterForDrag("LeftButton");
			frame:SetParent(UIParent);
			frame:SetMovable(1);	
			frame.currentX = RANGEX(INT(frame:GetLeft()));
			frame.currentY = RANGEY(INT(frame:GetTop()));
			if (framename == "GameTimeFrame") then
				frame:SetFrameLevel(0);
			end;
			if (framename == "GroupCalendarButton") then
				frame:SetFrameLevel(1);
			end;
			if (framename == "MiniMapTrackingFrame") then
				frame:SetFrameLevel(2);
			end;
			
			local s = nil;
			
			--if (DetachedMiniButtonsData[_realm][_player][framename][_PARENT_]) then
			--	if (DetachedMiniButtonsData[_realm][_player][framename][_PARENT_] ~= framename) then
			--		s = DetachedMiniButtonsData[_realm][_player][framename][_PARENT_];
			--	end;
			--end;
			
			--frame:SetFrameLevel(frame:GetFrameLevel()+1);		
			--if (s ~= nil) then
			--	local p = Sea.util.getValue(s);
			--	if (p) then
			--		p:SetParent(UIParent);
			--	end;
			--end;
			
			Sea.util.hook( framename, "DetachedMiniButtons_Master_OnDragStart", "replace", "OnDragStart" );
			Sea.util.hook( framename, "DetachedMiniButtons_Master_OnDragStop", "replace", "OnDragStop" );
			Sea.util.hook( framename, "DetachedMiniButtons_OnUpdate", "replace", "OnUpdate" );
			
		end
	end
end


function DetachedMiniButtons_rePosition(list)
	for framename in list do
		if (DetachedMiniButtonsData[_realm][_player][framename]) then
			if (DetachedMiniButtonsData[_realm][_player][framename][_LASTX_] and 
				DetachedMiniButtonsData[_realm][_player][framename][_LASTY_]) then
		
				local frame = Sea.util.getValue(framename);
				if (frame) then
					frame:ClearAllPoints();
					frame.currentX = INT(DetachedMiniButtonsData[_realm][_player][framename][_LASTX_]);
					frame.currentY = INT(DetachedMiniButtonsData[_realm][_player][framename][_LASTY_]);
					frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT",frame.currentX,frame.currentY);		
				    DetachedMiniButtonsData[_realm][_player][framename][_LASTX_] = INT(frame:GetLeft());
					DetachedMiniButtonsData[_realm][_player][framename][_LASTY_] = INT(frame:GetTop());
				end;
			end;
		end;				
	end;
end

function DetachedMiniButtons_reset(list)
	for framename in list do
		if (DetachedMiniButtonsData[_realm][_player][framename]) then
			if (DetachedMiniButtonsData[_realm][_player][framename][_INITIALX_] and 
				DetachedMiniButtonsData[_realm][_player][framename][_INITIALY_]) then
		
				local frame = Sea.util.getValue(framename);
				if (frame) then
					frame:ClearAllPoints();									
					frame.currentX = RANGEX(INT(DetachedMiniButtonsData[_realm][_player][framename][_INITIALX_]));
					frame.currentY = RANGEY(INT(DetachedMiniButtonsData[_realm][_player][framename][_INITIALY_]));					
					frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT",frame.currentX,frame.currentY);				
					DetachedMiniButtonsData[_realm][_player][framename][_LASTX_] = INT(frame:GetLeft());						
					DetachedMiniButtonsData[_realm][_player][framename][_LASTY_] = INT(frame:GetTop());								
				end;
			end;
		end;				
	end;

end;

function DetachedMiniButtons_GetChildren(msg)
	local count = 0;
	local newlist = {};
	if (msg == nil) then
	 msg = "text";
	end;
	
	if (msg ~= "silent") then
		DEFAULT_CHAT_FRAME:AddMessage("Searching for new Minimap Buttons");
	end;
	
	if (Minimap.GetChildren) then
		local children = { Minimap:GetChildren()};
		if (children) then
			for _, child in children do
				if (child.GetName and child:GetName()) then
					local n = child:GetName();	
					local p = n;
					if isInclude(n) and not isExclude(n) then		
						n = DetachedMiniButtons_ResolveMask(n,child);						
						if (not _frameList[n]) then
							count = count + 1;
							newlist[n] = n;
							DetachedMiniButtons_AddFrameName(n,p);
						end
					end					
				end
			end
		end
	end
	
	if (MinimapBackdrop.GetChildren) then
		local children = { MinimapBackdrop:GetChildren()};
		if (children) then
			for _, child in children do
				if (child.GetName and child:GetName()) then
					local n = child:GetName();	
					local p = n;
					if isInclude(n) and not isExclude(n) then		
						n = DetachedMiniButtons_ResolveMask(n,child);						
						if (not _frameList[n]) then
							count = count + 1;
							newlist[n] = n;
							DetachedMiniButtons_AddFrameName(n,p);
						end
					end					
				end
			end
		end
	end

	if (count > 0) then
		if (msg ~= "silent") then
			DEFAULT_CHAT_FRAME:AddMessage("Found " .. count .. " new buttons");	
		end
		DetachedMiniButtons_setInitialRange(newlist);
		DetachedMiniButtons_setMovable(newlist);
		DetachedMiniButtons_rePosition(newlist);
	else
		if (msg ~= "silent") then
			DEFAULT_CHAT_FRAME:AddMessage("No new buttons found");	
		end;
	end
end

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------
function DetachedMiniButtons_Master_OnDragStart()
    if (DetachedMiniButtonsData[_realm][_player][_LOCK_]) then
		return;
	end;
	this.isMoving = true;
	this:StartMoving();
	--DEFAULT_CHAT_FRAME:AddMessage("NAME:" .. this:GetName());
end

function DetachedMiniButtons_Master_OnDragStop()
	this.isMoving = false;
	this:StopMovingOrSizing();
	local n = this:GetName();
	DetachedMiniButtonsData[_realm][_player][n][_LASTX_] = INT(this:GetLeft());
	DetachedMiniButtonsData[_realm][_player][n][_LASTY_] = INT(this:GetTop());	
end

function DetachedMiniButtons_OnUpdate()
	-- calculate the new position
	
	--DEFAULT_CHAT_FRAME:AddMessage("UPDATE");
	if (not _rescanned) then
		if ((GetTime() - _starttime) > 10) then
			_rescanned = true;
			--DetachedMiniButtons_GetChildren("silent");
			DetachedMiniButtons_DoInit();
			return;	
		end;
	end;
	local n = this:GetName();
	n = DetachedMiniButtons_Mask(n);
	if (not _frameList[n]) then
		return
	end;
	
	if (this.isMoving) then	
		local xpos,ypos = GetCursorPosition()
		local xmin,ymin = UIParent:GetLeft() , UIParent:GetBottom()
		
		local IconPosX = xpos / UIParent:GetEffectiveScale() - xmin
		local IconPosY = ypos / UIParent:GetEffectiveScale() - ymin
		IconPosY = IconPosY + (this:GetWidth() / 2);
		IconPosX = IconPosX - (this:GetWidth() / 2);
		
		--local k = 80;		
		--if (FullSizeButtons[this:GetName()]) then
		--	k = 85
		--end
	
		--xpos = xmin-xpos/UIParent:GetEffectiveScale() + 70
		--ypos = ypos/UIParent:GetEffectiveScale() - ymin - 70
		--local angle = math.deg(math.atan2(ypos,xpos))
		--xpos = -k * cos(angle) + Minimap:GetWidth() / 2
		--ypos = k * sin(angle) + Minimap:GetHeight() / 2
		--if (not DetachedMiniButtonsData[_realm][_player][_NODOCK_]) then
		--	if (math.abs(IconPosX - xpos) < 15) and (math.abs(IconPosY - ypos) < 15) then
		--		--DEFAULT_CHAT_FRAME:AddMessage("SNAP:");			
		--		IconPosX = xpos
		--		IconPosY = ypos
		--	end
		--end		
		this:ClearAllPoints();
		--DEFAULT_CHAT_FRAME:AddMessage(IconPosY);
		this:SetPoint("TOPLEFT",UIParent,"BOTTOMLEFT",INT(IconPosX), INT(IconPosY));								
		this.currentX = INT(this:GetLeft());
		this.currentY = INT(this:GetTop());
		
		if (n == "GameTimeFrame") then
		  this:SetFrameLevel(0);
		end;
		if (string.find(n,"RogueTracker")) then		
			this:SetFrameLevel(1);
		end;
		
	else		
		if ((this.currentX ~= INT(this:GetLeft())) and (this.currentY ~= INT(this:GetTop()))) then
			--DEFAULT_CHAT_FRAME:AddMessage("UPDATE:");
			this:ClearAllPoints();
			this:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT",this.currentX, this.currentY);	
			this.currentX = INT(this:GetLeft());
			this.currentY = INT(this:GetTop());
		end;	
	end;
end


