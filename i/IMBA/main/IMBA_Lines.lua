IMBA_Lines={};
IMBA_Line_Data={};
IMBA_LINE_DATA_SX	=	1
IMBA_LINE_DATA_SY	=	2
IMBA_LINE_DATA_EX	=	3
IMBA_LINE_DATA_EY	=	4
IMBA_LINE_DATA_WIDTH	=	5
IMBA_LINE_DATA_COLOR	=	6

--Copied from Blizzard's TaxiFrame code and modifed for IMBA

-- The following function is used with permission from Daniel Stephens <iriel@vigilance-committee.org>
TAXIROUTE_LINEFACTOR = 32/30; -- Multiplying factor for texture coordinates
TAXIROUTE_LINEFACTOR_2 = TAXIROUTE_LINEFACTOR / 2; -- Half o that

-- T        - Texture
-- C        - Canvas Frame (for anchoring)
-- sx,sy    - Coordinate of start of line
-- ex,ey    - Coordinate of end of line
-- w        - Width of line
-- relPoint - Relative point on canvas to interpret coords (Default BOTTOMLEFT)
--/script IMBA_DrawLine(IMBA_Ouro,0,0,-200,-200,32)
function IMBA_DrawLine(C, sx, sy, ex, ey, w, color)
   local T, lineNum, relPoint;
   if (not relPoint) then relPoint = "BOTTOMLEFT"; end

   if not IMBA_Lines[C:GetName()] then
	IMBA_Lines[C:GetName()]={};	
   end

   if not IMBA_Line_Data[C:GetName()] then
	IMBA_Line_Data[C:GetName()]={};
   end

   T=nil;

   for k,v in IMBA_Lines[C:GetName()] do
	if not v:IsShown() and not T then
		T=v;
		lineNum=k;
		T:Show();		
	end
   end

	if not T then
		T=C:CreateTexture(C:GetName().."_Line"..(getn(IMBA_Lines[C:GetName()])+1), "ARTWORK");
		--T:SetTexture("Interface\\AddOns\\Whiteboard\\textures\\line");
		T:SetTexture("Interface\\AddOns\\IMBA\\textures\\line");
		tinsert(IMBA_Lines[C:GetName()],T);
		tinsert(IMBA_Line_Data[C:GetName()],{sx,sy,ex,ey,w,{color[1],color[2],color[3],color[4]}});
	else
		IMBA_Line_Data[C:GetName()][lineNum]={sx,sy,ex,ey,w,{color[1],color[2],color[3],color[4]}};
	end

	T:SetVertexColor(color[1],color[2],color[3],color[4]);
   -- Determine dimensions and center point of line
   local dx,dy = ex - sx, ey - sy;
   local cx,cy = (sx + ex) / 2, (sy + ey) / 2;

   -- Normalize direction if necessary
   if (dx < 0) then
      dx,dy = -dx,-dy;
   end

   -- Calculate actual length of line
   local l = sqrt((dx * dx) + (dy * dy));

   -- Quick escape if it's zero length
   if (l == 0) then
      T:SetTexCoord(0,0,0,0,0,0,0,0);
      T:SetPoint("BOTTOMLEFT", C, relPoint, cx,cy);
      T:SetPoint("TOPRIGHT",   C, relPoint, cx,cy);
      return;
   end

   -- Sin and Cosine of rotation, and combination (for later)
   local s,c = -dy / l, dx / l;
   local sc = s * c;

   -- Calculate bounding box size and texture coordinates
   local Bwid, Bhgt, BLx, BLy, TLx, TLy, TRx, TRy, BRx, BRy;
   if (dy >= 0) then
      Bwid = ((l * c) - (w * s)) * TAXIROUTE_LINEFACTOR_2;
      Bhgt = ((w * c) - (l * s)) * TAXIROUTE_LINEFACTOR_2;
      if w>64 then
	Bwid=Bwid*1.05;
	Bhgt=Bhgt*1.05;
      end
      if w>128 then
	Bwid=Bwid*1.05;
	Bhgt=Bhgt*1.05;
      end
      BLx, BLy, BRy = (w / l) * sc, s * s, (l / w) * sc;
      BRx, TLx, TLy, TRx = 1 - BLy, BLy, 1 - BRy, 1 - BLx; 
      TRy = BRx;
   else
      Bwid = ((l * c) + (w * s)) * TAXIROUTE_LINEFACTOR_2;
      Bhgt = ((w * c) + (l * s)) * TAXIROUTE_LINEFACTOR_2;
      if w>64 then
	Bwid=Bwid*1.05;
	Bhgt=Bhgt*1.05;
      end
      BLx, BLy, BRx = s * s, -(l / w) * sc, 1 + (w / l) * sc;
      BRy, TLx, TLy, TRy = BLx, 1 - BRx, 1 - BLx, 1 - BLy;
      TRx = TLy;
   end

   -- Set texture coordinates and anchors
   T:ClearAllPoints();
   T:SetTexCoord(TLx, TLy, BLx, BLy, TRx, TRy, BRx, BRy);
   T:SetPoint("BOTTOMLEFT", C, relPoint, cx - Bwid, cy - Bhgt);
   T:SetPoint("TOPRIGHT",   C, relPoint, cx + Bwid, cy + Bhgt);

   return T:GetName();
