LINKSNAG_MAX_LINK_LENGTH = 32;
LINKSNAG_LINK_COLOR = "00FF00";
LINKSNAG_TIMESTAMP_ON = false;


function linkSnagExportFrame_OnLoad()
	linkSnag_old_ChatFrame_OnEvent = ChatFrame_OnEvent;
	ChatFrame_OnEvent = linkSnag_new_ChatFrame_OnEvent;

	linkSnag_old_SetItemRef = SetItemRef;
	SetItemRef = linkSnag_new_SetItemRef;

	RegisterForSave("LINKSNAG_TIMESTAMP_ON");
	
	SlashCmdList["TIMESTAMP_ENABLE"] = linkSnag_timeStampEnable;
	SLASH_TIMESTAMP_ENABLE1 = "/lstime";
end

function linkSnag_timeStampEnable()
	if(LINKSNAG_TIMESTAMP_ON == false) then
		LINKSNAG_TIMESTAMP_ON = true;
		DEFAULT_CHAT_FRAME:AddMessage("linkSnag timestamps are now ENABLED");
	else
		LINKSNAG_TIMESTAMP_ON = false;
		DEFAULT_CHAT_FRAME:AddMessage("linkSnag timestamps are now DISABLED");
	end
end

function linkSnag_new_ChatFrame_OnEvent(orig_event)
	if(not this.Original_AddMessage) then
		this.Original_AddMessage = this.AddMessage;
		this.AddMessage = linkSnag_ChatTimestamp_AddMessage;
	end

	local msg = arg1;
	
	if(string.sub(orig_event, 1, 8) == "CHAT_MSG" and msg ~= nil) then
		msg = string.gsub(msg, "(%s?)(www%.[%w_/%.%?%%=~-]+)(%s?)", linkSnag_linkGen);	-- www.whatever.com/dir/file.ext
		msg = string.gsub(msg, "(%s?)(%a+://[%w_/%.%?%%=~-]+)(%s?)", linkSnag_linkGen);	-- http://sub.domain.com/dir/file.ext
		msg = string.gsub(msg, "(%s?)([_%w-%.~]+@[_%w-]+%.[_%w-%.]+)(%s?)", linkSnag_linkGen);-- 192.168.0.1:12345/dir/file.ext
		msg = string.gsub(msg, "(%s?)(%d%d?%d?%.%d%d?%d?%.%d%d?%d?%.%d%d?%d?[:%d%d?%d?%d?%d?]*[%w_/%.%?%%=~-]*)(%s?)", linkSnag_linkGen);--foo@bar.com
		arg1 = msg;
	end
			
	linkSnag_old_ChatFrame_OnEvent(orig_event);
end 

function linkSnag_new_SetItemRef(link, button)
	if (string.sub(link, 1 , 3) == "ref") then
		linkSnagURL:SetText(string.sub(link,5));
		linkSnagExportFrame:Show();
		linkSnagURL:HighlightText();
		return;
	else
		linkSnag_old_SetItemRef(link, button);
	end
end

function linkSnag_ChatTimestamp_AddMessage(this, msg, r, g, b, id)
	if(msg ~= nil) then
		if(LINKSNAG_TIMESTAMP_ON == true) then
			msg = linkSnag_timeLink() .. " " .. msg;
		end
	end

	this:Original_AddMessage(msg, r, g, b, id);
	return
end

function linkSnag_timeLink(chatMsg)
	local hour=string.sub(date(),  10, 11);
	local minute=string.sub(date(),  13, 14);
	local second =string.sub(date(),  16, 17);
	
	if tonumber(hour) >12 then
		hour=hour-12;
	else
		hour=tonumber(hour)
		if hour==0 then
			hour=12;
  		end
	end
	return 	"[" .. hour .. ":" .. minute .. ":" .. second .. "]";
end

function linkSnag_linkGen(begSpace, URL, aftSpace)
	return begSpace .. "|cff" .. LINKSNAG_LINK_COLOR .. "|Href:" .. URL .. "|h[".. URL .."]|h|r" .. aftSpace;
end

function linkSnag_HideButton_onClick()
	linkSnagExportFrame:Hide();
end
