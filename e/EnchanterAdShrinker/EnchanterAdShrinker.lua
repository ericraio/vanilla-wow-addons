--[[	---------------------------------------------------------------
		Enchanter Ad Shrinker
		---------------------------------------------------------------
		
		@Author: 		Sacha Beharry
		@DateCreated: 	
		@LastUpdate: 	
		@Release:		BETA 2
		@Version: 		0.3.1800
		@Note:			
		]]

		EAS_RELEASEVERSION 	= "BETA 2";
		EAS_NOTE = {
		"Enchanter Ad Shrinker - Beta 2",
		"Thank you for using EAS - Hope you find it useful :)",
		"Sacha"
		};
	
--[[	---------------------------------------------------------------
	
		Web: 			
	
		Filename: 		EnchanterAdShrinker.lua
	
		Project Name: 	Pandora
	
		Description:	Main Program
	
		Purpose:		
		]]


local lastName = nil;

function EnchanterAdShrinker_OnLoad()
	SlashCmdList["EnchanterAdShrinkerCOMMAND"] = EnchanterAdShrinker_SlashHandler;
	SLASH_EnchanterAdShrinkerCOMMAND1 = "/enchanteradshrinker";
	SLASH_EnchanterAdShrinkerCOMMAND2 = "/eas";
	
	this:RegisterEvent("CHAT_MSG_CHANNEL");
	 
	--[[
	local xhList = {}; 
	xhList[ "enchantmsg" ] = { tag = "Long Enchant Message", trigger = enchTrigger, function = doEnchMsg, block = 1 };
	]]
	
	local old_SetItemRef = SetItemRef;
	function SetItemRef(link, text, button)
		for name, msg in string.gfind( link, "xhmsg:(%w+)<XH>(.+)" ) do 	
		
			if( ItemRefTooltip:IsVisible() and lastName and lastName == name ) then				
		
				HideUIPanel(ItemRefTooltip);
				--ItemRefTooltip:Hide();
				lastName = nil;
			
			else
				lastName = name;

				ShowUIPanel(ItemRefTooltip);
				if ( not ItemRefTooltip:IsVisible() ) then
					ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE");
				end				

				ItemRefTooltip:ClearLines();
				--ItemRefTooltip:ClearAllPoints();

				if( name == "eas" and msg == "eas" ) then
				
					ItemRefTooltip:AddLine( EAS_NOTE[1], 1, 0.5, 0 );
					ItemRefTooltip:AddLine( EAS_NOTE[2], 1, 1, 1, 1, 1 );
					ItemRefTooltip:AddLine( EAS_NOTE[3] );
				
				else
					ItemRefTooltip:AddLine( "Message", 0.5, 0.5, 1 );
					ItemRefTooltip:AddLine( name );
					ItemRefTooltip:AddLine( msg, 1, 1, 1, 1, 1 );
				end
				ItemRefTooltip:Show();
				
				--[[
				ShowUIPanel(ItemRefTooltip);
				if ( not ItemRefTooltip:IsVisible() ) then
					ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE");
				end				
				]]
			end
			
			return;
		end
		
		lastName = nil;
		old_SetItemRef(link, text, button);
	end
	
	
	local old_ChatFrame_OnEvent = ChatFrame_OnEvent;
	function ChatFrame_OnEvent(event)
		--if( string.find( event, "CHAT_MSG" ) and arg1 and arg2 and string.len(arg1) > 16 ) then
		if( event == "CHAT_MSG_CHANNEL" and arg1 and arg2 and string.len(arg1) > 16 ) then
			local argl = string.lower(arg1);
			local start; --, _ = string.find( argl, "enchanting");
			local score = 100;
			if( not start ) then
				score = Sacha_LightSearch( arg1, "bracer chest boots weapon armor fiery demon slaying beast crusader" );
				if( score > 0 and ( string.find( argl, "chant") or string.find( argl, "ench") ) ) then 
					start = 1;
				end
			end
			
			if( start and Sacha_LightSearch( arg1, "trainer thorium item:" ) == 0 ) then
				--[[
					Thanks to Subatai-Garona for this fix posted in curse-gaming.com
				--]]
				if string.find( arg1, "|") then arg1 = string.gsub(arg1, "|", "/"); end;
				
				arg1 = "|cff8888ff|Hxhmsg:"..arg2.."<XH>"..arg1.."|h[Enchantments]|h|r"; 
				if( string.find(argl, "wts") ) then
					arg1 = "WTS "..arg1;
				elseif( string.find(argl, "wtb") ) then
					arg1 = "WTB "..arg1;
				else
					arg1 = "Regarding "..arg1;
				end 
			end
		end
		old_ChatFrame_OnEvent(event);
	end
	
	--ChatPrintln( "|cffff8800|Hxhmsg:eas<XH>eas|h[Enchanter Ad Shrinker]|h|r loaded." );

end

function EnchanterAdShrinker_SlashHandler( com ) 

end

function Sacha_LightSearch( source, search )
	local ad = string.lower( source );
	local query = string.lower( search );
		
	if( string.find( ad, query ) ) then
		return 100;
	else
		local sourceWords = {};
		for word in string.gfind( ad, "%w+" ) do
			sourceWords[word] = 1;
		end
		
		local highlighted = source;	
				
		local score = 0;
		local total = 0;
		for word in string.gfind(query, "%w+") do
			total = total + 1;
			if( sourceWords[word] ) then
				score = score + 1;
			elseif( string.find( ad, word ) ) then
				score = score + 0.9;
			end
		end
		
		if( score > 0 ) then 
			score = floor(99*score/total);	
		end
		
		return score;
	end
end

function ChatPrintln( string )
	DEFAULT_CHAT_FRAME:AddMessage(string, 0.95, 0.95, 0.5);
end
