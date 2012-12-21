--[[---------------------------------------------------------------------------------
  General Library providing an alternate StartMoving() that allows you to
  specify a number of frames to snap-to when moving the frame around
  
  Example Usage:
  
	<OnLoad>
		this:RegisterForDrag("LeftButton")
	</OnLoad>
	<OnDragStart>										
		StickyFrames:StartMoving(this, {WatchDogFrame_player, WatchDogFrame_target, WatchDogFrame_party1, WatchDogFrame_party2, WatchDogFrame_party3, WatchDogFrame_party4},3,3,3,3)
	</OnDragStart>
	<OnDragStop>
		StickyFrames:StopMoving(this)
		StickyFrames:AnchorFrame(this)
	</OnDragStop>			
------------------------------------------------------------------------------------]]

--[[---------------------------------------------------------------------------------
  Class declaration, along with a temporary table to hold any existing OnUpdate 
  scripts.
------------------------------------------------------------------------------------]]

StickyFrames = {}
StickyFrames.scripts = {}

--[[---------------------------------------------------------------------------------
  StickyFrames:StartMoving() - Sets a custom OnUpdate for the frame so it follows
  the mouse and snaps to the frames you specify
  
	frame:	 	The frame we want to move.  Is typically "this"

	frameList: 	A integer indexed list of frames that the given frame should try to
				stick to.  These don't have to have anything special done to them,
				and they don't really even need to exist.  You can inclue the 
				moving frame in this list, it will be ignored.  This helps you 
				if you have a number of frames, just make ONE list to pass.
				
				{WatchDogFrame_player, WatchDogFrame_party1, .. WatchDogFrame_party4}

	left:		If your frame has a tranparent border around the entire frame 
				(think backdrops with borders).  This can be used to fine tune the
				edges when you're stickying groups.  Refers to any offset on the 
				LEFT edge of the frame being moved.
	
	top:		same
	right:		same
	bottom:		same
------------------------------------------------------------------------------------]]

function StickyFrames:StartMoving(frame, frameList, left, top, right, bottom)
	local x,y = GetCursorPosition()
	local aX,aY = frame:GetCenter()
	local aS = frame:GetEffectiveScale()
	
	aX,aY = aX*aS,aY*aS
	local xoffset,yoffset = (aX - x),(aY - y)
	self.scripts[frame] = frame:GetScript("OnUpdate")
	frame:SetScript("OnUpdate", self:GetUpdateFunc(frame, frameList, xoffset, yoffset, left, top, right, bottom))
end

--[[---------------------------------------------------------------------------------
  This stops the OnUpdate, leaving the frame at its last position.  This will
  leave it anchored to UIParent.  You can call StickyFrames:AnchorFrame() to 
  anchor it back "TOPLEFT" , "TOPLEFT" to the parent.
------------------------------------------------------------------------------------]]

function StickyFrames:StopMoving(frame)
	frame:SetScript("OnUpdate", self.scripts[frame])
	self.scripts[frame] = nil
end

--[[---------------------------------------------------------------------------------
  This can be called in conjunction with StickyFrames:StopMoving() to anchor the 
  frame right back to the parent, so you can manipulate its children as a group
  (This is useful in WatchDog)
------------------------------------------------------------------------------------]]

function StickyFrames:AnchorFrame(frame)
	local xA,yA = frame:GetCenter()
	local parent = frame:GetParent() or UIParent
	local xP,yP = parent:GetCenter()
	local sA,sP = frame:GetEffectiveScale(), parent:GetEffectiveScale()
	
	xP,yP = (xP*sP) / sA, (yP*sP) / sA

	local xo,yo = (xP - xA)*-1, (yP - yA)*-1
	
	frame:ClearAllPoints()
	frame:SetPoint("CENTER", parent, "CENTER", xo, yo)
end	


--[[---------------------------------------------------------------------------------
  Internal Functions -- Do not call these.
------------------------------------------------------------------------------------]]



