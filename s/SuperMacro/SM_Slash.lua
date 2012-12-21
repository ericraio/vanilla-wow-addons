SM_INV_SLOT = {
["AMMOSLOT"]=0,
["HEADSLOT"]=1,
["NECKSLOT"]=2, 
["SHOULDERSLOT"]=3, 
["SHIRTSLOT"]=4, 
["CHESTSLOT"]=5, 
["WAISTSLOT"]=6, 
["LEGSSLOT"]=7, 
["FEETSLOT"]=8, 
["WRISTSLOT"]=9, 
["HANDSSLOT"]=10, 
["FINGER0SLOT"]=11, 
["FINGER1SLOT"]=12, 
["TRINKET0SLOT"]=13, 
["TRINKET1SLOT"]=14, 
["BACKSLOT"]=15, 
["MAINHANDSLOT"]=16, 
["SECONDARYHANDSLOT"]=17, 
["RANGEDSLOT"]=18, 
["TABARDSLOT"]=19, 
["BAG0SLOT"]=20, 
["BAG1SLOT"]=21, 
["BAG2SLOT"]=22, 
["BAG3SLOT"]=23, 
}

SlashCmdList["SUPERMACRO"] = function(msg)
	local info = ChatTypeInfo["SYSTEM"];
	local text;
	local cmd = gsub(msg,"^%s*(%a*)%s*(.*)%s*$","%1" );
	local param = gsub(msg,"^%s*(%a*)%s*([%w %p]*)%s*$","%2" );
	if ( cmd=="hideaction") then
		text = param;
		if ( text == "0" or text=="false") then
			SM_VARS.hideAction = 0;
			HideActionText();
		elseif ( text == "1" or text=="true") then
			SM_VARS.hideAction = 1;
			HideActionText();
		else
			ChatFrame_DisplaySlashHelp("SUPERMACRO",3,3);
		end
		if ( not SM_VARS.hideAction ) then SM_VARS.hideAction = 0; end
		text = "SM_VARS.hideAction is "..SM_VARS.hideAction;
		if ( SuperMacroOptionsFrame:IsVisible() ) then
			SuperMacroOptionsFrame_OnShow();
		end
		DEFAULT_CHAT_FRAME:AddMessage( text, info.r, info.g, info.b, info.id);
		return;
	end
	if ( cmd=="printcolor" ) then
		text = param;
		if ( text =="default" ) then
			SM_VARS.printColor.r = PRINT_COLOR_DEF.r;
			SM_VARS.printColor.g = PRINT_COLOR_DEF.g;
			SM_VARS.printColor.b = PRINT_COLOR_DEF.b;
			if ( SuperMacroOptionsFrame:IsVisible() ) then
				SuperMacroOptionsFrame_OnShow();
			end
			return;
		end
		if ( gsub(text,"%s*","")=="" ) then
			ChatFrame_DisplaySlashHelp("SUPERMACRO",4,4);
			return;
		end
		local color = gsub(msg, ".*color%s*(.*)","%1");
		local red = gsub(color, "%s*(-?%d*%.*%d*)%s*.*","%1");
		local green = gsub(color, "%s*(-?%d*%.*%d*)%s*(-?%d*%.*%d*)%s*(-?%d*%.*%d*)%s*.*","%2");
		local blue = gsub(color, "%s*(-?%d*%.*%d*)%s*(-?%d*%.*%d*)%s*(-?%d*%.*%d*)%s*.*","%3");
		red = tonumber(red) or 0;
		green = tonumber(green) or 0;
		blue = tonumber(blue) or 0;
		red = (red < 0 and 0) or (red > 1 and 1) or red;
		green = (green < 0 and 0) or (green > 1 and 1) or green;
		blue = (blue < 0 and 0) or (blue > 1 and 1) or blue;
		SM_VARS.printColor = { r=red,g=green,b=blue };
		if ( SuperMacroOptionsFrame:IsVisible() ) then
			SuperMacroOptionsFrame_OnShow();
		end
		return;
	end
	if ( cmd=="macrotip" ) then
		text = param;
		if ( text =="default" ) then
			SM_VARS.macroTip1 = 1;
			SM_VARS.macroTip2 = 0;
			if ( SuperMacroOptionsFrame:IsVisible() ) then
				SuperMacroOptionsFrame_OnShow();
			end
			return;
		end
		text = tonumber(text);
		if ( text and text >= 0 and text <= 3) then
			if ( mod(text, 2) == 1 ) then
				SM_VARS.macroTip1 = 1;
			else
				SM_VARS.macroTip1 = 0;
			end
			if ( text >= 2 ) then
				SM_VARS.macroTip2 = 1;
			else
				SM_VARS.macroTip2 = 0;
			end
			if ( SuperMacroOptionsFrame:IsVisible() ) then
				SuperMacroOptionsFrame_OnShow();
			end
		else
			ChatFrame_DisplaySlashHelp("SUPERMACRO",5,6);	
		end
		return;
	end
	if ( cmd=="options" ) then
		ShowUIPanel(SuperMacroOptionsFrame);
		return;
	end
	
	ChatFrame_DisplaySlashHelp("SUPERMACRO");
	return;
