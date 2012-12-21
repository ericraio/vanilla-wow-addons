ResizeableFrame={}

ResizeableFrame.dragTop = nil
ResizeableFrame.dragRight = nil
ResizeableFrame.dragottom = nil
ResizeableFrame.dragLeft = nil
ResizeableFrame.IncrementY = {}
ResizeableFrame.OffsetHeight={}
ResizeableFrame.MinHeight={}
ResizeableFrame.MaxHeight={}
ResizeableFrame.MinWidth={}
ResizeableFrame.MaxWidth={}
ResizeableFrame.FrameBorderSize={}
ResizeableFrame.DefaultMinHeight=30
ResizeableFrame.DefaultMaxHeight=600
ResizeableFrame.DefaultMinWidth=30
ResizeableFrame.DefaultMaxWidth=600

function ResizeableFrame:OnMouseDown()

	local effectiveScale = this:GetEffectiveScale();
	local x, y = GetCursorPosition()
	x=x/effectiveScale
	y=y/effectiveScale

	if (abs(x - this:GetRight()) < 10) then ResizeableFrame.dragRight = true
	elseif (abs(x - this:GetLeft()) < 10) then ResizeableFrame.dragLeft = true end

	if (abs(y - this:GetBottom()) < 10) then ResizeableFrame.dragBottom = true
	elseif (abs(y - this:GetTop()) < 10) then ResizeableFrame.dragTop = true end
	
	if (not ResizeableFrame.dragLeft and not ResizeableFrame.dragRight and not ResizeableFrame.dragBottom and not ResizeableFrame.dragTop) then
		this:StartMoving()
		this.isMoving = true
	else
		this.isResizing=true
	end

end

function ResizeableFrame:OnMouseUp()
	ResizeableFrame:OnDragStop()
end

function ResizeableFrame:OnDragStop()
	this:StopMovingOrSizing()
	this.isMoving = nil
	this.isResizing = nil
	ResizeableFrame.dragTop = nil
	ResizeableFrame.dragRight = nil
	ResizeableFrame.dragBottom = nil
	ResizeableFrame.dragLeft = nil
end

function ResizeableFrame:OnUpdate()

	if (not this.isResizing) then return end

	local effectiveScale = this:GetEffectiveScale()
	local x, y = GetCursorPosition()
	x=x/effectiveScale
	y=y/effectiveScale

	local top=this:GetTop()
	local right=this:GetRight()
	local bottom=this:GetBottom()
	local left=this:GetLeft()
	local BorderSize=ResizeableFrame:GetFrameBorderSize()
	
	local height,width
	
	if (ResizeableFrame.dragLeft) then left=x
	elseif (ResizeableFrame.dragRight) then right=x end

	if (ResizeableFrame.dragTop) then 
		height=y-bottom
		if(ResizeableFrame:GetHeightIncrement()>0) then 
			height=height-math.mod(height, ResizeableFrame:GetHeightIncrement())+BorderSize.top+BorderSize.bottom+ResizeableFrame:GetOffsetHeight()
		end
		top=bottom+height
	elseif (ResizeableFrame.dragBottom) then 
		height=top-y
		if (ResizeableFrame:GetHeightIncrement()>0) then
			height=height-math.mod(height, ResizeableFrame:GetHeightIncrement())+BorderSize.top+BorderSize.bottom+ResizeableFrame:GetOffsetHeight()
		end
	end

	width=right-left
	
	-- limit to min and max boundary
	if height then
		if (height<ResizeableFrame:GetMinHeight()) then	height=ResizeableFrame:GetMinHeight()
		elseif (height>ResizeableFrame:GetMaxHeight()) then height=ResizeableFrame:GetMaxHeight() end
	end

	if width then
		if (width<ResizeableFrame:GetMinWidth()) then width=ResizeableFrame:GetMinWidth()
		elseif (width>ResizeableFrame:GetMaxWidth()) then width=ResizeableFrame:GetMaxWidth() end
	end
	--------------------------------------

	-- refresh frame size and position
	this:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT",left,top);
	if height then this:SetHeight(height) end
	if width then this:SetWidth(width) end
	--------------------------------------
	
end

function ResizeableFrame:SetFrameBorderSize(top,right,bottom,left)
	ResizeableFrame.FrameBorderSize[this:GetName()]={top=top,right=right,bottom=bottom,left=left}
end

function ResizeableFrame:GetFrameBorderSize()
	local BorderSize=ResizeableFrame.FrameBorderSize[this:GetName()]
	if (not BorderSize.top) then BorderSize.top=0 end
	if (not BorderSize.right) then BorderSize.right=0 end
	if (not BorderSize.bottom) then BorderSize.bottom=0 end
	if (not BorderSize.left) then BorderSize.left=0 end
	return BorderSize
end

function ResizeableFrame:SetOffsetHeight(offsetHeight)
	ResizeableFrame.OffsetHeight[this:GetName()]=offsetHeight
end

function ResizeableFrame:GetOffsetHeight()
	if (ResizeableFrame.OffsetHeight[this:GetName()]) then
		return ResizeableFrame.OffsetHeight[this:GetName()]
	else
		return 0
	end
end

function ResizeableFrame:SetHeightIncrement(increment)
	ResizeableFrame.IncrementY[this:GetName()]=increment
end

function ResizeableFrame:GetHeightIncrement()
	if (ResizeableFrame.IncrementY[this:GetName()]) then
		return ResizeableFrame.IncrementY[this:GetName()]
	else
		return 0
	end
end

function  ResizeableFrame:SetMinHeight(height)
	ResizeableFrame.MinHeight[this:GetName()]=height
end

function  ResizeableFrame:SetMaxHeight(height)
	ResizeableFrame.MaxHeight[this:GetName()]=height
end

function  ResizeableFrame:GetMinHeight()
	if (ResizeableFrame.MinHeight[this:GetName()]) then
		return ResizeableFrame.MinHeight[this:GetName()]
	else
		return ResizeableFrame.DefaultMinHeight
	end
end

function  ResizeableFrame:GetMaxHeight()
	if (ResizeableFrame.MaxHeight[this:GetName()]) then
		return ResizeableFrame.MaxHeight[this:GetName()]
	else
		return ResizeableFrame.DefaultMaxHeight
	end
end

function  ResizeableFrame:SetMinWidth(width)
	ResizeableFrame.MinWidth[this:GetName()]=width
end

function  ResizeableFrame:SetMaxWidth(width)
	ResizeableFrame.MaxWidth[this:GetName()]=width
end

function  ResizeableFrame:GetMinWidth()
	if (ResizeableFrame.MinWidth[this:GetName()]) then
		return ResizeableFrame.MinWidth[this:GetName()]
	else
		return ResizeableFrame.DefaultMinWidth
	end
end

function  ResizeableFrame:GetMaxWidth()
	if (ResizeableFrame.MaxWidth[this:GetName()]) then
		return ResizeableFrame.MaxWidth[this:GetName()]
	else
		return ResizeableFrame.DefaultMaxWidth
	end
end