--[[---------------------------------------------------------------------------------
  Returns an anonymous OnUpdate function for the frame in question.  Need
  to provide the frame, frameList along with the x and y offset (difference between
  where the mouse picked up the frame, and the insets (left,top,right,bottom) in the
  case of borders, etc.w
------------------------------------------------------------------------------------]]

function StickyFrames:GetUpdateFunc(frame, frameList, xoffset, yoffset, left, top, right, bottom)
	return function()	
		local x,y = GetCursorPosition()
		local s = frame:GetEffectiveScale()
		local sticky = nil
		
		x,y = x/s,y/s

		frame:ClearAllPoints()
		frame:SetPoint("CENTER", UIParent, "BOTTOMLEFT", x+xoffset, y+yoffset)
		
		for k,v in ipairs(frameList) do
			if frame ~= v then
				if self:Overlap(frame, v) then
					if self:SnapFrame(frame, v, left, top, right, bottom) then break end
				end
			end
		end
	end
end


--[[---------------------------------------------------------------------------------
  Internal debug function.
------------------------------------------------------------------------------------]]

function StickyFrames:debug(msg)
	DEFAULT_CHAT_FRAME:AddMessage("|cffffff00StickyFrames: |r"..tostring(msg))
end

--[[---------------------------------------------------------------------------------
  Determines the overlap between two frames.  Returns true if the frames
  overlap anywhere, or false if they don't.  Does not consider alpha on the edges of
  textures.  
------------------------------------------------------------------------------------]]
function StickyFrames:Overlap(frameA, frameB)
	local sA, sB = frameA:GetEffectiveScale(), frameB:GetEffectiveScale()
	return ((frameA:GetLeft()*sA) < (frameB:GetRight()*sB))
		and ((frameB:GetLeft()*sB) < (frameA:GetRight()*sA))
		and ((frameA:GetBottom()*sA) < (frameB:GetTop()*sB))
		and ((frameB:GetBottom()*sB) < (frameA:GetTop()*sA))
end

--[[---------------------------------------------------------------------------------
  This is called when finding an overlap between two sticky frame.  If frameA is near
  a sticky edge of frameB, then it will snap to that edge and return true.  If there
  is no sticky edge collision, will return false so we can test other frames for
  stickyness.
------------------------------------------------------------------------------------]]
function StickyFrames:SnapFrame(frameA, frameB, left, top, right, bottom)
	local sA, sB = frameA:GetEffectiveScale(), frameB:GetEffectiveScale()
	local xA, yA = frameA:GetCenter()
	local xB, yB = frameB:GetCenter()
	local hA, hB = frameA:GetHeight() / 2, ((frameB:GetHeight() * sB) / sA) / 2
	local wA, wB = frameA:GetWidth() / 2, ((frameB:GetWidth() * sB) / sA) / 2

	if not left then left = 0 end
	if not top then top = 0 end
	if not right then right = 0 end
	if not bottom then bottom = 0 end

	-- Lets translate B's coords into A's scale
	xB, yB = (xB*sB) / sA, (yB*sB) / sA

	local stickyAx, stickyAy = wA * 0.75, hA * 0.75
	local stickyBx, stickyBy = wB * 0.75, hB * 0.75

	-- Grab the edges of each frame, for easier comparison
	
	local lA, tA, rA, bA = frameA:GetLeft(), frameA:GetTop(), frameA:GetRight(), frameA:GetBottom()
	local lB, tB, rB, bB = frameB:GetLeft(), frameB:GetTop(), frameB:GetRight(), frameB:GetBottom()
	local snap = nil
	
	-- Translate into A's scale
	lB, tB, rB, bB = (lB * sB) / sA, (tB * sB) / sA, (rB * sB) / sA, (bB * sB) / sA

	-- Lets check for Left stickyness
	if lA > (rB - stickyAx) then
		-- If we are 5 pixels above or below the top of the sticky frame
		-- Snap to the top edge of it.
		if tA <= (tB + 5) and tA >= (tB - 5) then
			yA = (tB - hA)
		elseif bA <= (bB + 5) and bA >= (bB - 5) then 
			yA = (bB + hA)
		end

		-- Set the x sticky position
		xA = rB + (wA - left)
		
		-- Delay the snap until later
		snap = true		

		-- Check for Right stickyness
	elseif rA < (lB + stickyAx) then 
		-- If we are 5 pixels above or below the top of the sticky frame
		-- Snap to the top edge of it.
		if tA <= (tB + 5) and tA >= (tB - 5) then
			yA = (tB - hA)
		elseif bA <= (bB + 5) and bA >= (bB - 5) then 
			yA = (bB + hA)
		end

		-- Set the x sticky position
		xA = lB - (wA - right)
		
		-- Delay the snap until later
		snap = true		
	
	-- Bottom stickyness
	elseif bA > (tB - stickyAy) then
		
		-- If we are 5 pixels to the left or right of the sticky frame
		-- Snap to the edge of it.

		if lA <= (lB + 5) and lA >= (lB - 5) then
			xA = (lB + wA)
		elseif rA >= (rB - 5) and rA <= (rB + 5) then
			xA = (rB - wA)
		end
				
		-- Set the y sticky position
		yA = tB + (hA - bottom)
		
		-- Delay the snap
		snap = true
	
	elseif tA < (bB + stickyAy) then
		-- If we are 5 pixels to the left or right of the sticky frame
		-- Snap to the edge of it.
		if lA <= (lB + 5) and lA >= (lB - 5) then
			xA = (lB + wA)
		elseif rA >= (rB - 5) and rA <= (rB + 5) then
			xA = (rB - wA)
		end
			
		-- Set the y sticky position
		yA = bB - (hA - bottom)
		
		-- Delay the snap
		snap = true
	end

	if snap then
		frameA:ClearAllPoints()
		frameA:SetPoint("CENTER", UIParent, "BOTTOMLEFT", xA, yA)
		return true
	end
end