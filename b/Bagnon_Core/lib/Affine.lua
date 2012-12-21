if Affine then return; end

Affine = {
	Transform = function(vList, xOff, yOff)
		assert(vList, "No vertex list given.")
		
		xOff = xOff or 0;
		yOff = yOff or 0;
		
		for _, vert in pairs(vList) do
			vert.x = vert.x + xOff
			vert.y = vert.y + yOff
		end
	end,
	
	Rotate = function(vList, angle)
		assert(vList, "No vertex list given.")
		
		angle = angle or 0;
		
		for _, vert in pairs(vList) do
			vert.x = vert.x * cos(angle) - vert.y * sin(angle)
			vert.y = vert.x * sin(angle) + vert.y * cos(angle)
		end
	end,
	
	Scale = function(vList, xScale, yScale)
		assert(vList, "No vertex list given.")
		
		xScale = xScale or 1;
		yScale = yScale or 1;
		
		for _, vert in pairs(vList) do
			vert.x = vert.x * xScale
			vert.y = vert.y * yScale
		end				
	end,
}