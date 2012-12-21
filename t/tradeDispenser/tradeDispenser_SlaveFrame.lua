function tradeDispenserSlaveOnUpdate()
	local down, up, lag = GetNetStats();
	local LagTimer = floor(lag/1000); 
	if (LagTimer < 0.2) then LagTimer=0.2 end;
	
	if (not tD_Temp.isEnabled) then	return end
	
	if (tD_Temp.broadcastSlice > 0) then
		if (arg1~=nil) then
			tD_Temp.broadcastSlice = tD_Temp.broadcastSlice - arg1
		end
		if (tD_Temp.broadcastSlice < 0) then
			if (UnitAffectingCombat("player")==1) then
				-- player is in combat! tD should not spam its auto-broadcast while fighting some mobs!   (especially bossmobs)     - wait 15sec, and try again!
				tD_Temp.broadcastSlice = 15;
			else
				if (tD_CharDatas.AutoBroadcast) then tradeDispenserBroadcastItems() end
				tD_Temp.broadcastSlice = tD_CharDatas.broadcastSlice
			end
		end
	end
	
	if (arg1~=nil) then
		tD_Temp.timeSlice = tD_Temp.timeSlice - arg1
		
		if (tD_CharDatas.TimelimitCheck and tD_Temp.Countdown) then
			if (tD_Temp.Countdown>0) then 
				tD_Temp.Countdown=tD_Temp.Countdown - arg1; 
				if (math.floor(tD_Temp.Countdown)==11) then
					tradeDispenserMessage("WHISPER", tD_GlobalDatas.whisper[11]);
					tD_Temp.Countdown=tD_Temp.Countdown-1;
				end
				if (math.floor(tD_Temp.Countdown)==0) then
					tD_Temp.Target.Name=nil;
					tD_Temp.tradeState="timeup";
					tradeDispenserVerbose(1,"Timeup, close the trade");
					CloseTrade();
					tD_Temp.Countdown=tD_Temp.Countdown-1;
				end
				--tradeDispenserVerbose(0,"countdown: "..tD_Temp.Countdown);
			end
		end		
	end;
	if (tD_Temp.timeSlice > 0) then 	return end
	
	if (tD_Temp.tradeState == "populate") then
		tD_Temp.timeSlice = LagTimer
		tradeDispenserVerbose(1,"tradeDispenserSlaveOnUpdate: populate")
		
		if (tD_Temp.Slot[tD_Temp.tradeData.slotID]) then
			if (tD_Temp.tradeData.containerLocation == nil) then
				tradeDispenserVerbose(3,"Compile Item "..tD_Temp.tradeData.slotID)
				local cID, sID = tradeDispenserCompile(tD_Temp.tradeData.slotID)
				
				if (cID == "deadlink") then
					tradeDispenserVerbose(1,"deadlink")
					tD_Temp.tradeData.containerLocation=nil;
					tD_Temp.timeSlice = LagTimer*4
					tD_Temp.tradeState = "accept"
					tD_Temp.tradeData = false
					return
				elseif (cID==nil) then
					tradeDispenserMessage("WHISPER",tD_GlobalDatas.whisper[4])
					tradeDispenserMessage("SAY",tD_GlobalDatas.whisper[2])
					tD_Temp.timeSlice = LagTimer*4
					tD_Temp.tradeState = "accept"
					tD_Temp.tradeData = true
					return
				else
					tradeDispenserVerbose(2,"tradeDispenserOnUpdate: found container location")
					tD_Temp.tradeData.containerLocation = {}
					tD_Temp.tradeData.containerLocation.cID = cID
					tD_Temp.tradeData.containerLocation.sID = sID
				end
			end
				
			if (tD_Temp.tradeData.containerLocation) then
				local cID = tD_Temp.tradeData.containerLocation.cID
				local sID = tD_Temp.tradeData.containerLocation.sID
				
				local _, itemCount = GetContainerItemInfo(cID, sID)
				PickupContainerItem(cID, sID)
				
				if ( CursorHasItem() ) then
					tradeDispenserVerbose(3,"tradeDispenserSlaveOnUpdate: CursorHasItem()")
					ClickTradeButton(tD_Temp.tradeData.slotID)
					
					if (itemCount ~= tD_Temp.Slot[tD_Temp.tradeData.slotID].itemCount) then
						tradeDispenserMessage("WHISPER",tD_GlobalDatas.whisper[3], "WHISPER")
						tradeDispenserMessage("SAY",tD_GlobalDatas.whisper[2])
						
						tD_Temp.timeSlice = LagTimer*4
						tD_Temp.tradeState = "accept"
						tD_Temp.tradeData = true
						return
					end
					
					tD_Temp.tradeData.slotID = tD_Temp.tradeData.slotID + 1
					tD_Temp.tradeData.containerLocation = nil
					tD_Temp.tradeData.numAttempts = 0
				else
					tD_Temp.tradeData.numAttempts = tD_Temp.tradeData.numAttempts + 1
					if (tD_Temp.tradeData.numAttempts == 32) then
						tradeDispenserVerbose(2,"tradeDispenserOnUpdate: too many attempts")
						tradeDispenserMessage("WHISPER",tD_GlobalDatas.whisper[1]);
						CloseTrade()
						return
					end
				end
			end
		else
			--tradeDispenserVerbose(1,"tradeDispenserSlaveOnUpdate: ID ="..tD_Temp.tradeData.slotID)
			tD_Temp.tradeData.slotID = tD_Temp.tradeData.slotID + 1
			if (tD_Temp.tradeData.slotID >= 7) then
				tD_Temp.tradeState = "accept"
				tD_Temp.timeSlice = LagTimer*4
				tradeDispenserVerbose(1,"tradeDispenserSlaveOnUpdate: DONE")
				tD_Temp.tradeData = false
			end
		end
	elseif (tD_Temp.tradeState == "accept") then
		tD_Temp.timeSlice = 1000
		if (tD_CharDatas.AutoAccept) then tradeDispenserAccept() end
	end
	
