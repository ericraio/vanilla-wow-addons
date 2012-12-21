--[[

	Enchantrix v3.6.1 (Platypus)
	$Id: Enchantrix.lua 859 2006-05-11 13:35:49Z aradan $

	By Norganna
	http://enchantrix.org/

	This is an addon for World of Warcraft that add a list of what an item
	disenchants into to the items that you mouse-over in the game.

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GLP.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

]]

-- Local functions
local addonLoaded
local onLoad
local pickupInventoryItemHook
local pickupContainerItemHook
local onEvent

Enchantrix.Version = "3.6.1"
if (Enchantrix.Version == "<".."%version%>") then
	Enchantrix.Version = "3.5.DEV"
end

local DisenchantEvent = {}

-- This function differs from onLoad in that it is executed
-- after variables have been loaded.
function addonLoaded(hookArgs, event, addOnName)
	if (event ~= "ADDON_LOADED") or (string.lower(addOnName) ~= "enchantrix") then
		return
	end
	Stubby.UnregisterEventHook("ADDON_LOADED", "Enchantrix")

	-- Call AddonLoaded for other objects
	Enchantrix.Storage.AddonLoaded() -- Sets up saved variables so should be called first
	Enchantrix.Barker.AddonLoaded()
	Enchantrix.Command.AddonLoaded()
	Enchantrix.Config.AddonLoaded()
	Enchantrix.Locale.AddonLoaded()
	Enchantrix.Tooltip.AddonLoaded()

	Enchantrix.Revision = Enchantrix.Util.GetRevision("$Revision: 859 $")
	for name, obj in pairs(Enchantrix) do
		if type(obj) == "table" then
			Enchantrix.Revision = math.max(Enchantrix.Revision, Enchantrix.Util.GetRevision(obj.Revision))
		end
	end

	Stubby.RegisterAddOnHook("Auctioneer", "Enchantrix", Enchantrix.Command.AuctioneerLoaded);

	-- Register disenchant detection hooks
	Stubby.RegisterFunctionHook("PickupContainerItem", 400, pickupContainerItemHook)
	Stubby.RegisterFunctionHook("PickupInventoryItem", 400, pickupInventoryItemHook)

	Stubby.RegisterEventHook("SPELLCAST_START", "Enchantrix", onEvent)
	Stubby.RegisterEventHook("SPELLCAST_STOP", "Enchantrix", onEvent)
	Stubby.RegisterEventHook("SPELLCAST_FAILED", "Enchantrix", onEvent)
	Stubby.RegisterEventHook("SPELLCAST_INTERRUPTED", "Enchantrix", onEvent)
	Stubby.RegisterEventHook("LOOT_OPENED", "Enchantrix", onEvent)

	local vstr = string.format("%s-%d", Enchantrix.Version, Enchantrix.Revision)
	Enchantrix.Util.ChatPrint(string.format(_ENCH('FrmtWelcome'), vstr), 0.8, 0.8, 0.2)
	Enchantrix.Util.ChatPrint(_ENCH('FrmtCredit'), 0.6, 0.6, 0.1)
end

