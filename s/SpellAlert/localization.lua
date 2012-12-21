-- English

SA_SPELLS_HEALS = 
{
	-- Priest
	["Flash Heal"] = 1,
	["Greater Heal"] = 1,
	["Heal"] = 1,
	["Prayer of Healing"] = 1,
	["Lesser Heal"] = 1,
	-- Druid
	["Healing Touch"] = 1,
	["Regrowth"] = 1,
	["Tranquility"] = 1,
	-- Shaman
	["Healing Wave"] = 1,
	["Lesser Healing Wave"] = 1,
};

SA_SPELLS_CC = 
{
	-- Priest
	["Mind Control"] = 1,
	-- Druid
	["Entangling Roots"] = 1,
	-- Mage
	["Polymorph"] = 1,
};

SA_SPELLS_DISPELABLE = 
{
	-- Priest
	["Power Word: Shield"] = 1,
	["Renew"] = 1,
	["Inner Fire"] = 1,
	["Power Word: Fortitude"] = 1,
	["Shadow Protection"] = 1,
	["Divine Spirit"] = 1,
	-- Druid
	["Rejuvenation"] = 1,
	["Thorn"] = 1,
	["Mark of the Wild"] = 1,
	["Regrowth"] = 1,
	["Innervate"] = 1,
	-- Mage
	["Arcane Intellect"] = 1,
	["Frost Armor"] = 1,
	["Fire Ward"] = 1,
	["Frost Ward"] = 1,
	["Ice Armor"] = 1,
	["Mage Armor"] = 1,
	["Arcane Power"] = 1,
	["Ice Barrier"] = 1,
	["Mana Shield"] = 1,
	-- Shaman
	["Lightning Shield"] = 1,
	["Windfury Weapon"] = 1,
	["Nature's Swiftness"] = 1,
	["Water Walking"] = 1,
	["Ghost Wolf"] = 1,
	-- Warlock
	["Demon Skin"] = 1,
	["Demon Armor"] = 1,
	["Shadow Ward"] = 1,
	-- Unknown
	["Ancestral Fortitude"] = 1,
	["Ephemeral Power"] = 1,
};

SA_SPELLS_DAMAGE = 
{
	-- Priest
	["Mind Blast"] = 1,
	["Mana Burn"] = 1,
	["Starshards"] = 1,
	["Smite"] = 1,
	["Mind Flay"] = 1,
	["Holy Fire"] = 1,
	-- Druid
	["Wrath"] = 1,
	["Starfire"] = 1,
	["Hurricane"] = 1,
	-- Hunter
	["Volley"] = 1,
	-- Mage
	["Frostbolt"] = 1,
	["Fireball"] = 1,
	["Arcane Missiles"] = 1,
	["Arcane Explosion"] = 1,
	["Blizzard"] = 1,
	["Pyroblast"] = 1,
	["Teleport: Ironforge"] = 1,
	["Teleport: Orgrimmar"] = 1,
	["Teleport: Stormwind"] = 1,
	["Teleport: Undercity"] = 1,
	["Scorch"] = 1,
	["Teleport: Darnassus"] = 1,
	["Teleport: Thunder Bluff"] = 1,
	["Pyroblast"] = 1,
	["Flamestrike"] = 1,
	-- Shaman
	["Lightning Bolt"] = 1,
	["Chain Lightning"] = 1,
	-- Warlock
	["Immolate"] = 1,
	["Corruption"] = 1,
	["Shadow Bolt"] = 1,
	["Fear"] = 1,
	["Drain Soul"] = 1,
	["Health Funnel"] = 1,
	["Drain Life"] = 1,
	["Searing Pain"] = 1,
	["Ritual of Summoning"] = 1,
	["Drain Mana"] = 1,
	["Hellfire"] = 1,
	["Conflagrate"] = 1,
	["Howl of Terror"] = 1,
	["Soul Fire"] = 1,
};

-- Spells/Emotes that will be ignored
SA_SPELLS_IGNORE = 
{
	["Abolish Poision"] = 1;
	["Aimed Shot"] = 1;
	["Arcane Intellect"] = 1;
	["Arcane Shot"] = 1;
	["Argent Dawn Commission"] = 1;
	["Aspect of the Cheetah"] = 1;
	["Aspect of the Hawk"] = 1;
	["Aspect of the Monkey"] = 1;
	["Attack"] = 1;
	["Battle Shout"] = 1;
	["Bloodrage"] = 1;
	["Blood Craze"] = 1;
	["Blood Pact"] = 1;
	["Battle Shout"] = 1;
	["Battle Stance"] = 1;
	["Berserker Stance"] = 1;
	["Blade Flurry"] = 1;
	["Blink"] = 1;
	["Clearcasting"] = 1;
	["Concussive Shot"] = 1;
	["Dash"] = 1;
	["Defensive Stance"] = 1;
	["Detect Traps"] = 1;
	["Devotion Aura"] = 1;
	["Enrage"] = 1;
	["Evasion"] = 1;
	["Explosive Shot"] = 1;
	["Fade"] = 1;
	["Fire Resistance Aura"] = 1;
	["Flurry"] = 1;
	["Focused Casting"] = 1;
	["Haste"] = 1;
	["Holy Strength"] = 1;
	["Inspiration"] = 1;
	["Julie's Blessing"] = 1;
	["Remorseless"] = 1;
	["Serpent Sting"] = 1;
	["Scatter Shot"] = 1;
	["Shield Block"] = 1;
	["Spirit of Redemption"] = 1;
	["Spirit Tap"] = 1;
	["Sprint"] = 1;
	["Stealth"] = 1;
	["Swiftshifting"] = 1;
	["Travel Form"] = 1;
	["Trueshot Aura"] = 1;
	["Viper Sting"] = 1;
};

