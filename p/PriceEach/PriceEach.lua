--PriceEach version 0.02
--Released 10/33/05
--
--originally based off of code in ShowBid (which, unless updated for 1.8, probably doesn't work anymore)
--also, BIG thanks to the author of AuctionSort, for showing me how to make this work under 1.8 before the patch hit :)
--credit to other authors in the several functions
--
--todo: load on demand
--
--Hangar of Silvermoon

PRICEEACH_VERSION="0.02";

local orig_AuctionFrameBrowse_Update;

function PriceEach_OnLoad()

	local name,title,notes,enabled,loadable,reason,security
  
	name,title,notes,enabled,loadable,reason,security = GetAddOnInfo("PriceEach");
  
	this:RegisterEvent("AUCTION_ITEM_LIST_UPDATE");
	this:RegisterEvent("VARIABLES_LOADED");

	orig_AuctionFrameBrowse_Update = AuctionFrameBrowse_Update;
	
	AuctionFrameBrowse_Update = PriceEach_AuctionFrameBrowse_Update;
	
	DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT_COLOR_CODE..title.." "..PRICEEACH_VERSION.." loaded"..FONT_COLOR_CODE_CLOSE);

	SLASH_PRICEEACHSLASH1 = "/pe";
	SlashCmdList["PRICEEACHSLASH"] = PriceEach_Enable_ChatCommandHandler;
	
end

function PriceEach_Enable_ChatCommandHandler(text)

	local msg = TextParse(text); --take a string and return a table with each word from the string in each entry
	
	msg[1] = strlower(msg[1]);
	
	if msg[1] == "warn" and msg[2] and tonumber(msg[2]) then
	
		DickThreshold = tonumber(msg[2]);
		DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE.."PriceEach warning threshold is now set to: "..FONT_COLOR_CODE_CLOSE..HIGHLIGHT_FONT_COLOR_CODE..msg[2]..FONT_COLOR_CODE_CLOSE);

	elseif msg[1] == "warn" then
	
		
		SetDick(); --in case they /pe warn before they've loaded the AH
		
		DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE.."PriceEach warning threshold is currently set to: "..FONT_COLOR_CODE_CLOSE..HIGHLIGHT_FONT_COLOR_CODE..DickThreshold..FONT_COLOR_CODE_CLOSE);
	
	else
	
		DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE.."PriceEach: Invalid option.  Please use: /pe warn [#], where # is the amount of gold you want to be warned if price each is greater than.  Omit the # for current threshold."..FONT_COLOR_CODE_CLOSE);
	
	end

end

function PriceEach_OnEvent(event, arg1, arg2, arg3)

	if (event == "VARIABLES_LOADED") then
	
		SetDick(); --make sure a good value coming from variables

	end

end

function SetDick()
--i'm sorry, but anyone who's selling a citrine for 90g IS a dick :p

	if (DickThreshold == nil) then
	
		DickThreshold = 5;
		DEFAULT_CHAT_FRAME:AddMessage(LIGHTYELLOW_FONT_COLOR_CODE.."PriceEach warning threshold set to the default: "..FONT_COLOR_CODE_CLOSE..HIGHLIGHT_FONT_COLOR_CODE..DickThreshold..FONT_COLOR_CODE_CLOSE);
	
	end
	
end

function PriceEach_AuctionFrameBrowse_Update()

	SetDick(); --set in case they haven't /pe warned yet or opened ah

	local offset = FauxScrollFrame_GetOffset(BrowseScrollFrame);
	local index;
	local button, buttonName;
	
	orig_AuctionFrameBrowse_Update();
	
	for i=1, NUM_BROWSE_TO_DISPLAY do
	
		index = offset + i + (NUM_AUCTION_ITEMS_PER_PAGE * AuctionFrameBrowse.page);
		
		button = getglobal("BrowseButton"..i);
		
		buttonName = "BrowseButton"..i;
	
		local name, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner =  GetAuctionItemInfo("list", offset + i);

		if (name ~= nil) then
			
			local aiLink = GetAuctionItemLink("list", offset + i); --get clicky-link
	    	local aiItemID, aiRandomProp, aiEnchant, aiUniqID = breakLink(aiLink); --extract itemID from clicky-link		  
			  		
			local sName, sLink, iQuality, iLevel, sType, sSubType, iCount, iEquipLoc = GetItemInfo(aiItemID);		--

			if (buyoutPrice > 0 ) and (iCount > 1) then --~= nil) then
			
				itemName = getglobal(buttonName.."Name");
			
				local oldtext = itemName:GetText();
	
				local pereach = floor(buyoutPrice / count);
				local g,s,c = ConvertMoney(pereach);
				local gt,st,ct;
				local peText;
				
				peText = " ("
				
				if (g > 0) then
				
					if (g >= DickThreshold) then --5
				
						peText = peText..RED_FONT_COLOR_CODE..g.."g"..FONT_COLOR_CODE_CLOSE;
					
					else
					
						peText = peText..NORMAL_FONT_COLOR_CODE..g.."g"..FONT_COLOR_CODE_CLOSE;
						
					end
					
				end
				
				if (s > 0) then
				
					if (g > 0) then
					
						peText = peText.." ";
						
					end
					
					if (g >= DickThreshold) then --5
						
						peText = peText..GetHex(0.8,0.8,0.8)..s.."s"..FONT_COLOR_CODE_CLOSE;
					
					else
					
						peText = peText..GetHex(0.8,0.8,0.8)..s.."s"..FONT_COLOR_CODE_CLOSE;
						
					end
					
				end
				
				if (c > 0) then
				
					if (g > 0) or (s > 0) then
						
						peText = peText.." ";
					
					end
					
					if (g >= DickThreshold) then --5
				
						peText = peText..GetHex(0.8,0.5,0.4)..c.."c"..FONT_COLOR_CODE_CLOSE;
					
					else
					
						peText = peText..GetHex(0.8,0.5,0.4)..c.."c"..FONT_COLOR_CODE_CLOSE;
						
					end
					
				end
				
				peText = peText..")"
		
				itemName:SetText(oldtext..peText);
				
			end --if (buyoutPrice > 0 ) and (iCount ~= nil) then

		end --if (name ~= nil) then
		
	end --for

