-- Do graph stuff
-- This should be a separate addon someday

GraphHandler = {};
GraphHandler.Legend = {};

GraphHandler.Legend.OnEnter = function()
   if( this.item or this.tooltop ) then
      GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
      if (this.item and this.item ~= "") then
	 GameTooltip:SetHyperlink("item:"..this.item);
      elseif (this.tooltip) then
	 GameTooltip:SetText(this.tooltip);
      end
   end
end

GraphHandler.Legend.OnLeave = function()
   if( this.item or this.tooltop ) then
      this.updateToolTip = nil;
      GameTooltip:Hide();
   end
end

GraphHandler.Legend.OnClick = function(button)
   if ( button == "LeftButton" ) then
      if( IsShiftKeyDown() and this.item ) then
	 GraphHandler.Legend.ChatLink(this.item, this.name, this.color);
      end
   end
end

GraphHandler.Legend.ChatLink = FishingBuddy.ChatLink;

GraphHandler.BAR = "BAR";
GraphHandler.LEGEND = "LEGEND";
GraphHandler.LINE = "LINE";
GraphHandler.LABEL = "LABEL";
GraphHandler.TEXT = "TEXT";

GraphHandler.InitElements = function()
   if ( not this.elements ) then
      this.elements = {};
      this.elements[GraphHandler.BAR] = {};
      this.elements[GraphHandler.LINE] = {};
      this.elements[GraphHandler.LEGEND] = {};
      this.elements[GraphHandler.LABEL] = {};
      this.elements[GraphHandler.TEXT] = {};
   end
end

local function SetColorBar(bar, base, x, y, width, height, r, g, b)
   local name;
   if ( type(bar) == "STRING" ) then
      name = bar;
      bar = getglobal(name);
   elseif ( bar ) then
      name = bar:GetName();
   end
   if ( bar ) then
      if ( not r ) then
	 r = 1.0;
	 g = 1.0;
	 b = 1.0;
      end
      if ( base ) then
	 local tex = getglobal(name.."Texture");
	 if ( x and y ) then
	    bar:ClearAllPoints();
	    bar:SetPoint("BOTTOMLEFT", base, "BOTTOMLEFT", x, y);
	 end
	 if ( width ) then
	    bar:SetWidth(width);
	 end
	 if ( height ) then
	    bar:SetHeight(height);
	 end
	 tex:SetVertexColor(r, g, b);
	 bar:Show();
      else
	 bar:Hide();
      end
   end
end

-- Registration functions

GraphHandler.Register = function(kind, what)
   local frame = this;
   local lastframe = nil;
   for idx=1,5 do
      frame = frame:GetParent();
      if ( frame == lastframe ) then
	 break;
      end
      if ( frame and frame.elements ) then
	 if ( not frame.elements[kind] ) then
	    frame.elements[kind] = {};
	 end
	 tinsert(frame.elements[kind], what);
	 break;
      end
      lastframe = frame;
   end
end

GraphHandler.PlotData = function(frame, data, offset, skip, r, g, b)
  local limit = table.getn(data);
  local start = 1;
  if ( data[0] ) then
     start = 0;
     limit = limit - 1;
  end

  local bdx=offset+1;
  local bwid = frame.barWidth;
  local bspc = frame.barSpacing;
  local maxval = frame.maxVal;
  local xoff = offset*bspc;
  local yoff = 0;
  local graphHeight = frame:GetHeight();
  for idx=start,limit,1 do
     local bar = frame.elements[GraphHandler.BAR][bdx];
     bdx = bdx + skip + 1;
     if ( bar ) then
	if ( (maxval > 0) and (data[idx] > 0) ) then
	   local height = (data[idx]*graphHeight)/maxval;
	   SetColorBar(bar, frame, xoff, 0, bwid, height, r, g, b);
	else
	   bar:Hide();
	end
     end
     xoff = xoff + bwid + skip*bspc;
  end
  return xoff - skip*bspc;
end

GraphHandler.PlotLegend = function(frame, ldx, name, item, texture, r, g, b)
   local legend = frame.elements[GraphHandler.LEGEND][ldx];
    if ( legend ) then
      local name = legend:GetName();
      local icon = getglobal(name.."Icon");
      local tex = getglobal(name.."IconTexture");
      local color = getglobal(name.."Color");
--      SetColorBar(color, legend, nil, nil, nil, nil, r, g, b);
      SetColorBar(color, legend, 0, 1, 10, 16, r, g, b);
      icon:Show();
      tex:SetTexture(texture);
      tex:Show();
      legend:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, -(ldx-1)*21);
      legend.item = item;
      legend.name = name;
      legend:Show();
   end
end

GraphHandler.PlotGrid = function(frame, label, texth, width, textv, height)
   local ldx=1;
   local tdx=1;
   if ( not width ) then
      width = frame:GetWidth();
   end
   if ( not height ) then
      height = frame:GetHeight();
   end
   if ( label ) then
      local button = frame.elements[GraphHandler.TEXT][tdx];
      if ( button ) then
	 local text = getglobal(button:GetName().."T");
	 text:SetText(label);
	 text:SetPoint("BOTTOM", frame, "BOTTOM", 0, -28);
	 text:SetVertexColor(1.0, 1.0, 1.0);
	 text:Show();
	 tdx = tdx + 1;
      end
   end
   if ( texth ) then
      local linesh = 0;
      for _,_ in texth do
	 linesh = linesh + 1;
      end
      local offset = height/(linesh-1);
      for label,tick in texth do
	 local line = frame.elements[GraphHandler.LINE][ldx];
	 if ( line ) then
	    ldx = ldx + 1;
	    line:SetHeight(1);
	    line:SetWidth(width);
	    line:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, tick*offset);
	    line:SetAlpha(0.5);
	    line:Show();
	    local button = frame.elements[GraphHandler.TEXT][tdx];
	    if ( button ) then
	       local text = getglobal(button:GetName().."T");
	       if ( type(label) ~= "string" ) then
		  label = string.format("%3d", label);
	       end
	       text:SetText(label);
	       text:SetPoint("LEFT", line, "LEFT", -(text:GetWidth()+4), 0);
	       tdx = tdx + 1;
	    end
	 end
      end
   end
   if ( textv ) then
      local linesv = 0;
      for _,_ in textv do
	 linesv = linesv + 1;
      end
      local offset = frame.barSpacing + frame.barWidth;
      for label,tick in textv do
	 local line = frame.elements[GraphHandler.LINE][ldx];
	 if ( line ) then
	    local xpos = tick*offset;
	    ldx = ldx + 1;
	    line:SetHeight(height);
	    line:SetWidth(1);
	    line:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", xpos, 0);
	    line:SetAlpha(0.5);
	    line:Show();
	    local button = frame.elements[GraphHandler.TEXT][tdx];
	    if ( button ) then
	       local text = getglobal(button:GetName().."T");
	       if ( type(label) ~= "string" ) then
		  label = string.format("%3d", label);
	       end
	       text:SetText(label);
	       local wid = text:GetWidth();
	       if ( xpos < wid ) then
		  text:SetPoint("TOPLEFT", line, "BOTTOMLEFT", 0, -4);
	       elseif ( xpos > (width - wid) ) then
		  text:SetPoint("TOPRIGHT", line, "BOTTOMRIGHT", 0, -4);
	       else
		  text:SetPoint("TOP", line, "BOTTOM", 0, -4);
	       end
	       tdx = tdx + 1;
	    end
	 end
      end
   end
end