SA_MOBS_ACCEPT = 
{
};

SA_PTN_SPELL_BEGIN_CAST = "(.+) begins to cast (.+).";
SA_PTN_SPELL_GAINS_X = "(.+) gains (%d+) (.+).";
SA_PTN_SPELL_GAINS = "(.+) gains (.+).";
SA_PTN_SPELL_TOTEM = "(.+) casts (.+) Totem.";
SA_PTN_SPELL_FADE = "(.+) fades from (.+).";

SA_WOTF = "Will of the Forsaken";
SA_BERSERKER_RAGE = "Berserker Rage";
SA_AFFLICT_LIVINGBOMB = "You are afflicted by Living Bomb.";
SA_AFFLICT_SCATTERSHOT = "You are afflicted by Scatter Shot."
SA_AFFLICT_FEAR = "You are afflicted by Fear.";
SA_AFFLICT_INTIMIDATING_SHOUT = "You are afflicted by Intimidating Shout.";
SA_AFFLICT_PSYCHIC_SCREAM = "You are afflicted by Psychic Scream.";
SA_AFFLICT_PANIC = "You are afflicted by Panic.";
SA_AFFLICT_BELLOWING_ROAR = "You are afflicted by Bellowing Roar.";
SA_AFFLICT_ANCIENT_DESPAIR = "You are afflicted by Ancient Despair.";
SA_AFFLICT_ANCIENT_SCREECH = "You are afflicted by Terrifying Screech.";
SA_AFFLICT_POLYMORPH = "You are afflicted by Polymorph.";
SA_AFFLICT_DEATHCOIL = "You are afflicted by Death Coil.";
SA_SCATTERSHOT = "Scatter Shot";
SA_FEAR = "Fear";
SA_INTIMIDATING_SHOUT = "Intimidating Shout";
SA_PSYCHIC_SCREAM = "Psychic Scream";
SA_PANIC = "Panic";
SA_BELLOWING_ROAR = "Bellowing Roar";
SA_ANCIENT_DESPAIR = "Ancient Despair.";
SA_SCREECH = "Terrifying Screech.";
SA_POLYMORPH = "Polymorph.";
SA_DEATHCOIL = "Death Coil";

if (GetLocale()=="deDE") then
-- German


SA_PTN_SPELL_BEGIN_CAST = "(.+) beginnt (.+) zu wirken.";
SA_PTN_SPELL_GAINS_X = "(.+) bekommt (%d+) (.+).";
SA_PTN_SPELL_GAINS = "(.+) bekommt (.+).";
SA_PTN_SPELL_TOTEM = "(.+) wirkt (.+).";
SA_PTN_SPELL_FADE = "(.+) schwindet von (.+).";

SA_WOTF = "Wille der Verlassenen";
SA_BERSERKER_RAGE = "Berserker-Wut";
SA_AFFLICT_LIVINGBOMB = "Ihr seid von Lebende Bombe betroffen.";
SA_AFFLICT_SCATTERSHOT = "Ihr seid von Streuschuss betroffen."
SA_AFFLICT_FEAR = "Ihr seid von Furcht betroffen.";
SA_AFFLICT_INTIMIDATING_SHOUT = "Ihr seid von Demoralisierungsruf betroffen.";
SA_AFFLICT_PSYCHIC_SCREAM = "Ihr seid von Psychischer Schrei betroffen.";
SA_AFFLICT_PANIC = "Ihr seid von Panik betroffen.";
SA_AFFLICT_BELLOWING_ROAR = "You are afflicted by Bellowing Roar.";
SA_AFFLICT_ANCIENT_DESPAIR = "You are afflicted by Ancient Despair.";
SA_AFFLICT_ANCIENT_SCREECH = "You are afflicted by Terrifying Screech.";
SA_AFFLICT_POLYMORPH = "You are afflicted by Polymorph."
SA_SCATTERSHOT = "Streuschuss";
SA_FEAR = "Furcht";
SA_INTIMIDATING_SHOUT = "Demoralisierungsruf";
SA_PSYCHIC_SCREAM = "Psychischer Schrei";
SA_PANIC = "Panik";
SA_BELLOWING_ROAR = "Bellowing Roar";
SA_ANCIENT_DESPAIR = "Ancient Despair.";
SA_SCREECH = "Terrifying Screech.";
SA_POLYMORPH = "Polymorph."

elseif (GetLocale()=="frFR") then
-- French


end