end

SlashCmdList["MACRO"] = function(msg)
	if(not msg or msg == "") then
		ShowUIPanel(SuperMacroFrame);
	else
		RunMacro(msg);
	end
end

-- use item
SlashCmdList["SMUSE"] = function(msg)
	use(unpack(ListToTable(msg)));
end

-- equip item
SlashCmdList["SMEQUIP"] = function(msg)
	use(unpack(ListToTable(msg)));
end

-- equip offhand item
SlashCmdList["SMEQUIPOFF"] = function(msg)
	local bag, slot = FindItem(TrimSpaces(msg));
	if ( bag and slot ) then
		PickupContainerItem(bag, slot);
		PickupInventoryItem(17);
	end
end

-- unequip item by part or name
SlashCmdList["SMUNEQUIP"] = function(msg)
	local e,f = FindLastEmptyBagSlot();
	if ( e ) then
		PickupInventoryItem(FindItem(TrimSpaces(msg)));
		PickupContainerItem(e,f);
	end
end

-- print text to chatframe
SlashCmdList["SMPRINT"] = function(msg)
	SM_print(msg);
end

-- after action passed text
SlashCmdList["SMPASS"] = function(msg)
	Pass(msg);
end

-- after action failed text
SlashCmdList["SMFAIL"] = function(msg)
	Fail(msg);
end

-- use items in order
SlashCmdList["SMDOORDER"] = function(msg)
	DoOrder(unpack(ListToTable(msg)));
end

-- channel without interruption
SlashCmdList["SMCHANNEL"] = function(msg)
	SM_Channel(msg);
end

function SM_print(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg, SM_VARS.printColor.r, SM_VARS.printColor.g, SM_VARS.printColor.b);
end

if ( not ChatFrame_DisplaySlashHelp ) then
function ChatFrame_DisplaySlashHelp(pre, start, last, frame)
	if ( not frame ) then
		frame=DEFAULT_CHAT_FRAME;
	end
	local info = ChatTypeInfo["SYSTEM"];
	local i = 1;
	if ( type(start) =="number" ) then i = start; end
	if ( i < 1 ) then i =1; end
	local text = TEXT(getglobal(pre.."_HELP_LINE"..i));
	while text do
		frame:AddMessage(text, info.r, info.g, info.b, info.id);
		i = i + 1;
		text = TEXT(getglobal(pre.."_HELP_LINE"..i));
		if ( last and i > last ) then break; end
	end
end
end -- if

-- in sec do cmd
SlashCmdList["SMIN"] = function(msg)
	local _,_,s,r,c = strfind(msg, "(%d+h?%d*m?%d*s?)(%+?)%s+(.*)");
	if ( not c or TrimSpaces(c)=="" ) then return end
	c=gsub(c,"\\n","\n");
	SuperMacro_InEnter(s,c,r);
end

SM_SHIFT_FORM = { bear=1,aquatic=2,cat=3,travel=4,moonkin=5, stealth=1, battle=1,defend=2,berzerk=3 };

SlashCmdList["SMSHIFT"] = function(msg)
	local form=msg;
	if ( SM_SHIFT_FORM[msg] ) then
		form=SM_SHIFT_FORM[msg];
	end
	CastShapeshiftForm(form);
end

SlashCmdList["SMCRAFT"] = function(msg)
	local skill, item, count = unpack(ListToTable(msg));
	count = tonumber(count);
	CraftItem(skill, item, count);
