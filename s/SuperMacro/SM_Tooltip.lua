--SM_VARS.macroTip1 = 1; -- for spell, item
--SM_VARS.macroTip2 = 1; -- for macro code

oldActionButton_SetTooltip=ActionButton_SetTooltip;
function ActionButton_SetTooltip()
	oldActionButton_SetTooltip();
	SM_ActionButton_SetTooltip();
end

function SM_ActionButton_SetTooltip()
	local actionid=ActionButton_GetPagedID(this);
	local macroname=GetActionText(actionid); --or getglobal(this:GetName().."Name"):GetText();
	if ( macroname ) then
		local macro, _, body = GetMacroInfo(GetMacroIndexByName(macroname));
		
		-- for supermacros
		local superfound = SM_ACTION[actionid];
		if ( superfound ) then
			macro,_,body=GetSuperMacroInfo(superfound);
			GameTooltipTextLeft1:SetText(macro);
			GameTooltip:Show();
		end

		if ( SM_VARS.macroTip1==1 ) then
			local actiontype, spell = SM_GetActionSpell(macro, superfound);
			if ( actiontype=="spell" ) then
				local id, book = SM_FindSpell(spell);
				GameTooltip:SetSpell(id, book);
				local s, r = GetSpellName(id, book);
				if ( r ) then
					GameTooltipTextRight1:SetText("|cff00ffff"..r.."|r");
					GameTooltipTextRight1:Show();
					GameTooltip:Show();
				end
				return;
			elseif ( actiontype=="item" ) then
				local id, book = FindItem(spell);
				if ( book ) then
					GameTooltip:SetBagItem(id, book);
				else
					GameTooltip:SetInventoryItem( 'player', id);
				end
				return;
			end
		end
		if ( SM_VARS.macroTip2 == 1 ) then
			-- show macro code
			if ( not GameTooltipTextLeft1:GetText() ) then return; end
			body = gsub(body, "\n$", "");
			GameTooltipTextLeft1:SetText( "|cff00ffff"..macro.."|r");
			GameTooltipTextLeft2:SetText("|cffffffff"..body.."|r");
			GameTooltipTextLeft2:Show();
			GameTooltipTextLeft1:SetWidth(284);
			GameTooltipTextLeft2:SetWidth(284);
			GameTooltip:SetWidth(300);
			GameTooltip:SetHeight( GameTooltipTextLeft1:GetHeight() + GameTooltipTextLeft2:GetHeight() + 23);
			GameTooltipTextLeft2:SetNonSpaceWrap(true);
			return;
		end
	end
	-- brighten rank text on all tooltips
	if ( GameTooltipTextRight1:GetText() ) then
		local t = GameTooltipTextRight1:GetText();
		GameTooltipTextRight1:SetText("|cff00ffff"..t.."|r");
	end
	-- show crit info for Attack
	if ( GameTooltipTextLeft1:GetText()=="Attack" ) then
		id, book = FindSpell("Attack","");
		GameTooltip:SetSpell(id, book);
		GameTooltip:Show();
	end
end

function SM_ActionButton_OnLeave()
	this.updateTooltip=nil;
	GameTooltipTextLeft2:SetWidth(100);
	GameTooltipTextLeft2:SetText("");
	GameTooltip:Hide();
end

local oldGetActionCooldown = GetActionCooldown;
function GetActionCooldown( actionid )
	-- start, duration, enable
	local macro=GetActionText(actionid);
	if ( macro and SM_VARS.checkCooldown==1 ) then
		local name, icon, body = GetMacroInfo(GetMacroIndexByName(macro));
		--  for supermacros
		local superfound = SM_ACTION[actionid];
		if ( superfound ) then
			name,icon,body=GetSuperMacroInfo(superfound);
		end

		local macroname, pic;
		if ( this ) then
			macroname=getglobal(this:GetName().."Name");
			if ( macroname ) then
				macroname:SetText(name);
			end
			pic = getglobal(this:GetName().."Icon");
			if ( pic ) then
				pic:SetTexture(icon);
			end
		end

		local actiontype, spell, texture = SM_GetActionSpell(name, superfound);
		if ( actiontype=="spell") then
			if ( SM_VARS.replaceIcon==1 and texture and pic) then
				pic:SetTexture(texture);
			end
			local id, book = SM_FindSpell(spell);
			return GetSpellCooldown( id, book);
		elseif ( actiontype=="item") then
			if ( SM_VARS.replaceIcon==1 and texture and pic) then
				pic:SetTexture(texture);
			end
			local id, book, texture, count = FindItem(spell);
			if ( count>1 and macroname ) then
				macroname:Hide();
				getglobal(this:GetName().."Count"):SetText(count);
			elseif ( macroname ) then
				macroname:Show();
				getglobal(this:GetName().."Count"):SetText("");
			end
			if ( book ) then
				return GetContainerItemCooldown(id, book);
			elseif ( id ) then
				return GetInventoryItemCooldown('player', id);
			end
		end
	end
	return oldGetActionCooldown( actionid );
