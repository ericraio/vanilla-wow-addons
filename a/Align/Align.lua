local grid
local boxSize = 32

function Grid_Show()
	if not grid then
        Grid_Create()
	elseif grid.boxSize ~= boxSize then
        grid:Hide()
        Grid_Create()
    else
		grid:Show()
	end
end

function Grid_Hide()
	if grid then
		grid:Hide()
	end
end

local isAligning = false
SLASH_TOGGLEGRID1 = "/align"
SlashCmdList["TOGGLEGRID"] = function(arg)
    if isAligning then
        Grid_Hide()
        isAligning = false
    else
        boxSize = (math.ceil((tonumber(arg) or boxSize) / 32) * 32)
    if boxSize > 128 then boxSize = 128 end    
        Grid_Show()
        isAligning = true
    end
end

function Grid_Create() 
	grid = CreateFrame('Frame', nil, UIParent) 
	grid.boxSize = boxSize 
	grid:SetAllPoints(UIParent) 

	local size = 2 
	local width = GetScreenWidth()
	local ratio = width / GetScreenHeight()
	local height = GetScreenHeight() * ratio

	local wStep = width / boxSize
	local hStep = height / boxSize

	for i = 0, boxSize do 
		local tx = grid:CreateTexture(nil, 'BACKGROUND') 
		if i == boxSize / 2 then 
			tx:SetTexture(1, 0, 0, 0.5) 
		else 
			tx:SetTexture(0, 0, 0, 0.5) 
		end 
		tx:SetPoint("TOPLEFT", grid, "TOPLEFT", i*wStep - (size/2), 0) 
		tx:SetPoint('BOTTOMRIGHT', grid, 'BOTTOMLEFT', i*wStep + (size/2), 0) 
	end 
	height = GetScreenHeight()
	
	do
		local tx = grid:CreateTexture(nil, 'BACKGROUND') 
		tx:SetTexture(1, 0, 0, 0.5)
		tx:SetPoint("TOPLEFT", grid, "TOPLEFT", 0, -(height/2) + (size/2))
		tx:SetPoint('BOTTOMRIGHT', grid, 'TOPRIGHT', 0, -(height/2 + size/2))
	end
	
	for i = 1, math.floor((height/2)/hStep) do
		local tx = grid:CreateTexture(nil, 'BACKGROUND') 
		tx:SetTexture(0, 0, 0, 0.5)
		
		tx:SetPoint("TOPLEFT", grid, "TOPLEFT", 0, -(height/2+i*hStep) + (size/2))
		tx:SetPoint('BOTTOMRIGHT', grid, 'TOPRIGHT', 0, -(height/2+i*hStep + size/2))
		
		tx = grid:CreateTexture(nil, 'BACKGROUND') 
		tx:SetTexture(0, 0, 0, 0.5)
		
		tx:SetPoint("TOPLEFT", grid, "TOPLEFT", 0, -(height/2-i*hStep) + (size/2))
		tx:SetPoint('BOTTOMRIGHT', grid, 'TOPRIGHT', 0, -(height/2-i*hStep + size/2))
		
	end
	
end