end


function tradeDispenserBroadcastItems()
	if (tD_Temp.isEnabled) then
		
		local tradeDispenserChannel, temp = tradeDispenserGetChannel();
		if (tradeItems) then tradeDispenserVerbose(1,"tradeItems: "..tradeItems) end
		
		local x = math.random(1, tD_CharDatas.Random);
		local message="";
		if (strlen(tD_CharDatas.RndText[x])<=2) then
				message=tD_Loc.defaultBroadcast;
		else message=tD_CharDatas.RndText[x]  end
		tradeDispenserMessage(tradeDispenserChannel, message)
	end
end


function tradeDispenserGetChannel()
	local Channel="SAY";
	local ChannelLoc=tD_Loc.channel.say;
	if (tD_CharDatas.ChannelID) then
		if (tD_CharDatas.ChannelID==1) then Channel="SAY";  ChannelLoc=tD_Loc.channel.say  end
		if (tD_CharDatas.ChannelID==2) then Channel="YELL"; ChannelLoc=tD_Loc.channel.yell end
		if (tD_CharDatas.ChannelID==3) then --Channel="RAID"; ChannelLoc=tD_Loc.channel.raid 
			if (UnitInRaid("player")==1) 	 then Channel="RAID"; 		ChannelLoc=tD_Loc.channel.raid
			elseif (GetNumPartyMembers()>=1) then Channel="PARTY";	ChannelLoc=tD_Loc.channel.party
			else Channel="SAY"; 	ChannelLoc=tD_Loc.channel.say	end
		end
		if (tD_CharDatas.ChannelID==4) then --Channel="PARTY"; ChannelLoc=tD_Loc.channel.party 
			if ((GetNumPartyMembers()>=1)) then Channel="PARTY";	ChannelLoc=tD_Loc.channel.party 
			else Channel="SAY";		ChannelLoc=tD_Loc.channel.say end
		end
		if (tD_CharDatas.ChannelID==5) then Channel="GUILD";   ChannelLoc=tD_Loc.channel.guild  end
	end
	return Channel, ChannelLoc;
end


function tradeDispenserStartTimelimiter()
	tradeDispenserVerbose(2,"Countdown started: you've got "..tD_CharDatas.Timelimit.." sec to trade")
	tD_Temp.Countdown=tD_CharDatas.Timelimit+2
end