end --function

--courtesy EnhTooltip:
function ConvertMoney(copper)

	if (copper == nil) then copper = 0; end
	
	local g = math.floor(copper / 10000);
	local s = math.floor((copper - (g*10000)) / 100);
	local c = math.floor(copper - (g*10000) - (s*100));
	
	return g,s,c;
	
end

--courtesy EnhTooltip:
function breakLink(link)
	
	if (type(link) ~= 'string') then return end
	
	local i,j, itemID, enchant, randomProp, uniqID, name = string.find(link, "|Hitem:(%d+):(%d+):(%d+):(%d+)|h[[]([^]]+)[]]|h")
	
	return tonumber(itemID or 0), tonumber(randomProp or 0), tonumber(enchant or 0), tonumber(uniqID or 0), name
	
end

--courtesy watchdog:
function GetHex(r,g,b)

	local TehHaxx0r;

	if g then

		return string.format("|cFF%02X%02X%02X", (255*r), (255*g), (255*b))

	elseif r then

		return string.format("|cFF%02X%02X%02X", (255*r.r), (255*r.g), (255*r.b))

	else

		return ""

	end

end

--Text Parsing. Yay!
function TextParse(InputString)
--[[ By FERNANDO!
	This function should take a string and return a table with each word from the string in
	each entry. IE, "Linoleum is teh awesome" returns {"Linoleum", "is", "teh", "awesome"}
	Some good should come of this, I've been avoiding writing a text parser for a while, and
	I need one I understand completely. ^_^

	If you want to gank this function and use it for whatever, feel free. Just give me props
	somewhere. This function, as far as I can tell, is fairly foolproof. It's hard to get it
	to screw up. It's also completely self-contained. Just cut and paste.]]
   local Text = InputString;
   local TextLength = 1;
   local OutputTable = {};
   local OTIndex = 1;
   local StartAt = 1;
   local StopAt = 1;
   local TextStart = 1;
   local TextStop = 1;
   local TextRemaining = 1;
   local NextSpace = 1;
   local Chunk = "";
   local Iterations = 1;
   local EarlyError = false;

   if ((Text ~= nil) and (Text ~= "")) then
   -- ... Yeah. I'm not even going to begin without checking to make sure Im not getting
   -- invalid data. The big ol crashes I got with my color functions taught me that. ^_^

      -- First, it's time to strip out any extra spaces, ie any more than ONE space at a time.
      while (string.find(Text, "  ") ~= nil) do
         Text = string.gsub(Text, "  ", " ");
      end

      -- Now, what if text consisted of only spaces, for some ungodly reason? Well...
      if (string.len(Text) <= 1) then
         EarlyError = true;
      end

      -- Now, if there is a leading or trailing space, we nix them.
      if EarlyError ~= true then
        TextStart = 1;
        TextStop = string.len(Text);

        if (string.sub(Text, TextStart, TextStart) == " ") then
           TextStart = TextStart+1;
        end

        if (string.sub(Text, TextStop, TextStop) == " ") then
           TextStop = TextStop-1;
        end

        Text = string.sub(Text, TextStart, TextStop);
      end

      -- Finally, on to breaking up the goddamn string.

      OTIndex = 1;
      TextRemaining = string.len(Text);

      while (StartAt <= TextRemaining) and (EarlyError ~= true) do

         -- NextSpace is the index of the next space in the string...
         NextSpace = string.find(Text, " ",StartAt);
         -- if there isn't another space, then StopAt is the length of the rest of the
         -- string, otherwise it's just before the next space...
         if (NextSpace ~= nil) then
            StopAt = (NextSpace - 1);
         else
            StopAt = string.len(Text);
            LetsEnd = true;
         end

         Chunk = string.sub(Text, StartAt, StopAt);
         OutputTable[OTIndex] = Chunk;
         OTIndex = OTIndex + 1;

         StartAt = StopAt + 2;

      end
   else
      OutputTable[1] = "Error: Bad value passed to TextParse!";
   end

   if (EarlyError ~= true) then
      return OutputTable;
   else
      return {"Error: Bad value passed to TextParse!"};
   end
   
end