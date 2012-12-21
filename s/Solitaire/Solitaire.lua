--[[
	Author: 		Jacob Bowers (Thronk on Mal'Ganis server)
	
]]


SolitaireOptions = {};

SolitaireCardArray = {value=0,suit=""};

SolitaireIndexToCardArray = {};
SolitaireSelectedCard = nil;

SolitaireStack2Num = 1;
SolitaireStack3Num = 2;
SolitaireStack4Num = 3;
SolitaireStack5Num = 4;
SolitaireStack6Num = 5;
SolitaireStack7Num = 6;

SolitaireSpareCardStack = {};
SolitaireSpareCardNum = 0;

SolitaireStack2 = {};
SolitaireStack3 = {};
SolitaireStack4 = {};
SolitaireStack5 = {};
SolitaireStack6 = {};
SolitaireStack7 = {};

SolitaireAcePile1 = {};
SolitaireAcePile1Num = 0;

SolitaireAcePile2 = {};
SolitaireAcePile2Num = 0;

SolitaireAcePile3 = {};
SolitaireAcePile3Num = 0;

SolitaireAcePile4 = {};
SolitaireAcePile4Num = 0;
SolitaireCurrentSpareCardIndex = 0;
SolitaireTimeCounter = 0;

DestinationCard = nil;
IsStackCard = nil;

function Solitaire_SetDragCard(id)

	if(id ~= nil) then
		SolitaireSelectedCard = id;
		getglobal("Solitaire_CardButton"..id.."CheckTexture"):SetTexture("Interface\\AddOns\\Solitaire\\Check");
		--DEFAULT_CHAT_FRAME:AddMessage("Solitaire Set Card: "..id.." Dest Card: "..DestinationCard);
	end
end

function Solitaire_PlaceDragCard()

	if(SolitaireSelectedCard ~= nil and DestinationCard ~= nil) then
		
		getglobal("Solitaire_CardButton"..SolitaireSelectedCard.."CheckTexture"):SetTexture("");

		if(SolitaireSelectedCard == DestinationCard) then
			SolitaireSelectedCard = nil;
			return;
		end

		if(IsStackCard) then
			Solitaire_StackButtonOnClick(DestinationCard);
		else
			Solitaire_OnClick(DestinationCard);
		end

	end

end

function Solitaire_StackPlaceDragCard()

	if(SolitaireSelectedCard ~= nil and DestinationCard ~= nil) then

		if(SolitaireSelectedCard == DestinationCard) then
			SolitaireSelectedCard = nil;
			return;
		end

		--DEFAULT_CHAT_FRAME:AddMessage("Selected card: "..SelectedCard.."Destination Card: "..DestinationCard);
		Solitaire_StackButtonOnClick(DestinationCard);
	end

	SolitaireSelectedCard = nil;
end


function Solitaire_SetCardArray()
	local i;
	local cnt;

	SolitaireCardArray = {};

	cnt = 1;
	for i=1,13 do
		SolitaireCardArray[i] = {value = cnt, suit = "Heart"};
		cnt = cnt + 1;
	end

	cnt = 1;
	for i=14,26 do
		SolitaireCardArray[i] = {value = cnt, suit = "Diamond"};
		cnt = cnt + 1;
	end

	cnt = 1;
	for i=27,39 do
		SolitaireCardArray[i] = {value = cnt, suit = "Club"};
		cnt = cnt + 1;
	end

	cnt = 1;
	for i=40,52 do
		SolitaireCardArray[i] = {value = cnt, suit = "Spade"};
		cnt = cnt + 1;
	end	

end


function Solitaire_RoundNumber(num) 
	return floor( num + 0.5 );
end


function Solitaire_ShuffleCardArray()
	local cnt;
	local rand1;
	local rand2;
	local tmp1, tmp2;

	for cnt=1,10000 do
		
		rand1 = 0;
		rand2 = 0;
		while ( rand1 == rand2 ) do
			rand1 = Solitaire_RoundNumber(random()*51 + 1);
			rand2 = Solitaire_RoundNumber(random()*51 + 1);
		end
		
		tmp1 = SolitaireCardArray[rand1].value;
		tmp2 =  SolitaireCardArray[rand1].suit;
		SolitaireCardArray[rand1].value = SolitaireCardArray[rand2].value;
		SolitaireCardArray[rand1].suit = SolitaireCardArray[rand2].suit;
		SolitaireCardArray[rand2].value = tmp1;
		SolitaireCardArray[rand2].suit = tmp2;
	end

	
end


--[[
function Solitaire_HideCards()
	local i;

	for i=1,91 do
		Solitaire_SetCard(i, 0);
	end
	
end
]]


function Solitaire_Init()
	local i;

	Solitaire_SetCardArray();
	Solitaire_ShuffleCardArray();
	
	SolitaireStack2[1] = 1;
	
	SolitaireStack3[1] = 2;
	SolitaireStack3[2] = 3;
	
	SolitaireStack4[1] = 4;
	SolitaireStack4[2] = 5;
	SolitaireStack4[3] = 6;
	
	SolitaireStack5[1] = 7;
	SolitaireStack5[2] = 8;
	SolitaireStack5[3] = 9;
	SolitaireStack5[4] = 10;

	SolitaireStack6[1] = 11;
	SolitaireStack6[2] = 12;
	SolitaireStack6[3] = 13;
	SolitaireStack6[4] = 14;
	SolitaireStack6[5] = 15;

	SolitaireStack7[1] = 16;
	SolitaireStack7[2] = 17;
	SolitaireStack7[3] = 18;
	SolitaireStack7[4] = 19;
	SolitaireStack7[5] = 20;
	SolitaireStack7[6] = 21;

	SolitaireStack2Num = 1;
	SolitaireStack3Num = 2;
	SolitaireStack4Num = 3;
	SolitaireStack5Num = 4;
	SolitaireStack6Num = 5;
	SolitaireStack7Num = 6;

	getglobal("SolitaireStackNum2"):SetText(1);
	getglobal("SolitaireStackNum3"):SetText(2);
	getglobal("SolitaireStackNum4"):SetText(3);
	getglobal("SolitaireStackNum5"):SetText(4);
	getglobal("SolitaireStackNum6"):SetText(5);
	getglobal("SolitaireStackNum7"):SetText(6);

	getglobal("Solitaire_StackButton1"):Hide();
	getglobal("Solitaire_StackButton2"):Hide();
	getglobal("Solitaire_StackButton3"):Hide();
	getglobal("Solitaire_StackButton4"):Hide();
	getglobal("Solitaire_StackButton5"):Hide();
	getglobal("Solitaire_StackButton6"):Hide();
	getglobal("Solitaire_StackButton7"):Hide();

	for i=1,91 do
		Solitaire_SetCard(i, 0)
		getglobal("Solitaire_CardButton"..i):SetHeight(90);
	end

	Solitaire_SetCard(92, 0, 1);
	Solitaire_SetCard(93, 0, 1);
	Solitaire_SetCard(94, 0, 1);
	Solitaire_SetCard(95, 0, 1);
	Solitaire_SetCard(96, 0, 1);

	SolitaireSelectedCard = nil;

	Solitaire_SetCard(1, 22);
	Solitaire_SetCard(14, 23);
	Solitaire_SetCard(27, 24);
	Solitaire_SetCard(40, 25);
	Solitaire_SetCard(53, 26);
	Solitaire_SetCard(66, 27);
	Solitaire_SetCard(79, 28);

	SolitaireCurrentSpareCardIndex = 0;
	SolitaireSpareCardNum = 0;
	for i=29,52 do
		SolitaireSpareCardNum = SolitaireSpareCardNum + 1;
		SolitaireSpareCardStack[SolitaireSpareCardNum] = i;
	end
	
	--DEFAULT_CHAT_FRAME:AddMessage(SolitaireSpareCardNum);
end


-- Checks whether a card can be placed on another card (not used when checking the validity of placing a card
-- on the ace pile).

function Solitaire_CheckRules( origid, destid )
	local origsuit, destsuit;
	local origval, destval;

	if ( origid == nil or destid == nil or origid < 1 or destid < 1 or origid == destid) then
		return nil;
	end
	
	if ( getglobal("Solitaire_CardButton"..(destid+1)):IsVisible() ) then
		return nil;
	end

	origsuit = SolitaireCardArray[SolitaireIndexToCardArray[origid]].suit;
	destsuit = SolitaireCardArray[SolitaireIndexToCardArray[destid]].suit;

	if ( origsuit == "Heart" or origsuit == "Diamond" ) then
		if ( destsuit == "Heart" or destsuit == "Diamond" ) then
			return nil;
		end
	elseif ( origsuit == "Club" or origsuit == "Spade" ) then
		if ( destsuit == "Club" or destsuit == "Spade" ) then
			return nil;
		end
	end

	origval = SolitaireCardArray[SolitaireIndexToCardArray[origid]].value;
	destval = SolitaireCardArray[SolitaireIndexToCardArray[destid]].value;

	if ( origval >= destval ) then
		return nil;
	end

	if ( destval - origval > 1 ) then
		return nil;
	end

	return 1;
end


-- Used to check if all the face up cards in a card pile have been moved, in which case, try and turn over the
-- next card in the face down pile of that stack. If there are no more cards, show a blank card (to indicate
-- where king cards may be relocated).

function Solitaire_CheckAndFlipStackCard()

	if ( getglobal("Solitaire_CardButton1"):IsVisible() == nil and getglobal("Solitaire_StackButton1"):IsVisible() == nil) then
		getglobal("Solitaire_StackButton1"):Show();
		--return;
	end
	
	if ( getglobal("Solitaire_CardButton14"):IsVisible() == nil and getglobal("Solitaire_StackButton2"):IsVisible() == nil) then
		
		if ( SolitaireStack2Num > 0 ) then

			Solitaire_SetCard(14, SolitaireStack2[SolitaireStack2Num]);
			SolitaireStack2Num = SolitaireStack2Num - 1;
			getglobal("SolitaireStackNum2"):SetText(SolitaireStack2Num);
			getglobal("Solitaire_CardButton14CheckTexture"):SetTexture("");
		else
			getglobal("Solitaire_StackButton2"):Show();
		end
	end

	if ( getglobal("Solitaire_CardButton27"):IsVisible() == nil and getglobal("Solitaire_StackButton3"):IsVisible() == nil) then
		
		if ( SolitaireStack3Num > 0 ) then

			Solitaire_SetCard(27, SolitaireStack3[SolitaireStack3Num]);
			SolitaireStack3Num = SolitaireStack3Num - 1;
			getglobal("SolitaireStackNum3"):SetText(SolitaireStack3Num);
			getglobal("Solitaire_CardButton27CheckTexture"):SetTexture("");
		else
			getglobal("Solitaire_StackButton3"):Show();
		end
	end

	if ( getglobal("Solitaire_CardButton40"):IsVisible() == nil and getglobal("Solitaire_StackButton4"):IsVisible() == nil) then
		
		if ( SolitaireStack4Num > 0 ) then

			Solitaire_SetCard(40, SolitaireStack4[SolitaireStack4Num]);
			SolitaireStack4Num = SolitaireStack4Num - 1;
			getglobal("SolitaireStackNum4"):SetText(SolitaireStack4Num);
			getglobal("Solitaire_CardButton40CheckTexture"):SetTexture("");
		else
			getglobal("Solitaire_StackButton4"):Show();
		end
	end

	if ( getglobal("Solitaire_CardButton53"):IsVisible() == nil and getglobal("Solitaire_StackButton5"):IsVisible() == nil) then
		
		if ( SolitaireStack5Num > 0 ) then

			Solitaire_SetCard(53, SolitaireStack5[SolitaireStack5Num]);
			SolitaireStack5Num = SolitaireStack5Num - 1;
			getglobal("SolitaireStackNum5"):SetText(SolitaireStack5Num);
			getglobal("Solitaire_CardButton53CheckTexture"):SetTexture("");
		else
			getglobal("Solitaire_StackButton5"):Show();
		end
	end

	if ( getglobal("Solitaire_CardButton66"):IsVisible() == nil and getglobal("Solitaire_StackButton6"):IsVisible() == nil) then
		
		if ( SolitaireStack6Num > 0 ) then

			Solitaire_SetCard(66, SolitaireStack6[SolitaireStack6Num]);
			SolitaireStack6Num = SolitaireStack6Num - 1;
			getglobal("SolitaireStackNum6"):SetText(SolitaireStack6Num);
			getglobal("Solitaire_CardButton66CheckTexture"):SetTexture("");
		else
			getglobal("Solitaire_StackButton6"):Show();
		end
	end

	if ( getglobal("Solitaire_CardButton79"):IsVisible() == nil and getglobal("Solitaire_StackButton7"):IsVisible() == nil) then
		
		if ( SolitaireStack7Num > 0 ) then

			Solitaire_SetCard(79, SolitaireStack7[SolitaireStack7Num]);
			SolitaireStack7Num = SolitaireStack7Num - 1;
			getglobal("SolitaireStackNum7"):SetText(SolitaireStack7Num);
			getglobal("Solitaire_CardButton79CheckTexture"):SetTexture("");
		else
			getglobal("Solitaire_StackButton7"):Show();
		end
	end

	Solitaire_RedrawCards();
end


-- HACK: button click zones don't occlude each other very well, so if a cardbutton is being covered by
-- another cardbutton, reduce its click zone.

--[[
function Solitaire_SetCardButtonHeights( origid )

	if ( origid >= 1 and origid <= 13 ) then

		for i= 1, 12 do

			if ( getglobal("Solitaire_CardButton"..(i+1)):IsVisible() ) then
				getglobal("Solitaire_CardButton"..i):SetHeight(14);
				getglobal("Solitaire_CardButton"..(i+1)):SetHeight(90);
				return;
			end		

			if ( getglobal("Solitaire_CardButton"..i):IsVisible() and i == 1 ) then
				getglobal("Solitaire_CardButton"..i):SetHeight(90);
			end
		end
	elseif ( origid >= 14 and origid <= 26 ) then

		for i= 14, 26 do

			if ( getglobal("Solitaire_CardButton"..(i+1)):IsVisible() ) then
				getglobal("Solitaire_CardButton"..i):SetHeight(14);
				getglobal("Solitaire_CardButton"..(i+1)):SetHeight(90);
				return;
			end		

			if ( getglobal("Solitaire_CardButton"..i):IsVisible() and i == 14 ) then
				getglobal("Solitaire_CardButton"..i):SetHeight(90);
			end	
		end
	elseif ( origid >= 27 and origid <= 39 ) then

		for i= 27, 39 do
			if ( getglobal("Solitaire_CardButton"..(i+1)):IsVisible() ) then
				getglobal("Solitaire_CardButton"..i):SetHeight(14);
				getglobal("Solitaire_CardButton"..(i+1)):SetHeight(90);
				return;
			end		

			if ( getglobal("Solitaire_CardButton"..i):IsVisible() and i == 27 ) then
				getglobal("Solitaire_CardButton"..i):SetHeight(90);
			end	
		end
	elseif ( origid >= 40 and origid <= 52 ) then

		for i= 40, 52 do

			if ( getglobal("Solitaire_CardButton"..(i+1)):IsVisible() ) then
				getglobal("Solitaire_CardButton"..i):SetHeight(14);
				getglobal("Solitaire_CardButton"..(i+1)):SetHeight(90);
				return;
			end		

			if ( getglobal("Solitaire_CardButton"..i):IsVisible() and i == 40 ) then
				getglobal("Solitaire_CardButton"..i):SetHeight(90);
			end
		end
	elseif ( origid >= 53 and origid <= 65 ) then

		for i= 53, 65 do
			if ( getglobal("Solitaire_CardButton"..(i+1)):IsVisible() ) then
				getglobal("Solitaire_CardButton"..i):SetHeight(14);
				getglobal("Solitaire_CardButton"..(i+1)):SetHeight(90);
				return;
			end		

			if ( getglobal("Solitaire_CardButton"..i):IsVisible() and i == 53 ) then
				getglobal("Solitaire_CardButton"..i):SetHeight(90);
			end
		end
	elseif ( origid >= 66 and origid <= 78 ) then

		for i= 66, 78 do
			if ( getglobal("Solitaire_CardButton"..(i+1)):IsVisible() ) then
				getglobal("Solitaire_CardButton"..i):SetHeight(14);
				getglobal("Solitaire_CardButton"..(i+1)):SetHeight(90);
				return;
			end		

			if ( getglobal("Solitaire_CardButton"..i):IsVisible() and i == 66 ) then
				getglobal("Solitaire_CardButton"..i):SetHeight(90);
			end		
		end
	elseif ( origid >= 79 and origid <= 91 ) then

		for i= 79, 91 do
			if ( getglobal("Solitaire_CardButton"..(i+1)):IsVisible() ) then
				getglobal("Solitaire_CardButton"..i):SetHeight(14);
				getglobal("Solitaire_CardButton"..(i+1)):SetHeight(90);
				return;
			end		

			if ( getglobal("Solitaire_CardButton"..i):IsVisible() and i == 79 ) then
				getglobal("Solitaire_CardButton"..i):SetHeight(90);
			end
		end
	end
end
]]


function Solitaire_MoveCards( origid, destid )
	local cnt = 1;

	if ( origid >= 1 and origid <= 13 ) then

		for i= origid, 13 do

			if ( getglobal("Solitaire_CardButton"..i):IsVisible() == nil ) then
				return;
			end

			Solitaire_SetCard(destid + cnt, SolitaireIndexToCardArray[i]);
			Solitaire_SetCard(i, 0);
			cnt = cnt + 1;
		end
	elseif ( origid >= 14 and origid <= 26 ) then

		for i= origid, 26 do

			if ( getglobal("Solitaire_CardButton"..i):IsVisible() == nil ) then
				return;
			end

			Solitaire_SetCard(destid + cnt, SolitaireIndexToCardArray[i]);
			Solitaire_SetCard(i, 0);
			cnt = cnt + 1;
		end
	elseif ( origid >= 27 and origid <= 39 ) then

		for i= origid, 39 do

			if ( getglobal("Solitaire_CardButton"..i):IsVisible() == nil ) then
				return;
			end

			Solitaire_SetCard(destid + cnt, SolitaireIndexToCardArray[i]);
			Solitaire_SetCard(i, 0);
			cnt = cnt + 1;
		end
	elseif ( origid >= 40 and origid <= 52 ) then

		for i= origid, 52 do

			if ( getglobal("Solitaire_CardButton"..i):IsVisible() == nil ) then
				return;
			end

			Solitaire_SetCard(destid + cnt, SolitaireIndexToCardArray[i]);
			Solitaire_SetCard(i, 0);
			cnt = cnt + 1;
		end
	elseif ( origid >= 53 and origid <= 65 ) then

		for i= origid, 65 do
			
			if ( getglobal("Solitaire_CardButton"..i):IsVisible() == nil ) then
				return;
			end

			Solitaire_SetCard(destid + cnt, SolitaireIndexToCardArray[i]);
			Solitaire_SetCard(i, 0);
			cnt = cnt + 1;
		end
	elseif ( origid >= 66 and origid <= 78 ) then

		for i= origid, 78 do
			
			if ( getglobal("Solitaire_CardButton"..i):IsVisible() == nil ) then
				return;
			end

			Solitaire_SetCard(destid + cnt, SolitaireIndexToCardArray[i]);
			Solitaire_SetCard(i, 0);
			cnt = cnt + 1;
		end
	elseif ( origid >= 79 and origid <= 91 ) then

		for i= origid, 91 do

			if ( getglobal("Solitaire_CardButton"..i):IsVisible() == nil ) then
				return;
			end

			Solitaire_SetCard(destid + cnt, SolitaireIndexToCardArray[i]);
			Solitaire_SetCard(i, 0);
			cnt = cnt + 1;
		end
	elseif ( origid >= 92 and origid <= 95 ) then

		--NEEDS WORK
		if ( Solitaire_CheckRules( origid, destid ) ) then
			Solitaire_SetCard(destid + 1, SolitaireIndexToCardArray[origid]);
			Solitaire_SetCard( origid, 0, 1);
		end
	end
end


-- NEED TO: Set it up so as you add to the acestacks, the cards on the bottom get saved, and get popped back up
-- if a card on top is removed.

function Solitaire_CheckAceStackRules( origid, destid )
	local origsuit, destsuit;
	local origval, destval;

	if ( SolitaireIndexToCardArray[destid] == nil ) then
		if ( SolitaireCardArray[SolitaireIndexToCardArray[origid]].value == 1 ) then
			return 1;
		end
	elseif ( SolitaireCardArray[SolitaireIndexToCardArray[destid]].suit == SolitaireCardArray[SolitaireIndexToCardArray[origid]].suit ) then
		origval = SolitaireCardArray[SolitaireIndexToCardArray[origid]].value;
		destval = SolitaireCardArray[SolitaireIndexToCardArray[destid]].value;

		if ( origval - destval == 1 ) then
			return 1;
		end
	end

	return nil;
end


function Solitaire_PopSpareStack()
	local TmpStack = {};
	local cnt = 1;
	

	if ( SolitaireSpareCardNum < 1 ) then
		return;
	end

	for i=1,SolitaireSpareCardNum do
		if ( i ~= SolitaireCurrentSpareCardIndex ) then
			TmpStack[cnt] = SolitaireSpareCardStack[i];
			cnt = cnt + 1;
		end
	end

	SolitaireSpareCardStack = {};
	SolitaireSpareCardStack = TmpStack;

	SolitaireCurrentSpareCardIndex = SolitaireCurrentSpareCardIndex - 1;
	SolitaireSpareCardNum = SolitaireSpareCardNum - 1;
	if ( SolitaireCurrentSpareCardIndex == 0 ) then

		if ( SolitaireSpareCardNum > 1 ) then
			--SolitaireCurrentSpareCardIndex = SolitaireSpareCardNum;
			Solitaire_SetCard(96, 0, 1);
			
		end
		return;
	end

	Solitaire_SetCard(96, SolitaireSpareCardStack[SolitaireCurrentSpareCardIndex]);
end


function Solitaire_SpareCardOnClick()
	
	SolitaireCurrentSpareCardIndex = SolitaireCurrentSpareCardIndex + 1;

	if ( SolitaireSpareCardNum < 1 ) then
		return;
	end

	if ( SolitaireCurrentSpareCardIndex > SolitaireSpareCardNum ) then
		SolitaireCurrentSpareCardIndex = 0;
		Solitaire_SetCard(96, 0, 1);
		return;
	end

	Solitaire_SetCard(96, SolitaireSpareCardStack[SolitaireCurrentSpareCardIndex]);

end


function Solitaire_OnClick(id)

	if ( id <= 91 ) then
	
		--if ( IsControlKeyDown() ) then
			if ( SolitaireSelectedCard ~= nil ) then
			
				if ( Solitaire_CheckRules( SolitaireSelectedCard, id ) ) then
					if ( SolitaireSelectedCard <= 91 ) then
						Solitaire_MoveCards( SolitaireSelectedCard, id );
						SolitaireSelectedCard = nil;
						getglobal("Solitaire_CardButton"..id.."CheckTexture"):SetTexture("");
						Solitaire_CheckAndFlipStackCard();
					elseif ( SolitaireSelectedCard == 96) then
						Solitaire_SetCard(id+1, SolitaireIndexToCardArray[SolitaireSelectedCard])
						Solitaire_SetCard(SolitaireSelectedCard, 0, 1);
						SolitaireSelectedCard = nil;
						Solitaire_PopSpareStack();
					end
				end
			end
			return;
		--end

	elseif (id >= 92 and id <= 95) then

		--if ( IsControlKeyDown() ) then
			if ( SolitaireSelectedCard ~= nil ) then
			
				if ( Solitaire_CheckAceStackRules( SolitaireSelectedCard, id ) ) then
				
					if ( SolitaireSelectedCard >= 92 and SolitaireSelectedCard <= 95 ) then
						Solitaire_SetCard(id, SolitaireIndexToCardArray[SolitaireSelectedCard])
						Solitaire_SetCard(SolitaireSelectedCard, 0, 1);	
					elseif ( SolitaireSelectedCard == 96) then
						Solitaire_SetCard(id, SolitaireIndexToCardArray[SolitaireSelectedCard])
						Solitaire_SetCard(SolitaireSelectedCard, 0, 1);
						
						Solitaire_PopSpareStack();
							
					else
						Solitaire_SetCard(id, SolitaireIndexToCardArray[SolitaireSelectedCard])
						Solitaire_SetCard(SolitaireSelectedCard, 0);	
					end

					SolitaireSelectedCard = nil;
					getglobal("Solitaire_CardButton"..id.."CheckTexture"):SetTexture("");
					Solitaire_CheckAndFlipStackCard();
				end
			end
			return;
		--end
	end
	

	if ( getglobal("Solitaire_CardButton"..id.."CardValue"):GetText() ~= "" and getglobal("Solitaire_CardButton"..id.."CardValue"):GetText() ~= nil) then
		if(SolitaireSelectedCard == id) then
			SolitaireSelectedCard = nil;
			getglobal("Solitaire_CardButton"..id.."CheckTexture"):SetTexture("");
		elseif( SolitaireSelectedCard == nil ) then
			getglobal("Solitaire_CardButton"..id.."CheckTexture"):SetTexture("Interface\\AddOns\\Solitaire\\Check");
			SolitaireSelectedCard = id;
		else
			getglobal("Solitaire_CardButton"..SolitaireSelectedCard.."CheckTexture"):SetTexture("");
			getglobal("Solitaire_CardButton"..id.."CheckTexture"):SetTexture("Interface\\AddOns\\Solitaire\\Check");
			SolitaireSelectedCard = id;
		end
	end


end


function Solitaire_StackButtonOnClick( id )

	--if ( IsControlKeyDown() ) then
		
		if ( SolitaireSelectedCard ~= nil ) then
			
			
			if ( SolitaireSelectedCard == 96 ) then

				if ( SolitaireCardArray[SolitaireIndexToCardArray[SolitaireSelectedCard]].value ~= 13 ) then
					SolitaireSelectedCard = nil;
					return;
				end

				if ( id == 1 ) then
					Solitaire_SetCard(1, SolitaireIndexToCardArray[SolitaireSelectedCard])
					getglobal("Solitaire_StackButton1"):Hide();

				elseif ( id == 2 ) then
					Solitaire_SetCard(14, SolitaireIndexToCardArray[SolitaireSelectedCard])
					getglobal("Solitaire_StackButton2"):Hide();

				elseif ( id == 3 ) then
					Solitaire_SetCard(27, SolitaireIndexToCardArray[SolitaireSelectedCard])
					getglobal("Solitaire_StackButton3"):Hide();

				elseif ( id == 4 ) then
					Solitaire_SetCard(40, SolitaireIndexToCardArray[SolitaireSelectedCard])
					getglobal("Solitaire_StackButton4"):Hide();

				elseif ( id == 5 ) then
					Solitaire_SetCard(53, SolitaireIndexToCardArray[SolitaireSelectedCard])
					getglobal("Solitaire_StackButton5"):Hide();

				elseif ( id == 6 ) then
					Solitaire_SetCard(66, SolitaireIndexToCardArray[SolitaireSelectedCard])
					getglobal("Solitaire_StackButton6"):Hide();

				elseif ( id == 7 ) then
					Solitaire_SetCard(79, SolitaireIndexToCardArray[SolitaireSelectedCard])
					getglobal("Solitaire_StackButton7"):Hide();
				end

				
				Solitaire_SetCard(SolitaireSelectedCard, 0, 1);	
				Solitaire_PopSpareStack();
				getglobal("Solitaire_CardButton"..SolitaireSelectedCard.."CheckTexture"):SetTexture("");
				SolitaireSelectedCard = nil;
				--Solitaire_CheckAndFlipStackCard();
				return;
			end

			if ( SolitaireCardArray[SolitaireIndexToCardArray[SolitaireSelectedCard]].value == 13 ) then
				
				if ( id == 1 ) then
					Solitaire_MoveCards( SolitaireSelectedCard, 1-1 );
					getglobal("Solitaire_StackButton1"):Hide();

				elseif ( id == 2 ) then
					Solitaire_MoveCards( SolitaireSelectedCard, 14-1 );
					getglobal("Solitaire_StackButton2"):Hide();

				elseif ( id == 3 ) then
					Solitaire_MoveCards( SolitaireSelectedCard, 27-1 );
					getglobal("Solitaire_StackButton3"):Hide();

				elseif ( id == 4 ) then
					Solitaire_MoveCards( SolitaireSelectedCard, 40-1 );
					getglobal("Solitaire_StackButton4"):Hide();

				elseif ( id == 5 ) then
					Solitaire_MoveCards( SolitaireSelectedCard, 53-1 );
					getglobal("Solitaire_StackButton5"):Hide();

				elseif ( id == 6 ) then
					Solitaire_MoveCards( SolitaireSelectedCard, 66-1 );
					getglobal("Solitaire_StackButton6"):Hide();

				elseif ( id == 7 ) then
					Solitaire_MoveCards( SolitaireSelectedCard, 79-1 );
					getglobal("Solitaire_StackButton7"):Hide();
				end

				getglobal("Solitaire_CardButton"..SolitaireSelectedCard.."CheckTexture"):SetTexture("");
				SolitaireSelectedCard = nil;
				Solitaire_CheckAndFlipStackCard();
			end
		end
	--end
end


function Solitaire_OnLoad()

	this:RegisterEvent("VARIABLES_LOADED");

	SlashCmdList["SOLITAIRE"] = Solitaire_SlashHandler;
		SLASH_SOLITAIRE1 = "/sol";

	Solitaire_Init();
	
end


function Solitaire_OnEvent(event)

	if( event == "VARIABLES_LOADED") then
		
	end
end


function Solitaire_SetCardButtonHeight( id, bExpand )
	
	if ( id > 0 and id < 92 and id ~= 13 and id ~= 26 and id ~= 39 and id ~= 52 and id ~= 65 and id ~= 78 and id ~= 91 ) then

		if ( bExpand ) then
			getglobal("Solitaire_CardButton"..id):SetHeight(90);
			getglobal("Solitaire_CardButton"..id.."CardTexture"):SetTexture("Interface\\AddOns\\Solitaire\\Cardfacev3");
			getglobal("Solitaire_CardButton"..id.."CardTexture"):SetTexCoord(0, 1, 0, 1);
		else
			getglobal("Solitaire_CardButton"..id):SetHeight(14);
			getglobal("Solitaire_CardButton"..id.."CardTexture"):SetTexture("Interface\\AddOns\\Solitaire\\Cardfacev4");
			getglobal("Solitaire_CardButton"..id.."CardTexture"):SetTexCoord(0, 1, 0, 4);
		end
	end
end


function Solitaire_SetCard(num, val, bDoNotHide)
		                  
	local cardval = getglobal("Solitaire_CardButton"..num.."CardValue");
	local SuitTexture = getglobal("Solitaire_CardButton"..num.."SuitTexture");
	local tmpval;
	local suit;

	if ( cardval == nil or SuitTexture == nil ) then
		DEFAULT_CHAT_FRAME:AddMessage("SetCard Failure");
		return;
	end

	if ( val == 0) then
		cardval:SetText("");
		SuitTexture:SetTexture("");
		getglobal("Solitaire_CardButton"..num.."CheckTexture"):SetTexture("");

		if ( not bDoNotHide ) then
			getglobal("Solitaire_CardButton"..num):Hide();
		end

		-- We're "deleting" this card, so expand its click zone, as well as the click zone of its predecesor.
		Solitaire_SetCardButtonHeight( num - 1, 1 )
		Solitaire_SetCardButtonHeight( num, 1 )

		SolitaireIndexToCardArray[num] = nil;
		return;
	end

	suit = SolitaireCardArray[val].suit;

	if ( SolitaireCardArray[val].value == 13 ) then
		tmpval = "K";
	elseif ( SolitaireCardArray[val].value == 12 ) then
		tmpval = "Q";
	elseif ( SolitaireCardArray[val].value == 11 ) then
		tmpval = "J";
	elseif ( SolitaireCardArray[val].value == 1 ) then
		tmpval = "A";
	else
		tmpval = SolitaireCardArray[val].value;
	end


	if ( suit == "Heart" or suit == "Diamond" ) then

		cardval:SetText(tmpval);
		cardval:SetTextColor(1, 0, 0, 1);
		SuitTexture:SetTexture("Interface\\AddOns\\Solitaire\\"..SolitaireCardArray[val].suit);
	elseif (suit == "Spade" or suit == "Club" ) then
		cardval:SetText(tmpval);
		cardval:SetTextColor(0, 0, 0, 1);
		SuitTexture:SetTexture("Interface\\AddOns\\Solitaire\\"..SolitaireCardArray[val].suit);
	end

	Solitaire_SetCardButtonHeight( num - 1 )
	Solitaire_SetCardButtonHeight( num, 1 )

	SolitaireIndexToCardArray[num] = val;
	getglobal("Solitaire_CardButton"..num):Show();
	
end


--HACK
function Solitaire_RedrawCards()
	local i;

	for i=1,91 do
		if( getglobal("Solitaire_CardButton"..i):IsVisible() ) then
			getglobal("Solitaire_CardButton"..i):Hide();
			getglobal("Solitaire_CardButton"..i):Show();
		end
	end

	SolitaireFrame:Hide();
	SolitaireFrame:Show();
end


--HACK
function Solitaire_OnUpdate(arg1)
	
	SolitaireTimeCounter = SolitaireTimeCounter + arg1;

	if(SolitaireTimeCounter >= 5) then
		--DEFAULT_CHAT_FRAME:AddMessage("DEBUG");
		--Solitaire_RedrawCards();
		SolitaireFrame:Hide();
		SolitaireFrame:Show();
		SolitaireTimeCounter = 0;
	end
end


function Solitaire_SlashHandler(cmd)
	
	local args = {};
	local counter = 0;
	local i, w;
	local status;
	local TmpStr = {};
	TmpStr = "";

	cmd = string.lower(cmd);
	for w in string.gfind(cmd, "%w+") do
		counter = counter + 1;
		args[counter] = w;
	end

	if (args[1] == nil) then
		SolitaireFrame:Show();
	end
end


