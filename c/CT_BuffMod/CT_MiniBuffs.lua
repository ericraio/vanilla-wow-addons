function GetStrTime(time)
	local min, sec;
	if ( time >= 60 ) then
		min = floor(time/60);
		sec = time - min*60;
	else
		sec = time;
		min = 0;
	end
	if ( sec <= 9 ) then sec = "0" .. sec; end
	if ( min <= 9 ) then min = "0" .. min; end
	return min .. ":" .. sec;
end

function CT_MiniBuffs_Update(elapsed)
	if ( elapsed ) then
		this.update = this.update + elapsed;
		if ( this.update < 1 ) then return; end
	end
	if ( elapsed ) then
		this.update = this.update - 1;
	end
	local i;
	for i = 0, 23, 1 do
		local filter, offset;
		if ( i <= 15 ) then
			filter = "HELPFUL";
			offset = 0;
		else
			filter = "HARMFUL";
			offset = 16;
		end
		local bIndex, untilCancelled = GetPlayerBuff( i-offset, filter );
		local buffname;
		if ( not CT_BuffNames[i] ) then
			buffname = CT_GetBuffName( "player", i-offset, filter );
			CT_BuffNames[i] = buffname;
		else
			buffname = CT_BuffNames[i];
		end
		if ( bIndex >= 0 ) then
			local timeLeft = GetPlayerBuffTimeLeft(bIndex);
			if ( floor(timeLeft) >= MinBuffDurationExpireMessage and not CT_ExpireBuffs[buffname] ) then
				CT_ExpireBuffs[buffname] = 1;
			end

			if ( timeLeft <= ExpireMessageTime and CT_ExpireBuffs[buffname] and CT_BuffIsDebuff(bIndex) == 0 ) then
				if ( CT_ShowExpire == 1 ) then
					if ( CT_PlaySound == 1 ) then
						PlaySound("TellMessage");
					end
					CT_BuffMod_AddToQueue(buffname);
					local message;
					if ( CT_PlayerSpells[buffname] and GetBindingKey("CT_RECASTBUFF") ) then
						message = format(ExpireMessageRecastString, buffname, GetBindingText(GetBindingKey("CT_RECASTBUFF"), "KEY_"));
					else
						message = format(ExpireMessageString, buffname);
					end
					ExpireMessageFrame:AddMessage(message, ExpireMessageColors["r"], ExpireMessageColors["g"], ExpireMessageColors["b"]);
				end
				CT_ExpireBuffs[buffname] = nil;
				CT_BuffNames[this:GetID()] = nil;
			end
		end
	end
end

CT_oldBuffButton_OnUpdate = BuffButton_OnUpdate;
function CT_newBuffButton_OnUpdate()
	CT_oldBuffButton_OnUpdate();
	local buffIndex = this.buffIndex;
	if ( buffIndex >= 0 ) then
		local timeLeft = GetPlayerBuffTimeLeft(buffIndex);
		getglobal(this:GetName() .. "Duration"):SetText(GetStrTime(floor(timeLeft)));
	end
end
BuffButton_OnUpdate = CT_newBuffButton_OnUpdate;