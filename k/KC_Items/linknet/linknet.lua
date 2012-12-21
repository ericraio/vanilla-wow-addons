local locals = KC_ITEMS_LOCALS.modules.linknet

KC_Linknet = KC_ItemsModule:new({
	type		 = "linknet",
	name		 = locals.name,
	desc		 = locals.description,
	cmdOptions	 = locals.chat,
	dependencies = {"common"},
})

KC_Items:Register(KC_Linknet)

function KC_Linknet:Enable()
	self:RegisterEvent("CHAT_MSG_SYSTEM"	, "ChatMessageHandler" );
	self:RegisterEvent("CHAT_MSG_TRADE"		, "ChatMessageHandler" );
	self:RegisterEvent("CHAT_MSG_SAY"		, "ChatMessageHandler" );
	self:RegisterEvent("CHAT_MSG_WHISPER"	, "ChatMessageHandler" );
	self:RegisterEvent("CHAT_MSG_PARTY"		, "ChatMessageHandler" );
	self:RegisterEvent("CHAT_MSG_GUILD"		, "ChatMessageHandler" );
	self:RegisterEvent("CHAT_MSG_YELL"		, "ChatMessageHandler" );
	self:RegisterEvent("CHAT_MSG_TEXT_EMOTE", "ChatMessageHandler" );
	self:RegisterEvent("CHAT_MSG_OFFICER"	, "ChatMessageHandler" );
	self:RegisterEvent("CHAT_MSG_LOOT"		, "ChatMessageHandler" );
	self:RegisterEvent("CHAT_MSG_RAID"		, "ChatMessageHandler" );
	self:RegisterEvent("CHAT_MSG"			, "ChatMessageHandler" );
	self:RegisterEvent("CHAT_MSG_CHANNEL"	, "ChatMessageHandler" );

	self:RegisterEvent("PLAYER_TARGET_CHANGED"	, "InspectTarget" );

	self:RegisterEvent("AUCTION_ITEM_LIST_UPDATE", "AuctionUpdate");
end

function KC_Linknet:ChatMessageHandler()
	if (arg1) then
		for item in gfind(arg1, "(%d+:%d+:%d+:%d+)") do
			if(item) then
				self.common:AddCode(item);
			end	
		end
	end
end

function KC_Linknet:InspectTarget()
	if (UnitIsPlayer("target")) then
		for i = 1, 19 do
			self.common:AddCode(GetInventoryItemLink("target", i))
		end
	end
end

function KC_Linknet:AuctionUpdate()
	for auctionid = 1, (GetNumAuctionItems("list") or 0) do
		self.common:AddCode(GetAuctionItemLink("list", auctionid));
	end
end