end

function FindFirstSpell( text )
	if not text then return nil end;
	local body = text;
	if (ReplaceAlias and ASFOptions.aliasOn) then
		-- correct aliases
		body = ReplaceAlias(body);
	end
	local id, book, texture, spell;
	while ( string.find(body, "CastSpellByName") ) do
		spell = gsub(body,'^.-CastSpellByName.-%(.-(["\'])(.-)%1.*$','%2');
		id, book = SM_FindSpell(spell);
		if ( id ) then
			texture = GetSpellTexture(id, book);
			break;
		end
		body = gsub(body, "CastSpellByName","",1);
	end
	if ( not id and string.find(body,"/cast") ) then
			spell = gsub(body,"^.*/cast%s*([%w'%(%) ]+)[\n]?%s*.*$","%1");
			id, book = SM_FindSpell(spell);
			if ( id and book ) then
				texture = GetSpellTexture(id, book);
			end
	end
	if ( not id ) then
		while ( string.find(body, "[%p%s]cast%(") ) do
			spell = gsub(body,'^.-[%p%s]-cast%(.-(["\'])(.-)%1.*$','%2');
			id, book = SM_FindSpell(spell);
			if ( id ) then
				texture = GetSpellTexture(id, book);
				break;
			end
			body = gsub(body, "[%p%s]cast%(","", 1);
		end
	end
	if ( not id ) then
		while ( string.find(body, "CastSpell")) do
			spell = gsub(body,'^.-CastSpell.-%(%s-(.-)%s*%).*$','%1');
			local _,_,spellid = strfind(spell,"^(%d+).*");
			if ( spellid ) then
				local _,_,spellbook=strfind(spell,"^.-"..spellid..",%s*'(%a+)'%s*");
				id=spellid;
				book=spellbook or 'spell';
				texture = GetSpellTexture(id, book);
				break;
			end
			body = gsub(body, "CastSpell","", 1);
		end
	end
	return id, book, texture, spell;
end

function FindFirstItem( text )
	if not text then return nil end;
	local body = text;
	if (ReplaceAlias and ASFOptions.aliasOn) then
		-- correct aliases
		body = ReplaceAlias(body);
	end
	local bag, slot, texture, count, item;
	if ( strfind(body,"UseItemByName") ) then
		while ( string.find(body, "UseItemByName") ) do
			item = gsub(body,'^.-UseItemByName.-%(.-(["\'])(.-)%1.*$','%2');
			bag, slot, texture, count = FindItem(item);
			if ( bag ) then
				return bag, slot, texture, count, item;
			end
			body = gsub(body, "UseItemByName","", 1);
		end
	end
	if ( strfind(body,"/use") ) then
		while ( string.find(body, "/use") ) do
			item = gsub(body,'^.-/use *(.-) *\n.*$','%1');
			if ( item==body ) then
				item = gsub(body,'^.-/use *(.-) *$','%1');
			end
			bag, slot, texture, count = FindItem(item);
			if ( bag ) then
				return bag, slot, texture, count, item;
			end
			body = gsub(body, "/use","", 1);
		end
	end
	if ( strfind(body,"use") ) then
		while ( string.find(body, "use") ) do
			item = gsub(body,'^.-use.-%(.-(["\'])(.-)%1.*$','%2');
			bag, slot, texture, count = FindItem(item);
			if ( bag ) then
				return bag, slot, texture, count, item;
			end
			body = gsub(body, "use","", 1);
		end
	end
	while ( strfind(body, "UseInventoryItem") ) do
		bag = gsub(body,'^.-UseInventoryItem.-(%d+)%s-%).*$','%1');
		if ( bag~=body) then
			texture = GetInventoryItemTexture('player', bag);
			count = GetInventoryItemCount('player', bag);
		end
		if ( texture ) then
			item=ItemLinkToName( GetInventoryItemLink('player', bag) );
			return bag, slot, texture, count, item;
		end
		body = gsub(body, "UseInventoryItem","", 1);
	end
	while ( strfind(body, "UseContainerItem") ) do
		bag = gsub(body,'^.-UseContainerItem.-(%d+)%s-,%s-(%d+)%s-%).*$','%1');
		slot = gsub(body,'^.-UseContainerItem.-(%d+)%s-,%s-(%d+)%s-%).*$','%2');
		if ( bag~=body and slot~=body) then
			texture, count = GetContainerItemInfo(bag, slot);
		end
		if ( bag~=body and slot~=body and texture ) then
			item=ItemLinkToName( GetContainerItemLink(bag, slot) );
			return bag, slot, texture, count, item;
		end
		body = gsub(body, "UseContainerItem","", 1);
	end
end