end

function IMBA_ClearLines(C)
	if not IMBA_Lines then
		IMBA_Lines={};
	end
	if not IMBA_Lines[C:GetName()] then
		IMBA_Lines[C:GetName()]={};
	end
	for k,v in IMBA_Lines[C:GetName()] do
		v:Hide();
	end
	
end

function IMBA_EraseLines(C,x,y,r)
	local Dist, xDiff, yDiff;
	r=r*r;
	if not IMBA_Lines[C:GetName()] then
		IMBA_Lines[C:GetName()]={};
		IMBA_Line_Data[C:GetName()]={};
	end
	for k,v in IMBA_Line_Data[C:GetName()] do
		if IMBA_Lines[C:GetName()][k]:IsShown() then
			xDiff=x-v[1];
			yDiff=y-v[2];
			Dist=xDiff*xDiff+yDiff*yDiff
			if Dist<r then
				IMBA_Lines[C:GetName()][k]:Hide();
			else
				xDiff=x-v[3];
				yDiff=y-v[4];
				Dist=xDiff*xDiff+yDiff*yDiff
				if Dist<r then
					IMBA_Lines[C:GetName()][k]:Hide();
				end
			end
		end
	end
end

function IMBA_CompareColors(C1,C2)
	if getn(C1)~=getn(C2) then
		return false
	end
	for i=1,getn(C1),1 do
		if C1[i]~=C2[i] then
			return false
		end
	end
	return true
end

function IMBA_CreateSaveImage(C)
	local ImageStrokes={};
	if not IMBA_Line_Data then
		return nil
	end

	if not IMBA_Line_Data[C:GetName()] then
		return nil;
	end

	for k,v in IMBA_Line_Data[C:GetName()] do
		local AddedLine
		AddedLine=false;
		if IMBA_Lines[C:GetName()][k]:IsShown() then
			for k2, Stroke in ImageStrokes do
				if not AddedLine and IMBA_CompareColors(Stroke.Color,v[IMBA_LINE_DATA_COLOR]) and (Stroke.Width==v[IMBA_LINE_DATA_WIDTH]) then
					if (v[IMBA_LINE_DATA_SX]==Stroke.x[getn(Stroke.x)]) and (v[IMBA_LINE_DATA_SY]==Stroke.y[getn(Stroke.y)]) and not ((v[IMBA_LINE_DATA_SX]==v[IMBA_LINE_DATA_EX]) and (v[IMBA_LINE_DATA_SY]==v[IMBA_LINE_DATA_EY])) then

						tinsert(Stroke.x,v[IMBA_LINE_DATA_EX])
						tinsert(Stroke.y,v[IMBA_LINE_DATA_EY])
						AddedLine=true;
					end
				end
			end

			if not AddedLine then
				tinsert(ImageStrokes,{Color=v[IMBA_LINE_DATA_COLOR],Width=v[IMBA_LINE_DATA_WIDTH],x={v[IMBA_LINE_DATA_SX],v[IMBA_LINE_DATA_EX]},y={v[IMBA_LINE_DATA_SY],v[IMBA_LINE_DATA_EY]}});
			end
		end
	end

	return ImageStrokes
end

function IMBA_DrawSavedImage(C,Image)
	if not Image then
		return
	end
	for k, Stroke in Image do
		local lines;
		lines=getn(Stroke.x)-1;
		for i=1,lines,1 do
			IMBA_DrawLine(C, Stroke.x[i], Stroke.y[i], Stroke.x[i+1], Stroke.y[i+1], Stroke.Width, Stroke.Color)
		end
	end
end

local IMBA_Stroke={}

