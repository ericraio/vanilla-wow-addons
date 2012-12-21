local locals = KC_ITEMS_LOCALS.modules.common

function KC_Common:Median(values)
	local num = getn(values)
	if (not values or num == 0) then return end
	sort(values)
	return (math.mod(num,2) == 1) and values[num/2 +.5] or self:Round((values[num/2] + values[num/2 +1]) / 2,3)
end

function KC_Common:WeightedAvg(new, old, nWeight, oWeight)
	if (old == 0) then return new end
	if (new == 0) then return old end
	return self:Round(new * nWeight + old * oWeight,3)
end

function KC_Common:Round(x, y)
	return floor(x * (10^(y or 0))) / (10^y) 
end

function KC_Common:Avg(values)
	local total = 0
	for i, v in ipairs(values) do total = total + v end
	return (total > 0) and self:Round(total / getn(values),3) or nil;
end

function KC_Common:ToHex(num)
	num = floor(num)
	return locals.hex[floor(num/16)+1]..locals.hex[mod(num,16)+1]
end

function KC_Common:GetHexCode(r, g, b, dec)
	r = dec and r * 255 or r
	g = dec and g * 255 or g
	b = dec and b * 255 or b
	return format("|cff%s%s%s", self:ToHex(r), self:ToHex(g), self:ToHex(b))
end

function KC_Common:BellCurve(values)
	if (not values or getn(values) == 0) then return; end
	if (getn(values) == 1) then return values[1]; end

	local avg = self:Avg(values)	
	local sd = self:StdDev(values, avg);

	sort(values);
	
	local lLimit = avg - (sd * 1.5);
	local hLimit = avg + (sd * 1.5);
	
	local lPass, hPass

	while (not lPass or not hPass) do
		lPass = (tonumber(values[1]) >= lLimit) and true or tremove(values,1)
		hPass = (tonumber(values[getn(values)]) <= hLimit) and true or tremove(values)
	end

	local median = self:Median(values)
	return median and floor(median) or nil;
end

function KC_Common:StdDev(values, avg)
	local num = 0

	for i,v in pairs(values) do
		num = num + ((v - avg)^2)	
	end

	num = num / getn(values);

	return floor(math.sqrt(num));
end
