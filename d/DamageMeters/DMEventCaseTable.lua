--[[ DamageMeters_eventCaseTable

This table defines which msgInfos are checked for which events.  Although its a bit of a pain
maintaining this big list there are several big reasons why we do so.  First and foremost, we
gain some information about the players involved in a message from the event type.  For example,
we can deduce that if the event was CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS and the message was of the 
type "[Someone] hit [someone] for [amount] damage." that the entity being hit was not us but rather
a pet or totem of ours.  The second reason for this table is to greatly reduce the amount of patterns
each event is compared against.  The final reason is that sometimes the order of parsing is critical.

Here is an example:

HEALEDOTHEROTHER = "%s's %s heals %s for %d."
HEALEDCRITOTHEROTHER - "%s's %s critically heals %s for %d."

If we feed the following message into the above patterns, the 
HEALEDOTHEROTHER will generate the following elements:

"Dandelion's Healing Touch critically heals Sterne for 1234."
->
"Dandelion", "Healing Touch critically", "Sterne", 1234

Hence, we must in this case test for HEALEDCRITOTHEROTHER before HEALEDOTHEROTHER.

]]--

DamageMeters_eventCaseTable = {
	[DM_MSGTYPE_DAMAGE] = {
		CHAT_MSG_COMBAT_SELF_HITS = { 
			[1] = { n = "_COMBATHITSELFOTHER" }, -- ok
			[2] = { n = "_COMBATHITCRITSELFOTHER" }, -- ok
			-- Guns/Bows.
			[3] = { n = "_SPELLLOGSELFOTHER" }, -- ok
			[4] = { n = "_SPELLLOGCRITSELFOTHER" }, -- ok
			-- Wands (ie. with Frost damage, etc).
			[5] = { n = "_SPELLLOGSCHOOLSELFOTHER" }, -- ok
			[6] = { n = "_SPELLLOGCRITSCHOOLSELFOTHER" }, -- ok
			-- Environmental
			[7] = { n = "_VSENVIRONMENTALDAMAGE_FALLING_SELF", msgType=DM_MSGTYPE_DAMAGERECEIVED }, -- ok
			[8] = { n = "_VSENVIRONMENTALDAMAGE_LAVA_SELF", msgType=DM_MSGTYPE_DAMAGERECEIVED }, -- ok
		},
		CHAT_MSG_SPELL_SELF_DAMAGE = {
			-- These two are for school-less "spells" like Heroic Strike.
			[1] = { n = "_SPELLLOGSELFOTHER" }, -- ok
			[2] = { n = "_SPELLLOGCRITSELFOTHER" }, -- ok
			-- These are for regular spells (ie. with Frost damage, etc).
			[3] = { n = "_SPELLLOGSCHOOLSELFOTHER" }, -- ok
			[4] = { n = "_SPELLLOGCRITSCHOOLSELFOTHER" }, -- ok
		},

		CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE = {
			[1] = { n = "_PERIODICAURADAMAGESELFOTHER" }, -- ok (rend)
			[2] = { n = "_PERIODICAURADAMAGEOTHEROTHER" }, -- ok
		},
		CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE = {
			[1] = { n = "_PERIODICAURADAMAGESELFOTHER" }, 
			[2] = { n = "_PERIODICAURADAMAGEOTHEROTHER" }, -- ok
		},

		CHAT_MSG_COMBAT_PARTY_HITS = {
			[1] = { n = "_COMBATHITOTHEROTHER", sourceRelation=DamageMeters_Relation_PARTY }, -- ok
			[2] = { n = "_COMBATHITCRITOTHEROTHER", sourceRelation=DamageMeters_Relation_PARTY }, -- ok
			-- Wands and Bows/Guns as of WoW 2.0
			[3] = { n = "_SPELLLOGCRITSCHOOLOTHEROTHER", sourceRelation=DamageMeters_Relation_PARTY }, -- ok
			[4] = { n = "_SPELLLOGSCHOOLOTHEROTHER", sourceRelation=DamageMeters_Relation_PARTY }, -- ok
			[5] = { n = "_SPELLLOGCRITOTHEROTHER", sourceRelation=DamageMeters_Relation_PARTY }, -- ok
			[6] = { n = "_SPELLLOGOTHEROTHER", sourceRelation=DamageMeters_Relation_PARTY }, -- ok
			[7] = { n = "_SPELLSPLITDAMAGEOTHEROTHER", sourceRelation=DamageMeters_Relation_PARTY },
			-- Environmental
			[8] = { n = "_VSENVIRONMENTALDAMAGE_FALLING_OTHER", sourceRelation=DamageMeters_Relation_PARTY },
			[9] = { n = "_VSENVIRONMENTALDAMAGE_LAVA_OTHER", sourceRelation=DamageMeters_Relation_PARTY },
		},
		CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS = {
			[1] = { n = "_COMBATHITOTHEROTHER" }, -- ok
			[2] = { n = "_COMBATHITCRITOTHEROTHER" }, -- ok
			-- Wands and Bows/Guns as of WoW 2.0
			[3] = { n = "_SPELLLOGCRITSCHOOLOTHEROTHER", sourceRelation=DamageMeters_Relation_FRIENDLY }, -- ok
			[4] = { n = "_SPELLLOGSCHOOLOTHEROTHER", sourceRelation=DamageMeters_Relation_FRIENDLY }, -- ok
			[5] = { n = "_SPELLLOGCRITOTHEROTHER", sourceRelation=DamageMeters_Relation_FRIENDLY }, -- ok
			[6] = { n = "_SPELLLOGOTHEROTHER", sourceRelation=DamageMeters_Relation_FRIENDLY }, -- ok
			[7] = { n = "_SPELLSPLITDAMAGEOTHEROTHER", sourceRelation=DamageMeters_Relation_FRIENDLY },
			-- Environmental
			[3] = { n = "_VSENVIRONMENTALDAMAGE_FALLING_OTHER", sourceRelation=DamageMeters_Relation_FRIENDLY }, -- ok
			[4] = { n = "_VSENVIRONMENTALDAMAGE_LAVA_OTHER", sourceRelation=DamageMeters_Relation_FRIENDLY },
		},
		CHAT_MSG_COMBAT_PET_HITS = {
			[1] = { n = "_COMBATHITOTHEROTHER", sourceRelation=DamageMeters_Relation_PET }, -- ok
			[2] = { n = "_COMBATHITCRITOTHEROTHER", sourceRelation=DamageMeters_Relation_PET }, --ok
			[3] = { n = "_VSENVIRONMENTALDAMAGE_FALLING_OTHER", destRelation=DamageMeters_Relation_PET, msgType=DM_MSGTYPE_DAMAGERECEIVED }, -- ok
			[4] = { n = "_VSENVIRONMENTALDAMAGE_LAVA_OTHER", destRelation=DamageMeters_Relation_PET, msgType=DM_MSGTYPE_DAMAGERECEIVED }, -- ok
		},

		CHAT_MSG_SPELL_PARTY_DAMAGE = {
			[1] = { n = "_SPELLLOGCRITSCHOOLOTHEROTHER", sourceRelation=DamageMeters_Relation_PARTY }, -- ok
			[2] = { n = "_SPELLLOGSCHOOLOTHEROTHER", sourceRelation=DamageMeters_Relation_PARTY }, -- ok
			[3] = { n = "_SPELLLOGCRITOTHEROTHER", sourceRelation=DamageMeters_Relation_PARTY }, -- ok
			[4] = { n = "_SPELLLOGOTHEROTHER", sourceRelation=DamageMeters_Relation_PARTY }, -- ok
			[5] = { n = "_SPELLSPLITDAMAGEOTHEROTHER", sourceRelation=DamageMeters_Relation_PARTY },
		},
		CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE = {
			[1] = { n = "_SPELLLOGCRITSCHOOLOTHEROTHER" }, -- ok
			[2] = { n = "_SPELLLOGSCHOOLOTHEROTHER" }, -- ok
			[3] = { n = "_SPELLLOGCRITOTHEROTHER" }, -- ok
			[4] = { n = "_SPELLLOGOTHEROTHER" }, -- ok 
			[5] = { n = "_SPELLSPLITDAMAGEOTHEROTHER" },
		},
		CHAT_MSG_SPELL_PET_DAMAGE = {
			[1] = { n = "_SPELLLOGOTHEROTHER", sourceRelation=DamageMeters_Relation_PET }, -- ok
			[2] = { n = "_SPELLLOGCRITOTHEROTHER", sourceRelation=DamageMeters_Relation_PET }, -- ok
			-- Totems do school damage.
			[3] = { n = "_SPELLLOGCRITSCHOOLOTHEROTHER", sourceRelation=DamageMeters_Relation_PET },
			[4] = { n = "_SPELLLOGSCHOOLOTHEROTHER", sourceRelation=DamageMeters_Relation_PET }, -- ok
			[5] = { n = "_SPELLSPLITDAMAGEOTHEROTHER", sourceRelation=DamageMeters_Relation_PET },
		},

		CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF = {
			[1] = { n = "_DAMAGESHIELDSELFOTHER" }, -- ok
		},
		CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS = {
			[1] = { n = "_DAMAGESHIELDOTHEROTHER" }, -- ok
			[2] = { n = "_SPELLSPLITDAMAGESELFOTHER" },
		},
	},

	[DM_MSGTYPE_DAMAGERECEIVED] = {
		CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS = {
			[1] = { n = "_COMBATHITCRITOTHERSELF" }, -- ok
			[2] = { n = "_COMBATHITOTHERSELF" }, -- ok
			[3] = { n = "_COMBATHITCRITSCHOOLOTHERSELF" }, -- ok
			[4] = { n = "_COMBATHITSCHOOLOTHERSELF" }, -- ok

			[5] = { n = "_COMBATHITOTHEROTHER", destRelation=DamageMeters_Relation_PET }, -- ok
			[6] = { n = "_COMBATHITCRITOTHEROTHER", destRelation=DamageMeters_Relation_PET },
			[7] = { n = "_COMBATHITCRITSCHOOLOTHEROTHER", destRelation=DamageMeters_Relation_PET }, -- ok
			[8] = { n = "_COMBATHITSCHOOLOTHEROTHER", destRelation=DamageMeters_Relation_PET }, -- ok
		},
		CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS = {
			[1] = { n = "_COMBATHITCRITOTHEROTHER", destRelation=DamageMeters_Relation_PARTY }, 
			[2] = { n = "_COMBATHITOTHEROTHER", destRelation=DamageMeters_Relation_PARTY }, -- ok
			[3] = { n = "_COMBATHITCRITSCHOOLOTHEROTHER", destRelation=DamageMeters_Relation_PARTY }, 
			[4] = { n = "_COMBATHITSCHOOLOTHEROTHER", destRelation=DamageMeters_Relation_PARTY }, -- ok
		},
		CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS = {
			[1] = { n = "_COMBATHITCRITOTHEROTHER" }, -- ok
			[2] = { n = "_COMBATHITOTHEROTHER" }, -- ok
			[3] = { n = "_COMBATHITCRITSCHOOLOTHEROTHER" }, 
			[4] = { n = "_COMBATHITSCHOOLOTHEROTHER" },
		},

		-- absorb messages.
		--CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES = {},
		--CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES = {},
		--CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_MISSES = {},

		CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE = {
			[1] = { n = "_SPELLLOGCRITSCHOOLOTHERSELF" }, --! test
			[2] = { n = "_SPELLLOGSCHOOLOTHERSELF" }, -- ok
			[3] = { n = "_SPELLLOGCRITOTHERSELF" }, -- ok
			[4] = { n = "_SPELLLOGOTHERSELF" }, -- ok
			[5] = { n = "_SPELLRESISTOTHERSELF" }, -- ok

			[6] = { n = "_SPELLLOGCRITSCHOOLOTHEROTHER", destRelation=DamageMeters_Relation_PET },
			[7] = { n = "_SPELLLOGSCHOOLOTHEROTHER", destRelation=DamageMeters_Relation_PET }, -- ok
			[8] = { n = "_SPELLLOGCRITOTHEROTHER", destRelation=DamageMeters_Relation_PET },
			[9] = { n = "_SPELLLOGOTHEROTHER", destRelation=DamageMeters_Relation_PET },
			[10] = { n = "_SPELLRESISTOTHEROTHER", destRelation=DamageMeters_Relation_PET }, -- ok
		},
		CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE = {
			[1] = { n = "_SPELLLOGCRITSCHOOLOTHEROTHER", destRelation=DamageMeters_Relation_PARTY }, -- ok
			[2] = { n = "_SPELLLOGSCHOOLOTHEROTHER", destRelation=DamageMeters_Relation_PARTY }, -- ok
			[3] = { n = "_SPELLLOGCRITOTHEROTHER", destRelation=DamageMeters_Relation_PARTY }, --! hmm
			[4] = { n = "_SPELLLOGOTHEROTHER", destRelation=DamageMeters_Relation_PARTY }, -- ok
			[5] = { n = "_SPELLRESISTOTHEROTHER", destRelation=DamageMeters_Relation_PARTY }, -- ok
		},
		CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE = {
			[1] = { n = "_SPELLLOGCRITSCHOOLOTHEROTHER" }, -- ok
			[2] = { n = "_SPELLLOGSCHOOLOTHEROTHER" }, -- ok
			[3] = { n = "_SPELLLOGCRITOTHEROTHER" }, -- ok
			[4] = { n = "_SPELLLOGOTHEROTHER" }, -- ok
			[5] = { n = "_SPELLRESISTOTHEROTHER" }, -- ok
		},

		-- Unsure against what players this occurs for.  Happens vs. self and pets for sure.
		CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE = {
			[1] = { n = "_SPELLLOGCRITSCHOOLOTHERSELF" }, --ok
			[2] = { n = "_SPELLLOGSCHOOLOTHERSELF" }, -- ok
			[3] = { n = "_SPELLLOGCRITOTHERSELF" }, -- ok
			[4] = { n = "_SPELLLOGOTHERSELF" }, -- ok
			[5] = { n = "_SPELLRESISTOTHERSELF" }, -- ok

			[6] = { n = "_SPELLLOGCRITSCHOOLOTHEROTHER" }, -- ok
			[7] = { n = "_SPELLLOGSCHOOLOTHEROTHER" }, -- ok
			[8] = { n = "_SPELLLOGCRITOTHEROTHER" }, -- ok
			[9] = { n = "_SPELLLOGOTHEROTHER" }, -- ok
			[10] = { n = "_SPELLRESISTOTHEROTHER" }, -- ok
		},

		CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE = {
			[1] = { n = "_PERIODICAURADAMAGESELFSELF" }, --! hmm, would need to get a mob to reflect a dot onto me.
			[2] = { n = "_PERIODICAURADAMAGEOTHERSELF" }, -- ok
			[3] = { n = "_PERIODICAURADAMAGEOTHEROTHER", destRelation=DamageMeters_Relation_PET }, -- ok
		},

		CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE = {
			[1] = { n = "_PERIODICAURADAMAGEOTHEROTHER" }, -- ok
		},
		CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE = {
			[1] = { n = "_PERIODICAURADAMAGEOTHEROTHER" }, -- ok
		},

		CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS = {
			[1] = { n = "_COMBATHITOTHERSELF" }, -- ok
			[2] = { n = "_COMBATHITCRITOTHERSELF" }, -- ok
			[3] = { n = "_COMBATHITOTHEROTHER" }, -- ok (sometimes pets but we couldn't know)
			[4] = { n = "_COMBATHITCRITOTHEROTHER" }, -- ok
			[5] = { n = "_VSENVIRONMENTALDAMAGE_FALLING_OTHER" }, -- ok (this monitors the damage our enemys take in pvp.  we don't really care about this)
			[6] = { n = "_VSENVIRONMENTALDAMAGE_LAVA_OTHER" },
		},
	},

-- Healing : 
	[DM_MSGTYPE_HEALING] = {
		CHAT_MSG_SPELL_SELF_BUFF = {
			[1] = { n="_HEALEDCRITSELFSELF" }, -- ok
			[2] = { n="_HEALEDSELFSELF" },	-- ok
			[3] = { n="_HEALEDCRITSELFOTHER" }, --ok
			[4] = { n="_HEALEDSELFOTHER" }, -- ok

			--[5] = { n="_HEALEDOTHEROTHER" }, -- this might theoretically happen if there was a direct heal (non-hot) for a pet class, but i don't think there are any
			--[6] = { n="_HEALEDCRITOTHEROTHER" },
		},
		CHAT_MSG_SPELL_PARTY_BUFF = {
			[1] = { n="__NIGHTDRAGONSBREATHOTHERCRIT", sourceRelation=DamageMeters_Relation_PARTY, destRelation=DamageMeters_Relation_PARTY },
			[2] = { n="__NIGHTDRAGONSBREATHOTHER", sourceRelation=DamageMeters_Relation_PARTY, destRelation=DamageMeters_Relation_PARTY },
			[3] = { n="_HEALEDCRITOTHERSELF", sourceRelation=DamageMeters_Relation_PARTY, destRelation=DamageMeters_Relation_SELF }, --! test, and shouldn't there be relations?
			[4] = { n="_HEALEDOTHERSELF", sourceRelation=DamageMeters_Relation_PARTY, destRelation=DamageMeters_Relation_SELF }, --!
			[5] = { n="_HEALEDCRITOTHEROTHER", sourceRelation=DamageMeters_Relation_PARTY }, -- ok
			[6] = { n="_HEALEDOTHEROTHER", sourceRelation=DamageMeters_Relation_PARTY }, -- ok
		},
		CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF = {
			[1] = { n="__NIGHTDRAGONSBREATHOTHERCRIT" }, -- ok
			[2] = { n="__NIGHTDRAGONSBREATHOTHER" },
			[3] = { n="_HEALEDCRITOTHERSELF", destRelation=DamageMeters_Relation_SELF }, --! test, and shouldn't there be relations?
			[4] = { n="_HEALEDOTHERSELF", destRelation=DamageMeters_Relation_SELF }, --!
			[5] = { n="_HEALEDCRITOTHEROTHER" }, -- ok
			[6] = { n="_HEALEDOTHEROTHER" }, -- ok
		},
		CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF = {
			[1] = { n="__NIGHTDRAGONSBREATHOTHERCRIT" },
			[2] = { n="__NIGHTDRAGONSBREATHOTHER" },
			[3] = { n="_HEALEDCRITOTHERSELF", destRelation=DamageMeters_Relation_SELF }, --! test, and shouldn't there be relations?
			[4] = { n="_HEALEDOTHERSELF", destRelation=DamageMeters_Relation_SELF }, --!
			[5] = { n="_HEALEDCRITOTHEROTHER" }, -- ok
			[6] = { n="_HEALEDOTHEROTHER" }, -- ok
		},

		-- guessing
		CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS = {
			[1] = { n="_PERIODICAURAHEALOTHERSELF" }, -- ok
			[2] = { n="_PERIODICAURAHEALSELFSELF" }, -- ok
			[3] = { n="_PERIODICAURAHEALSELFOTHER" }, -- ok (ie. Mend Pet)
		},
		-- guessing
		CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS = {
			[1] = { n="__JULIESBLESSINGOTHER", sourceRelation=DamageMeters_Relation_PARTY },
			[2] = { n="_PERIODICAURAHEALSELFOTHER", sourceRelation=DamageMeters_Relation_PARTY, destRelation=DamageMeters_Relation_PARTY }, -- ok
			[3] = { n="_PERIODICAURAHEALOTHEROTHER", sourceRelation=DamageMeters_Relation_PARTY, destRelation=DamageMeters_Relation_PARTY }, -- ok
		};
		-- guessing
		CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS = {
			[1] = { n="__JULIESBLESSINGOTHER" },
			[2] = { n="_PERIODICAURAHEALSELFOTHER" }, -- ok
			[3] = { n="_PERIODICAURAHEALOTHEROTHER" }, -- ok
		};
		-- guessing
		CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS = {
			[1] = { n="_PERIODICAURAHEALOTHERSELF" }, --!
			[2] = { n="_PERIODICAURAHEALSELFSELF" }, --!
			[3] = { n="_PERIODICAURAHEALSELFOTHER" }, --!
			[4] = { n="_PERIODICAURAHEALOTHEROTHER" }, --! ok, but irrelevant, i think
		};
	},
};
