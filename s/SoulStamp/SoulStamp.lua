-- SoulStamp
SOULSTAMP_VERSION="0.1";
-- This addon tracks the source of soul shards (the mob or player they were created from)
-- and adds this information under a tooltip you can see when mousing over the shard.
-- This information is at the moment only visible to you. 
--
-- Much of the infrastructure code for detecting spell casts 
-- was shamelessly stolen from CountDoom.
--
-- Copyright (c) 2006 Colin Walters <cgwalters@gmail.com>
-- All rights reserved.
-- 
-- Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
--
--    * Redistributions of source code must retain the above copyright notice, this list 
--      of conditions and the following disclaimer.
--    * Redistributions in binary form must reproduce the above copyright notice, this list
--      of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
--    * The names of its contributors may not be used to endorse 
--      or promote products derived from this software without specific prior written permission.
--
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, 
-- INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
-- IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, 
-- OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, 
-- DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, 
-- STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, 
-- EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--

SoulStamp = {};
SoulStamp.debug = false;
SoulStamp.initialized = false;

-- Utility functions stolen from CountDoom
SoulStamp.Chat = function(msg, r, g, b)
    local msgOutput = DEFAULT_CHAT_FRAME;
    if(msgOutput) then
        msgOutput:AddMessage(msg, r, g, b);
    end
end;

SoulStamp.Debug = function(msg, r, g, b) 
    if (SoulStamp.debug) then
    	SoulStamp.Chat("<SSDebug>: " .. msg, r, g, b);
    end
end;

SoulStamp.ToString = function(arg1)
    local argType = type(arg1);
    
    if argType == "nil" then
        return "nil";
    elseif argType == "boolean" then
        if arg1 then 
            return "true";
        else
            return "false";
        end
    else
        return "" .. arg1;
    end
end;

-- Stolen from auctioneer
SoulStamp.BreakLink = function(link)
	local i,j, itemID, enchant, randomProp, uniqID, name = string.find(link, "|Hitem:(%d+):(%d+):(%d+):(%d+)|h[[]([^]]+)[]]|h");
	return tonumber(itemID or 0), tonumber(randomProp or 0), tonumber(enchant or 0), tonumber(uniqID or 0), name;
end
SoulStamp.BreakItemKey = function(itemKey)
	local i,j, itemID, randomProp, enchant = string.find(itemKey, "(%d+):(%d+):(%d+)");
	return tonumber(itemID or 0), tonumber(randomProp or 0), tonumber(enchant or 0);
end

SoulStamp.lastSpellTarget = nil;
SoulStamp.drainSoulActive = false;
SoulStampShardSourceMap = {};
SoulStamp.shardSourceMap = SoulStampShardSourceMap;
local initSoulStampShardSourceMap = SoulStampShardSourceMap;

function SSFrame_OnLoad()
	this:RegisterEvent("ADDON_LOADED");
    this:RegisterEvent("VARIABLES_LOADED");
    this:RegisterEvent("SPELLCAST_STOP");
    this:RegisterEvent("SPELLCAST_FAILED");
    this:RegisterEvent("SPELLCAST_INTERRUPTED");
    this:RegisterEvent("ITEM_PUSH");
    this:RegisterEvent("CHAT_MSG_LOOT");      
    this:RegisterEvent("BAG_UPDATE");
end;

function SSFrame_OnEvent(event)
    if (event == "VARIABLES_LOADED") then
        SoulStamp.Initialize();
    elseif event == "SPELLCAST_INTERRUPTED" or event == "SPELLCAST_FAILED" then
        SoulStamp.SpellCastFailedCallback()
    -- User stopped casting a spell
    elseif event == "SPELLCAST_STOP" then
		SoulStamp.SpellCastStoppedCallback()
	elseif event == "ITEM_PUSH" then
		SoulStamp.ItemPushCallback(arg1, arg2)
	elseif event == "CHAT_MSG_LOOT" then
		SoulStamp.LootCallback(arg1)
	elseif event == "BAG_UPDATE" then
		SoulStamp.BagUpdateCallback(arg1)
	elseif event == "ADDON_LOADED" and arg1 == "SoulStamp" then
		SoulStamp.shardSourceMap = SoulStampShardSourceMap;
    end;
 end;

SoulStamp.IsItemSoulShard = function(name) 
	return string.find(name, "Soul Shard");
end;