-- Register our temporary command hook with stubby
function onLoad()
	Stubby.RegisterBootCode("Enchantrix", "CommandHandler", [[
		local function cmdHandler(msg)
			local i,j, cmd, param = string.find(string.lower(msg), "^([^ ]+) (.+)$")
			if (not cmd) then cmd = string.lower(msg) end
			if (not cmd) then cmd = "" end
			if (not param) then param = "" end
			if (cmd == "load") then
				if (param == "") then
					Stubby.Print("Manually loading Enchantrix...")
					LoadAddOn("Enchantrix")
				elseif (param == "always") then
					Stubby.Print("Setting Enchantrix to always load for this character")
					Stubby.SetConfig("Enchantrix", "LoadType", param)
					LoadAddOn("Enchantrix")
				elseif (param == "never") then
					Stubby.Print("Setting Enchantrix to never load automatically for this character (you may still load manually)")
					Stubby.SetConfig("Enchantrix", "LoadType", param)
				else
					Stubby.Print("Your command was not understood")
				end
			else
				Stubby.Print("Enchantrix is currently not loaded.")
				Stubby.Print("  You may load it now by typing |cffffffff/enchantrix load|r")
				Stubby.Print("  You may also set your loading preferences for this character by using the following commands:")
				Stubby.Print("  |cffffffff/enchantrix load always|r - Enchantrix will always load for this character")
				Stubby.Print("  |cffffffff/enchantrix load never|r - Enchantrix will never load automatically for this character (you may still load it manually)")
			end
		end
		SLASH_ENCHANTRIX1 = "/enchantrix"
		SLASH_ENCHANTRIX2 = "/enchant"
		SLASH_ENCHANTRIX3 = "/enx"
		SlashCmdList["ENCHANTRIX"] = cmdHandler
	]]);

	Stubby.RegisterBootCode("Enchantrix", "Triggers", [[
		if Stubby.GetConfig("Enchantrix", "LoadType") == "always" then
			LoadAddOn("Enchantrix")
		else
			Stubby.Print("]].._ENCH('MesgNotloaded')..[[")
		end
	]]);

	SLASH_ENCHANTRIX1 = "/enchantrix";
	SLASH_ENCHANTRIX2 = "/enchant";
	SLASH_ENCHANTRIX3 = "/enx";
	SlashCmdList["ENCHANTRIX"] = function(msg) Enchantrix.Command.HandleCommand(msg) end

	Stubby.RegisterEventHook("ADDON_LOADED", "Enchantrix", addonLoaded)
end

function pickupInventoryItemHook(funcArgs, retVal, slot)
	-- Remember last activated item
	if slot then
		DisenchantEvent.spellTarget = GetInventoryItemLink("player", slot)
	end
end

function pickupContainerItemHook(funcArgs, retVal, bag, slot)
	-- Remember last activated item
	if bag and slot then
		DisenchantEvent.spellTarget = GetContainerItemLink(bag, slot)
	end
end

function onEvent(funcVars, event, spellName, spellDuration)
	if event == "SPELLCAST_START" then
		if spellName == _ENCH('ArgSpellname') then
			DisenchantEvent.started = DisenchantEvent.spellTarget
			DisenchantEvent.finished = nil
			DisenchantEvent.startTime = GetTime()
			DisenchantEvent.spellDuration = spellDuration / 1000  -- Convert ms to s
		else
			DisenchantEvent.started = nil
			DisenchantEvent.finished = nil
		end
		return
	end
	if (event == "SPELLCAST_FAILED") or (event == "SPELLCAST_INTERRUPTED") then
		DisenchantEvent.started = nil
		DisenchantEvent.finished = nil
		return
	end
	if event == "SPELLCAST_STOP" then
		DisenchantEvent.finished = DisenchantEvent.started
		DisenchantEvent.started = nil
		return
	end
	if event == "LOOT_OPENED" then
		if DisenchantEvent.finished then
			-- Make sure loot windows opens within a few seconds from expected spell completion time
			-- Normal range of lootLatency appears to be around -0.1 - 0.7s
			local lootLatency = GetTime() - (DisenchantEvent.startTime + DisenchantEvent.spellDuration)
			if (lootLatency > -1) and (lootLatency < 2) then
				Enchantrix.Util.ChatPrint(string.format(_ENCH("FrmtFound"), DisenchantEvent.finished))
				local sig = Enchantrix.Util.GetSigFromLink(DisenchantEvent.finished)
				for i = 1, GetNumLootItems(), 1 do
					if LootSlotIsItem(i) then
						local icon, name, quantity, rarity = GetLootSlotInfo(i)
						local link = GetLootSlotLink(i)
						Enchantrix.Util.ChatPrint(string.format("  %s x%d", link, quantity))
						-- Save result
						local reagentID = Enchantrix.Util.GetItemIdFromLink(link)
						if reagentID then
							Enchantrix.Storage.SaveDisenchant(sig, reagentID, quantity)
						end
					end
				end
			end
		end
		DisenchantEvent.started = nil
		DisenchantEvent.finished = nil
		return
	end
end

-- Execute on load
onLoad()
