function Moog_MobHealth_PPP( index )
  if  MobHealth_PPP  then
    return MobHealth_PPP( index );
  else
	if( index and MobHealthDB[index] ) then
		local s, e, pts, pct = string.find(MobHealthDB[index], "^(%d+)/(%d+)$");
		if( pts and pct ) then
			pts = pts + 0;
			pct = pct + 0;
			if( pct ~= 0 ) then
				return pts / pct;
			end
		end
	end
	return 0;
  end
end  -- of My_MobHealth_PPP

function Moog_MobHealth_GetTargetCurHP()
  if  MobHealth_GetTargetCurHP  then
	if MobHealth_GetTargetCurHP() then
		return MobHealth_GetTargetCurHP();
	else
		return UnitHealth("target");
	end
  else
    local name  = UnitName("target");
    local level = UnitLevel("target");
    local healthPercent = UnitHealth("target");
    if  name  and  level  and  healthPercent  then
      local index = name..":"..level;
      local ppp = Moog_MobHealth_PPP( index );
      return math.floor( healthPercent * ppp + 0.5);
    end
  end
  return 0;
end  -- of My_MobHealth_GetTargetCurHP()

function Moog_MobHealth_GetTargetMaxHP()
  if  MobHealth_GetTargetMaxHP  then
	if MobHealth_GetTargetMaxHP() then
		return MobHealth_GetTargetMaxHP();
	else
		return 100;
	end
  else
    local name  = UnitName("target");
    local level = UnitLevel("target");
    if  name  and  level  then
      local index = name..":"..level;
      local ppp = Moog_MobHealth_PPP( index );
      return math.floor( 100 * ppp + 0.5);
    end
  end
  return 0;
end  -- of My_MobHealth_GetTargetMaxHP()