SoulStamp.ForeachSoulShardInBag = function(func, bag)
	for slot=1,GetContainerNumSlots(bag) do
		local link = GetContainerItemLink(bag,slot);
     	if (link) then
 	   		local itemID, randomProp, enchant, uniqID, lame = SoulStamp.BreakLink(link);      
       		if (SoulStamp.IsItemSoulShard(lame)) then
       			SoulStamp.Debug("Soul shard at slot=" .. SoulStamp.ToString(slot) .. " uniqId=" .. SoulStamp.ToString(uniqId));
				func(uniqID, lame);
       		end
    	end
    end
end;

SoulStamp.ForeachSoulShard = function(func, bag) 
	local bag;
    for bag=0,4 do
    	SoulStamp.ForeachSoulShardInBag(func, bag);
    end;
end;

SoulStamp.Initialize = function()
	SLASH_SOULSTAMP1 = "/soulstamp";
    SlashCmdList["SOULSTAMP"] = function(msg)
        SoulStamp.SlashCommand(msg);
    end
	SoulStamp.Debug("SoulStamp " .. SOULSTAMP_VERSION .. " by Xalan of Crushridge initalized");

    -- Hook into the tooltip popup functions
	SoulStamp.OrigContainerFrameItemButton_OnEnter = ContainerFrameItemButton_OnEnter;    
	ContainerFrameItemButton_OnEnter = SoulStamp.ContainerFrameItemButton_OnEnter;
	
	SoulStamp.DumpShards();
end;

SoulStamp.SlashCommand = function(msg)
    msg = string.lower(msg);
    local a, b, c, n = string.find (msg, "(%w+) ([_%w]+)");
    
    if( c == nil and n == nil ) then
        a, b, c = string.find (msg, "(%w+)");
    end
    
    if (c ~= nil) then
        SoulStamp.Debug("c:"..c);
    else
        SoulStamp.Debug("c: nil");
    end
    
    if (n ~= nil) then
        SoulStamp.Debug("n:"..n);
    else
        SoulStamp.Debug("n: nil");
    end

    if(c == "debug") then
    	SoulStamp.debug = not SoulStamp.debug;
    	if (SoulStamp.debug) then
    		SoulStamp.Chat("SoulStamp debug is now on");
    	else
    		SoulStamp.Chat("SoulStamp debug is now off");
    	end
    elseif (c == "dumpshards") then
    	SoulStamp.DumpShards();
    elseif (c == "dumpmap") then
    	SoulStamp.DumpShardMap();    	
    end
end

SoulStamp.DumpShards = function()	
	local function ssCallback(uniqID, lame)
		SoulStamp.Chat("shard=" .. uniqID);
    end;	
	SoulStamp.ForeachSoulShard(ssCallback);	
end;

SoulStamp.DumpShardMap = function()	
	for k,v in pairs(SoulStamp.shardSourceMap) do
		SoulStamp.Chat("shard=" .. SoulStamp.ToString(k) .. " maps to " .. SoulStamp.ToString(v));
	end;
end;

SoulStamp.SpellCastStartCallback = function (spellName, spellRank) 
	SoulStamp.Debug("Cast of: " .. SoulStamp.ToString(spellName) .. " Rank: " .. SoulStamp.ToString(spellRank));
	SoulStamp.lastSpellTarget = UnitName("target");	
end;

SoulStamp.SpellCastFailedCallback = function () 
	SoulStamp.Debug("Last spell cast failed");
end;

SoulStamp.SpellCastStoppedCallback = function () 
	SoulStamp.Debug("Last spell cast stopped");
end;

SoulStamp.ItemPushCallback = function (stackSize, iconPath) 
	SoulStamp.Debug("Item push: " .. SoulStamp.ToString(stackSize) .. " " .. SoulStamp.ToString(iconPath));
end;

SoulStamp.OnSoulShardCreated = function() 
	SoulStamp.Debug("Soul shard created from " .. SoulStamp.ToString(SoulStamp.lastSpellTarget));
	if (not SoulStamp.lastSpellTarget) then
		SoulStamp.Debug("ERROR: no previous spell target after creating soul shard")
		return;
	end;
	local foundUnknownShard = false;
	local function ssCallback(uniqID, lame)
		if (foundUnknownShard) then
			return;
		end;
		if (not SoulStamp.shardSourceMap[uniqID]) then
			SoulStamp.Debug("assigning shard " .. uniqID .. " to " .. SoulStamp.lastSpellTarget);
	    	SoulStamp.shardSourceMap[uniqID] = SoulStamp.lastSpellTarget;
	        foundUnknownShard = true;  
        end;
    end;	
	SoulStamp.ForeachSoulShard(ssCallback);	