end

SlashCmdList["SMSAYRANDOM"] = function(msg)
	SayRandom(unpack(ListToTable(msg)));
end

SlashCmdList["SMCANCELBUFF"] = function(msg)
	CancelBuff(unpack(ListToTable(msg)));
end

function SayRandom(...)
	tinsert(arg, "");
	local r=random(arg.n);
	RunLine(arg[r]);
end

function SuperMacro_InEnter( sec, cmd, rep)
	if ( not sec or not cmd ) then return end
	local t=SM_INFRAME.events;
	local seconds=sec;
	if ( strfind(seconds,'[hms]') ) then
		seconds=gsub(seconds,'^(%d+)(h?)(%d*)(m?)(%d*)(s?)$', function(hd, h, md, m, sd, s)
			local a=0;
			if ( h=="h" ) then a=a+hd*3600
			else md=hd..md end;
			if ( m=="m" ) then a=a+md*60
			else sd=md..sd end;
			if ( sd~="" ) then a=a+sd end;
			return a;
		end );
	end
	s=GetTime()+seconds;
	t[s]={};
	t[s].cmd=cmd;
	t[s].sec=seconds;
	t[s].rep=rep and rep or "";
	t.n=t.n+1;
	SM_INFRAME:Show();
end

SM_IN=SuperMacro_InEnter;

function SM_INFRAME_OnUpdate( )
	local t=this.events;
	if ( getn(t)==0 ) then
		SM_INFRAME:Hide();
	end
	for k,v in t do
		if ( k~='n' and k<=GetTime() ) then
			RunBody(v.cmd);
			if ( v.rep~="" ) then
				local s=GetTime()+v.sec;
				t[s]={};
				t[s].cmd=v.cmd;
				t[s].sec=v.sec;
				t[s].rep=v.rep;
				t[k]=nil;
			else
				t[k]=nil;
				t.n=t.n-1;
			end
		end
	end
end

function Pass(text)
	if( IsCurrentAction(lastActionUsed) ) then
		RunLine(text);
		return text;
	end
end

function Fail(text)
	if ( not IsCurrentAction(lastActionUsed) ) then
		RunLine(text);
		return text;
	end
end

function UseItemByName(item)
	local bag,slot = FindItem(item);
	if ( not bag ) then return; end;
	if ( slot ) then
		UseContainerItem(bag,slot); -- use, equip item in bag
		return bag, slot;
	else
		UseInventoryItem(bag); -- unequip from body
		return bag;
	end
end

function use(bag, slot)
	local b,s=tonumber(bag), tonumber(slot);
	if ( b ) then
		if ( s ) then
			UseContainerItem(bag,slot); -- use, equip item in bag
		else
			UseInventoryItem(bag); -- unequip from body
		end
	else
		UseItemByName(bag);
	end
end

function DoOrder(...)
	for k,i in arg do
		local item=FindItem(i);
		local spell,book=SM_FindSpell(i);
		if ( spell and GetSpellCooldown(spell,book)==0) then
			CastSpell(spell,book);
			return i, spell, book;
		end
		if ( item and GetItemCooldown(i)==0 ) then
			UseItemByName(i);
			return i, item, slot;
		end
	end
end

function FindItem(item)
	if ( not item ) then return; end
	item = string.lower(ItemLinkToName(item));
	local link;
	for i = 1,23 do
		link = GetInventoryItemLink("player",i);
		if ( link ) then
			if ( item == string.lower(ItemLinkToName(link)) )then
				return i, nil, GetInventoryItemTexture('player', i), GetInventoryItemCount('player', i);
			end
		end
	end
	local count, bag, slot, texture;
	local totalcount = 0;
	for i = 0,NUM_BAG_FRAMES do
		for j = 1,MAX_CONTAINER_ITEMS do
			link = GetContainerItemLink(i,j);
			if ( link ) then
				if ( item == string.lower(ItemLinkToName(link))) then
					bag, slot = i, j;
					texture, count = GetContainerItemInfo(i,j);
					totalcount = totalcount + count;
				end
			end
		end
	end
	return bag, slot, texture, totalcount;
end

function GetItemCooldown(item)
	local bag, slot = FindItem(item);
	if ( slot ) then
		return GetContainerItemCooldown(bag, slot);
	elseif ( bag ) then
		return GetInventoryItemCooldown('player', bag);
	end