function IMBA_EndStroke(canvas)	
	local canvasN=canvas:GetName();
	if IMBA_Stroke[canvasN] then
		local Message,num;
		num=getn(IMBA_Stroke[canvasN].vert);

		Message=string.format("DRAWSTROKE %.2f %.2f %.2f %.2f %.1f %d ",IMBA_Stroke[canvasN].color[1],IMBA_Stroke[canvasN].color[2],IMBA_Stroke[canvasN].color[3],IMBA_Stroke[canvasN].color[4],IMBA_Stroke[canvasN].width,num)
		for i=1,num do
			Message=Message..string.format("a %.1f %.1f ",IMBA_Stroke[canvasN].vert[i][1],IMBA_Stroke[canvasN].vert[i][2]);
		end
		if canvas:GetName()=="Whiteboard" then
			IMBA_AddMsg("IMBA_LINES_"..canvasN,Message,"GUILD");
		else
			if IMBA_IsPlayerALeader() then
				if GetNumRaidMembers()>0 then
					IMBA_AddMsg("IMBA_LINES_"..canvasN,Message,"RAID");
				else
					IMBA_AddMsg("IMBA_LINES_"..canvasN,Message,"PARTY");
				end				
			end
		end
		IMBA_Stroke[canvasN]=nil
	end
end

function IMBA_AddToStroke(canvas, x,y)	
	tinsert(IMBA_Stroke[canvas:GetName()].vert,{x,y})
	if getn(IMBA_Stroke[canvas:GetName()].vert)>=10 then
		IMBA_EndStroke(canvas)
	end
end

function IMBA_StartStroke(canvas,color,width,sx,sy,ex,ey)
	local canvasN=canvas:GetName();
	IMBA_Stroke[canvasN]={}
	IMBA_Stroke[canvasN].color=color
	IMBA_Stroke[canvasN].width=width
	IMBA_Stroke[canvasN].vert={};
	tinsert(IMBA_Stroke[canvasN].vert,{sx,sy})
	tinsert(IMBA_Stroke[canvasN].vert,{ex,ey})
end

function IMBA_StrokeStarted(canvas)
	if IMBA_Stroke[canvas:GetName()] then
		return true
	end
	return false
end

function IMBA_SendSavedImage(C,Image)
	if IMBA_IsPlayerALeader() or (C:GetName()=="Whiteboard")  then
		if C:GetName()=="Whiteboard" then
			IMBA_AddMsg("IMBA_LINES_"..canvasN,Message,"GUILD");
		else
			if GetNumRaidMembers()>0 then
				IMBA_AddMsg("IMBA_LINES_"..C:GetName(),"ERASEALL","RAID");
			else
				IMBA_AddMsg("IMBA_LINES_"..C:GetName(),"ERASEALL","PARTY");
			end
		end
		for k, Stroke in Image do
			local lines;
			lines=getn(Stroke.x)-1;
			for i=1,lines,1 do
				if IMBA_StrokeStarted(C) then
					IMBA_AddToStroke(C,Stroke.x[i+1], Stroke.y[i+1]);
				else
					IMBA_StartStroke(C,Stroke.Color,Stroke.Width,Stroke.x[i], Stroke.y[i], Stroke.x[i+1], Stroke.y[i+1])
				end
				IMBA_EndStroke(C);
			end
		end
	end
end

function IMBA_LineMsgHandler(canvas)	
	if arg1=="IMBA_LINES_"..canvas:GetName() and arg4~=UnitName("player") then
		
		for sx, sy, ex, ey, r, g, b, a in string.gfind(arg2, "DRAWLINE (%d+.?%d*) (%d+.?%d*) (%d+.?%d*) (%d+.?%d*) (%d+.?%d*) (%d+.?%d*) (%d+.?%d*) (%d+.?%d*)") do
			IMBA_DrawLine(canvas,sx,sy,ex,ey,32,{r,g,b,a})
		end

		for x,y in string.gfind(arg2, "ERASE (%d+.?%d*) (%d+.?%d*)") do
			IMBA_EraseLines(canvas,x,y,12);
		end
		
		if string.find(arg2,"DRAWSTROKE") then
			local _,_, r, g, b, a, w, n, px, py, rest = string.find(arg2, "DRAWSTROKE (%d+.?%d*) (%d+.?%d*) (%d+.?%d*) (%d+.?%d*) (%d+.?%d*) (%d+) a (%d+.?%d*) (%d+.?%d*) (.*)");
			local x, y
			for x, y in string.gfind(rest,"a (%d+.?%d*) (%d+.?%d*)") do
				IMBA_DrawLine(canvas,px,py,x,y,tonumber(w),{r,g,b,a});
				px=x;
				py=y;
			end
		end

		if string.find(arg2,"ERASEALL") then
			IMBA_ClearLines(canvas);
		end
	end
end