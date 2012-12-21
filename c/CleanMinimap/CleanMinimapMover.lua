--[[
    The movement/resizing code in here is largely borrowed from MoveAnything by Skrag
    $Id:$
--]]

local CMMM_DEBUG = 0;

-- Print Debug info
local function Print_Debug(s)
   if (CMMM_DEBUG == 1) then
      DEFAULT_CHAT_FRAME:AddMessage(s, 1, 1, 0)
   end
end

function CleanMinimapMover_SizingAnchor( button )
  local s, e = string.find( button:GetName(), "Resize_" )
  local anchorto = string.sub( this:GetName(), e + 1 );
  local anchor;

  if( anchorto == "LEFT" ) then anchor = "RIGHT";
  elseif( anchorto == "RIGHT" ) then anchor = "LEFT";
  elseif( anchorto == "TOP" ) then anchor = "BOTTOM";
  elseif( anchorto == "BOTTOM" ) then anchor = "TOP";
  end

  return anchorto, anchor;
end

function CleanMinimapMover_UpdatePosition( moveFrame )
  local x, y, parent;
  x = nil;
  y = nil;
  parent = nil;
  x, y   = CleanMinimapMover_GetRelativeBottomLeft( moveFrame.tagged );
  parent = CleanMinimapMover_GetParent( moveFrame.tagged );
  return x, y, parent;
end

function CleanMinimapMover_GetParent( frame )
  if( frame:GetParent() == nil ) then
    return UIParent;
  end

  return frame:GetParent();
end

function CleanMinimapMover_GetScale( frame )
  if( frame:GetScale() == nil ) then
    return UIParent:GetScale();
  end

  return frame:GetScale();
end


function CleanMinimapMover_GetRelativeBottomLeft( tagFrame )
  x = tagFrame:GetLeft();
  if( x ) then
    x = x - CleanMinimapMover_GetParent( tagFrame ):GetLeft() * CleanMinimapMover_GetScale( CleanMinimapMover_GetParent( tagFrame ) ) / CleanMinimapMover_GetScale( tagFrame );
  end
  y = tagFrame:GetBottom();
  if( y ) then
    y = y - CleanMinimapMover_GetParent( tagFrame ):GetBottom() * CleanMinimapMover_GetScale( CleanMinimapMover_GetParent( tagFrame ) ) / CleanMinimapMover_GetScale( tagFrame );
  end
  return x,y;
end


function CleanMinimapMover_Attach( moveFrame, tagFrame )
  if( moveFrame.tagged ) then
    CleanMinimapMover_Detach( moveFrame );
  end

  if( tagFrame.OnBeginMove ) then
    if( not tagFrame:OnBeginMove() ) then
      Print_Debug("aborting");
      CleanMinimapMover_Detach( moveFrame );
      return;
    end
  end

  local x, y, w, h;
  if( tagFrame:GetLeft() == nil ) then tagFrame:Show(); tagFrame:Hide(); end
  x = tagFrame:GetLeft() * CleanMinimapMover_GetScale( tagFrame ) / UIParent:GetScale();
  x = x - CleanMinimapMover_GetParent( tagFrame ):GetLeft() * CleanMinimapMover_GetScale( CleanMinimapMover_GetParent( tagFrame ) ) / UIParent:GetScale();
  y = tagFrame:GetBottom() * CleanMinimapMover_GetScale( tagFrame ) / UIParent:GetScale();
  y = y - CleanMinimapMover_GetParent( tagFrame ):GetBottom() * CleanMinimapMover_GetScale( CleanMinimapMover_GetParent( tagFrame ) ) / UIParent:GetScale();
  w = tagFrame:GetWidth() * CleanMinimapMover_GetScale( tagFrame ) / UIParent:GetScale();
  h = tagFrame:GetHeight() * CleanMinimapMover_GetScale( tagFrame ) / UIParent:GetScale();
  moveFrame:ClearAllPoints();
  moveFrame:SetPoint("BOTTOMLEFT", CleanMinimapMover_GetParent( tagFrame ):GetName(), "BOTTOMLEFT", x, y );
  moveFrame:SetWidth(w);
  moveFrame:SetHeight(h);
  moveFrame:SetFrameLevel( tagFrame:GetFrameLevel() + 1 );

  tagFrame:ClearAllPoints();
  tagFrame:SetPoint( "BOTTOMLEFT", moveFrame:GetName(), "BOTTOMLEFT", 0, 0 );

  moveFrame:Show();
  moveFrame.tagged = tagFrame;

  Print_Debug("Attached "..tagFrame:GetName().." to "..moveFrame:GetName().." x="..x.." y="..y.." w="..w.." h="..h);

end

function CleanMinimapMover_Detach( moveFrame )
  if( moveFrame.tagged ) then
    local x, y, parent = CleanMinimapMover_UpdatePosition( moveFrame );
    moveFrame.tagged:ClearAllPoints();
    moveFrame.tagged:SetPoint( "BOTTOMLEFT", parent:GetName(), "BOTTOMLEFT", x, y );
  end
  moveFrame:Hide();
  moveFrame.tagged = nil;
end


function CleanMinimapMover_OnSizeChanged( this )
  if( this.tagged ) then
    local s, w, h;
    if( this.SizingAnchor == "LEFT" or this.SizingAnchor == "RIGHT" ) then
      w = this:GetWidth();
      h = w * (this.tagged:GetHeight() / this.tagged:GetWidth());
      if( h < 16 ) then
        h = 16;
        w = h * (this.tagged:GetWidth() / this.tagged:GetHeight());
      end
    else
      h = this:GetHeight();
      w = h * (this.tagged:GetWidth() / this.tagged:GetHeight());
      if( w < 16 ) then
        w = 16;
        h = w * (this.tagged:GetHeight() / this.tagged:GetWidth());
      end
    end
    s = this:GetWidth() / this.tagged:GetWidth();
    s = s * UIParent:GetScale();

    this.tagged:SetScale( s );
    if( this.tagged.attachedChildren ) then
      for i, v in this.tagged.attachedChildren do
        v:SetScale( s );
      end
    end

    this:SetWidth( w );
    this:SetHeight( h );
    Print_Debug("size changed: s="..s.." w="..w.." h="..h);
  end
end

function CleanMinimapMover_StopMoving( frame )
  if( frame) then
    CleanMinimapMover_Detach( frame );
  end
end