end

function FindLastEmptyBagSlot()
	for i=NUM_BAG_FRAMES,0,-1 do
		for j=GetContainerNumSlots(i),1,-1 do
			if not GetContainerItemInfo(i,j) then
				return i,j;
			end
		end
	end
end

function ListToTable(text)
	local t={};
	-- if comma is part of item, put % before it
	-- eg, Sulfuras%, Hand of Ragnaros
	text=gsub(text, "%%,", "%%044");
	-- convert link to name, commas ok
	text=gsub(text, "|c.-%[(.+)%]|h|r", function(x)
		return gsub(x, ",", "%%044");
	end );

	gsub(text, "[^,]+", function(a) -- list separated by comma
		a = TrimSpaces(a);
		if ( a~="" ) then
			a=gsub(a, "%%044", ",");
			tinsert(t,a);
		end
	end);
	return t;
end

function TrimSpaces(str)
	return gsub(str,"^%s*(.-)%s*$","%1");
end

function ItemLinkToName(link)
	return gsub(link,"^.*%[(.*)%].*$","%1");
end

function FindBuff( obuff, unit, item)
	local buff=strlower(obuff);
	local tooltip=SM_Tooltip;
	local textleft1=getglobal(tooltip:GetName().."TextLeft1");
	if ( not unit ) then
		unit ='player';
	end
	local my, me, mc, oy, oe, oc = GetWeaponEnchantInfo();
	if ( my ) then
		tooltip:SetOwner(UIParent, "ANCHOR_NONE");
		tooltip:SetInventoryItem( unit, 16);
		for i=1, 23 do
			local text = getglobal("SM_TooltipTextLeft"..i):GetText();
			if ( not text ) then
				break;
			elseif ( strfind(strlower(text), buff) ) then
				tooltip:Hide();
				return "main",me, mc;
			end
		end
		tooltip:Hide();
	elseif ( oy ) then
		tooltip:SetOwner(UIParent, "ANCHOR_NONE");
		tooltip:SetInventoryItem( unit, 17);
		for i=1, 23 do
			local text = getglobal("SM_TooltipTextLeft"..i):GetText();
			if ( not text ) then
				break;
			elseif ( strfind(strlower(text), buff) ) then
				tooltip:Hide();
				return "off", oe, oc;
			end
		end
		tooltip:Hide();
	end
	if ( item ) then return end
	tooltip:SetOwner(UIParent, "ANCHOR_NONE");
	tooltip:SetTrackingSpell();
	local b = textleft1:GetText();
	if ( b and strfind(strlower(b), buff) ) then
		tooltip:Hide();
		return "track",b;
	end
	local c=nil;
	for i=1, 16 do
		tooltip:SetOwner(UIParent, "ANCHOR_NONE");
		tooltip:SetUnitBuff(unit, i);
		b = textleft1:GetText();
		tooltip:Hide();
		if ( b and strfind(strlower(b), buff) ) then
			return "buff", i, b;
		elseif ( c==b ) then
			break;
		end
		--c = b;
	end
	c=nil;
	for i=1, 16 do
		tooltip:SetOwner(UIParent, "ANCHOR_NONE");
		tooltip:SetUnitDebuff(unit, i);
		b = textleft1:GetText();
		tooltip:Hide();
		if ( b and strfind(strlower(b), buff) ) then
			return "debuff", i, b;
		elseif ( c==b) then
			break;
		end
		--c = b;
	end
	tooltip:Hide();
end

function CancelBuff(...)
	for j=1, getn(arg) do
   	local buff = strlower(arg[j]);
   	for i=0, 24 do
   		SM_Tooltip:SetOwner(UIParent, "ANCHOR_NONE");
   		SM_Tooltip:SetPlayerBuff(i);
   		local name = SM_TooltipTextLeft1:GetText();
   		if ( not name ) then break end;
   		if ( strfind(strlower(name), buff) ) then
   			CancelPlayerBuff(i);
   		end
   		SM_Tooltip:Hide();
   	end
	end
end

