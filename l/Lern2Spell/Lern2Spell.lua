
local sels = SpecialEventsEmbed:GetInstance("Learn Spell 1")
local gratuity = Gratuity:GetInstance("1")
gratuity:RegisterTooltip(Lern2SpellTooltip)

Lern2Spell = AceAddon:new({
	name          = "Lern2Spell",
	description   = "Automatically updates actionbar spells",
	version       = tonumber(string.sub("$Revision: 1706 $", 12, -3)),
	releaseDate   = string.sub("$Date: 2006-05-11 21:45:32 -0500 (Thu, 11 May 2006) $", 8, 17),
	aceCompatible = 102,
	author        = "Tekkub Stoutwrithe",
	email         = "tekkub@gmail.com",
	category      = "interface",
	cmd           = AceChatCmd:new({"/l2s", "/lern2spell"}, {}),
})


function Lern2Spell:Enable()
	sels:RegisterEvent(self, "SPECIAL_LEARNED_SPELL")
end


function Lern2Spell:SPECIAL_LEARNED_SPELL(spell, rank)
	for btn=1,120 do
		local n, r = self:ActionIsSpell(btn)
		if n and n == spell and ((r or "") ~= rank) then
			local i = self:GetSpellIndex(spell, rank)
			if not i then return end

			local n, r = GetSpellName(i,BOOKTYPE_SPELL)
			self.cmd:msg("Upgrading button #%s - %s ~ %s", btn, n, r or "??")
			PickupSpell(i, BOOKTYPE_SPELL)
			PlaceAction(btn)

			repeat
				if CursorHasItem() or CursorHasSpell() then PickupSpell(1, BOOKTYPE_SPELL) end
			until not CursorHasItem() and not CursorHasSpell()
		end
	end
end


function Lern2Spell:GetSpellIndex(spell, rank)
	assert(spell, "No spell passed")

	local i, n, r = 1
	repeat
		n, r = GetSpellName(i, BOOKTYPE_SPELL)
		if n and n == spell and r == rank then return i end
		i = i+1
	until not n
end


function Lern2Spell:ActionIsSpell(id)
	if not id or GetActionText(id) then return end

	gratuity:SetAction(id)
	return gratuity:GetLine(1)
end


-----------------------------------
--      Load this bitch up!      --
-----------------------------------
Lern2Spell:RegisterForLoad()