end;

SoulStamp.LootCallback = function(msg)
	SoulStamp.Debug("Loot: " .. SoulStamp.ToString(msg));
	if (string.find(msg, "You create.+Soul Shard")) then	
		SoulStamp.OnSoulShardCreated();
	end
end;

SoulStamp.BagUpdateCallback = function(bag) 
	SoulStamp.Debug("Bag update: " .. SoulStamp.ToString(bag));	
end;

SoulStamp.ContainerFrameItemButton_OnEnter = function ()
	SoulStamp.OrigContainerFrameItemButton_OnEnter();
	local frameID = this:GetParent():GetID();
	local frame = GameTooltip;
	local buttonID = this:GetID();
	local link = GetContainerItemLink(frameID, buttonID);
	
	-- SoulStamp.Debug("ContainerFrameItemButton_OnEnter frameId=" .. SoulStamp.ToString(frameID) .. " buttonID=" .. SoulStamp.ToString(buttonID) .. " link=" .. SoulStamp.ToString(link));	
	
	if (not link) then
		return;
	end;
	
	local itemID, randomProp, enchant, uniqID, lame = SoulStamp.BreakLink(link);
	local itemKey = itemID..":"..randomProp..":"..enchant;	
	
	-- SoulStamp.Debug("ContainerFrameItemButton_OnEnter lame=" .. SoulStamp.ToString(lame) .. "uniqID=" .. SoulStamp.ToString(uniqID));
	
	if (not string.find(lame, "Soul Shard")) then
		return;
	end;	

	local source = SoulStamp.shardSourceMap[uniqID];
	if (not source) then
		frame:AddLine("Source unknown", 0.6, 0.6, 0.6);
	else
		frame:AddLine("Drained from " .. source .. "", 0.7, 0, 0);
	end;
	frame:Show();
end

-- Hook into CastSpell
SoulStamp.oldCastSpell = CastSpell;
SoulStamp.OnCastSpell = function (spellId,spellbookTabNum)
    local spellName, spellRank = GetSpellName(spellId, spellbookTabNum);
    if spellRank ~= nil then
    	local _, _, spellRankString = string.find(spellRank, "(%d+)");
        rank = tonumber(spellRankString);
    end;
    
    SoulStamp.SpellCastStartCallback(spellName, rank);

    SoulStamp.oldCastSpell(spellId, spellbookTabNum);
end;
CastSpell = SoulStamp.OnCastSpell;

SoulStamp.oldCastSpellByName = CastSpellByName;
SoulStamp.OnCastSpellByName = function(spellString)
    local startIndex, endIndex, spellName = string.find(spellString, "(.+)%(");
    local _, _, spellRankStr = string.find(spellString, "([%d]+)");
    local rank = nil;
	rank = tonumber(spellRankStr);    

    SoulStamp.SpellCastStartCallback(spellName, rank);

    SoulStamp.oldCastSpellByName(spellString);
end;
CastSpellByName = SoulStamp.OnCastSpellByName;

SoulStamp.oldUseAction = UseAction;
SoulStamp.OnUseAction = function (a1, a2, a3)
    
    SoulStamp.Debug("Got OnUseAction: " .. SoulStamp.ToString(a1));
    
    -- Only process if it isn't a macro
    if GetActionText(a1) == nil then 
        -- This screwy code is stolen from CountDoom
        SS_SpellDetector:Hide();
        SS_SpellDetector:SetOwner(SoulStampFrame,"ANCHOR_NONE");
        SS_SpellDetector:SetAction(a1);

        local spellName = nil;
        
        if SS_SpellDetectorTextLeft1 ~= nil then
            spellName = SS_SpellDetectorTextLeft1:GetText();
        end;
        
        local spellRank = nil;
        if SS_SpellDetectorTextRight1 ~= nil then 
            spellRank = SS_SpellDetectorTextRight1:GetText();
        end;
        local rank = nil;
        
        if spellRank ~= nil then
            local _, _, spellRankString = string.find( spellRank, "[^%d]*(%d+)");
            rank = tonumber(spellRankString);
        end;
        
        SoulStamp.SpellCastStartCallback(spellName, rank);
    end

    SoulStamp.oldUseAction(a1, a2, a3);
end;
UseAction = SoulStamp.OnUseAction;