function SM_Pickup(bag, slot)
	if ( type(bag)=="string") then
		if ( SM_INV_SLOT[strupper(bag)] ) then
			bag=GetInventorySlotInfo(bag);
		else
			bag,slot=FindItem(bag);
		end
	end
	if ( bag and not slot ) then
		PickupInventoryItem(bag);
	elseif ( bag and slot ) then
		PickupContainerItem(bag, slot);
	end
end

function caststop(...)
	for i=1, arg.n do
		CastSpellByName(arg[i]);
		SpellStopCasting();
	end
end

function SM_Channel(spell)
	local cf = CastingBarFrame;
	local cd = GetSpellCooldown(SM_FindSpell(spell));
	if ( not cf.channeling and cd<=1.5 ) then
		cast(spell);
	end
end

function FindTradeSkillIndex(tradeskill)
	tradeskill=strlower(tradeskill);
	if ( TradeSkillFrame and TradeSkillFrame:IsVisible()) then
		for i=1,GetNumTradeSkills() do
			local tsn,tst,tsx=GetTradeSkillInfo(i);
			if (strlower(tsn)==tradeskill) then
				SelectTradeSkill(i);
				TradeSkillInputBox:SetNumber(tsx);
				TradeSkillFrame.numAvailable=tsx;
				return i, tsx;
			end
		end
	end
	if ( CraftFrame and CraftFrame:IsVisible()) then
		for i=1,GetNumCrafts() do
		--craftName, craftSubSpellName, craftType, numAvailable, isExpanded,?,?
			local tsn,_,_,tsx=GetCraftInfo(i);
			if (strlower(tsn)==tradeskill) then
				SelectCraft(i);
				return i, 'c';
			end
		end
	end
end

function CraftItem( tradeskill, tradeitem, count)
	if ( TradeSkillFrame and TradeSkillFrame:IsVisible() ) then
		HideUIPanel(TradeSkillFrame);
	end
	if ( CraftFrame and CraftFrame:IsVisible() ) then
		HideUIPanel(CraftFrame);
	end
	cast(tradeskill);
	local index, avail = FindTradeSkillIndex(tradeitem);
	if ( avail=='c' ) then
		DoCraft(index);
	elseif (avail and avail > 0) then
		local amount;
		count = count or 1;
		if ( count <= 0 ) then
		-- 0 to make all, -1 to leave 1
			amount =avail+count;
		else
		-- amount user entered
			amount=count;
		end
		amount = amount<1 and 1 or amount>avail and avail or amount;
		TradeSkillInputBox:SetNumber(amount);
		DoTradeSkill(index, amount);
	end
end

-- shortened replacements
-- also try Alias addon to save space, like to get player's mana

cast = CastSpellByName;
stopcast = SpellStopCasting;
echo = SM_print;
send = SendChatMessage;
buffed = FindBuff;
unbuff = CancelBuff;
pickup = SM_Pickup;

-- added debug print
function Printd(...)
	for i=1, arg.n do
		local t=arg[i] and (arg[i]~="" and arg[i] or '-""-' )or "-nil-";
		if ( type(t)=="boolean") then
			t="-"..tostring(t).."-";
		end
		DEFAULT_CHAT_FRAME:AddMessage(t,1,1,1);
	end
end

function PrintColor(r,g,b,...)
	for i=1, arg.n do
		local t=arg[i] and (arg[i]~="" and arg[i] or '-""-' )or "-nil-";
		if ( type(t)=="boolean") then
			t="-"..tostring(t).."-";
		end
		DEFAULT_CHAT_FRAME:AddMessage(t,r,g,b);
	end
end

Printc=PrintColor;

-- Prints a table in an organized format
function PrintTable(table, rowname, level) 
	if ( rowname == nil ) then rowname = "ROOT"; end
--Print(level)
	--level = level and level or 1;
	if ( not level ) then level = 1; end
	local msg = "";
	for i=1, level do 
		msg = msg .. "   ";	
	end

	if ( table == nil ) then Print (msg.."["..rowname.."] := nil "); return end
	if ( type(table) == "table" ) then
		Print(msg..rowname.." { ");
		for k,v in table do
			PrintTable(v,k,level+1);
		end
		Print(msg.."} ");
	elseif (type(table) == "function" ) then 
		Print(msg.."["..rowname.."] => {{FunctionPtr*}}");
	else
		Print(msg.."["..rowname.."] => "..table);
	end
end

Printt=PrintTable;