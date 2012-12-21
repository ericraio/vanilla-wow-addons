CountDoomSpellMapping = {};


CountDoomSpell = {};
--[[
spell = "amplify";
CountDoomSpell[ spell ] = {};
CountDoomSpell[ spell ].text = COUNTDOOMSPELL_AMPLIFY_CURSE;
CountDoomSpell[ spell ].type = COUNTDOOMSPELL_AMPLIFY_CURSE;
CountDoomSpell[ spell ].replacesSameType = true;
CountDoomSpell[ spell ].duration = 30;
CountDoomSpell[ spell ].rankDuration = {};
CountDoomSpell[ spell ].rankDuration[1] = 30;
CountDoomSpell[ spell ].countDown = false;
CountDoomSpell[ spell ].warningTime = 5;
CountDoomSpell[ spell ].combatOnly = true;
CountDoomSpell[ spell ].icon = "Interface\\Icons\\Spell_Shadow_Contagion";
CountDoomSpell[ spell ].soundStart = false;
CountDoomSpell[ spell ].soundWarning = false;
CountDoomSpell[ spell ].soundEnd = false;
CountDoomSpell[ spell ].announceStart = false;
CountDoomSpell[ spell ].announceWarning = false;
CountDoomSpell[ spell ].announceEnd = false;
CountDoomSpellMapping[ CountDoomSpell[ spell ].text ] = spell;
--]]

spell = "banish";
CountDoomSpell[ spell ] = {};
CountDoomSpell[ spell ].text = COUNTDOOMSPELL_BANISH;
CountDoomSpell[ spell ].type = COUNTDOOMSPELL_BANISH;
CountDoomSpell[ spell ].replacesSameType = false;
CountDoomSpell[ spell ].duration = 30;
CountDoomSpell[ spell ].rankDuration = {};
CountDoomSpell[ spell ].rankDuration[1] = 20;
CountDoomSpell[ spell ].rankDuration[2] = 30;
CountDoomSpell[ spell ].countDown = true;
CountDoomSpell[ spell ].warningTime = 5;
CountDoomSpell[ spell ].combatOnly = true;
CountDoomSpell[ spell ].icon = "Interface\\Icons\\Spell_Shadow_Cripple";
CountDoomSpell[ spell ].soundStart = false;
CountDoomSpell[ spell ].soundWarning = false;
CountDoomSpell[ spell ].soundEnd = false;
CountDoomSpell[ spell ].announceStart = true;
CountDoomSpell[ spell ].announceWarning = true;
CountDoomSpell[ spell ].announceEnd = false;
CountDoomSpellMapping[ CountDoomSpell[ spell ].text ] = spell;

spell = "coa";
CountDoomSpell[ spell ] = {};
CountDoomSpell[ spell ].text = COUNTDOOMSPELL_CURSEOFAGONY;
CountDoomSpell[ spell ].type = "curse";
CountDoomSpell[ spell ].replacesSameType = true;
CountDoomSpell[ spell ].duration = 24;
CountDoomSpell[ spell ].rankDuration = {};
CountDoomSpell[ spell ].rankDuration[1] = 24;
CountDoomSpell[ spell ].rankDuration[2] = 24;
CountDoomSpell[ spell ].rankDuration[3] = 24;
CountDoomSpell[ spell ].rankDuration[4] = 24;
CountDoomSpell[ spell ].rankDuration[5] = 24;
CountDoomSpell[ spell ].rankDuration[6] = 24;
CountDoomSpell[ spell ].countDown = true;
CountDoomSpell[ spell ].warningTime = 5;
CountDoomSpell[ spell ].combatOnly = true;
CountDoomSpell[ spell ].icon = "Interface\\Icons\\Spell_Shadow_CurseOfSargeras";
CountDoomSpell[ spell ].soundStart = false;
CountDoomSpell[ spell ].soundWarning = false;
CountDoomSpell[ spell ].soundEnd = false;
CountDoomSpell[ spell ].announceStart = false;
CountDoomSpell[ spell ].announceWarning = false;
CountDoomSpell[ spell ].announceEnd = false;
CountDoomSpellMapping[ CountDoomSpell[ spell ].text ] = spell;

spell = "cod";
CountDoomSpell[ spell ] = {};
CountDoomSpell[ spell ].text = COUNTDOOMSPELL_CURSEOFDOOM;
CountDoomSpell[ spell ].type = "curse";
CountDoomSpell[ spell ].replacesSameType = true;
CountDoomSpell[ spell ].duration = 60;
CountDoomSpell[ spell ].rankDuration = {};
CountDoomSpell[ spell ].rankDuration[1] = 60;
CountDoomSpell[ spell ].countDown = true;
CountDoomSpell[ spell ].warningTime = 5;
CountDoomSpell[ spell ].combatOnly = true;
CountDoomSpell[ spell ].icon = "Interface\\Icons\\Spell_Shadow_AuraOfDarkness";
CountDoomSpell[ spell ].soundStart = false;
CountDoomSpell[ spell ].soundWarning = false;
CountDoomSpell[ spell ].soundEnd = false;
CountDoomSpell[ spell ].announceStart = false;
CountDoomSpell[ spell ].announceWarning = true;
CountDoomSpell[ spell ].announceEnd = false;
CountDoomSpellMapping[ CountDoomSpell[ spell ].text ] = spell;

spell = "coe";
CountDoomSpell[ spell ] = {};
CountDoomSpell[ spell ].text = COUNTDOOMSPELL_CURSEOFTHEELEMENTS;
CountDoomSpell[ spell ].type = "curse";
CountDoomSpell[ spell ].replacesSameType = true;
CountDoomSpell[ spell ].duration = 300;
CountDoomSpell[ spell ].rankDuration = {};
CountDoomSpell[ spell ].rankDuration[1] = 300;
CountDoomSpell[ spell ].rankDuration[2] = 300;
CountDoomSpell[ spell ].rankDuration[3] = 300;
CountDoomSpell[ spell ].countDown = true;
CountDoomSpell[ spell ].warningTime = 30;
CountDoomSpell[ spell ].combatOnly = true;
CountDoomSpell[ spell ].icon = "Interface\\Icons\\Spell_Shadow_ChillTouch";
CountDoomSpell[ spell ].soundStart = false;
CountDoomSpell[ spell ].soundWarning = false;
CountDoomSpell[ spell ].soundEnd = false;
CountDoomSpell[ spell ].announceStart = false;
CountDoomSpell[ spell ].announceWarning = false;
CountDoomSpell[ spell ].announceEnd = false;
CountDoomSpellMapping[ CountDoomSpell[ spell ].text ] = spell;

spell = "coex";
CountDoomSpell[ spell ] = {};
CountDoomSpell[ spell ].text = COUNTDOOMSPELL_CURSEOFEXHAUSTION;
CountDoomSpell[ spell ].type = "curse";
CountDoomSpell[ spell ].replacesSameType = true;
CountDoomSpell[ spell ].duration = 12;
CountDoomSpell[ spell ].rankDuration = {};
CountDoomSpell[ spell ].rankDuration[1] = 12;
CountDoomSpell[ spell ].countDown = true;
CountDoomSpell[ spell ].warningTime = 2;
CountDoomSpell[ spell ].combatOnly = true;
CountDoomSpell[ spell ].icon = "Interface\\Icons\\Spell_Shadow_GrimWard";
CountDoomSpell[ spell ].soundStart = false;
CountDoomSpell[ spell ].soundWarning = false;
CountDoomSpell[ spell ].soundEnd = false;
CountDoomSpell[ spell ].announceStart = false;
CountDoomSpell[ spell ].announceWarning = false;
CountDoomSpell[ spell ].announceEnd = false;
CountDoomSpellMapping[ CountDoomSpell[ spell ].text ] = spell;

spell = "cor";
CountDoomSpell[ spell ] = {};
CountDoomSpell[ spell ].text = COUNTDOOMSPELL_CURSEOFRECKLESSNESS;
CountDoomSpell[ spell ].type = "curse";
CountDoomSpell[ spell ].replacesSameType = true;
CountDoomSpell[ spell ].duration = 120;
CountDoomSpell[ spell ].rankDuration = {};
CountDoomSpell[ spell ].rankDuration[1] = 120;
CountDoomSpell[ spell ].rankDuration[2] = 120;
CountDoomSpell[ spell ].rankDuration[3] = 120;
CountDoomSpell[ spell ].rankDuration[4] = 120;
CountDoomSpell[ spell ].countDown = true;
CountDoomSpell[ spell ].warningTime = 15;
CountDoomSpell[ spell ].combatOnly = true;
CountDoomSpell[ spell ].icon = "Interface\\Icons\\Spell_Shadow_UnholyStrength";
CountDoomSpell[ spell ].soundStart = false;
CountDoomSpell[ spell ].soundWarning = false;
CountDoomSpell[ spell ].soundEnd = false;
CountDoomSpell[ spell ].announceStart = false;
CountDoomSpell[ spell ].announceWarning = false;
CountDoomSpell[ spell ].announceEnd = false;
CountDoomSpellMapping[ CountDoomSpell[ spell ].text ] = spell;

spell = "corruption";
CountDoomSpell[ spell ] = {};
CountDoomSpell[ spell ].text = COUNTDOOMSPELL_CORRUPTION;
CountDoomSpell[ spell ].type = COUNTDOOMSPELL_CORRUPTION;
CountDoomSpell[ spell ].replacesSameType = true;
CountDoomSpell[ spell ].duration = 18;
CountDoomSpell[ spell ].rankDuration = {};
CountDoomSpell[ spell ].rankDuration[1] = 12;
CountDoomSpell[ spell ].rankDuration[2] = 15;
CountDoomSpell[ spell ].rankDuration[3] = 18;
CountDoomSpell[ spell ].rankDuration[4] = 18;
CountDoomSpell[ spell ].rankDuration[5] = 18;
CountDoomSpell[ spell ].rankDuration[6] = 18;
CountDoomSpell[ spell ].countDown = true;
CountDoomSpell[ spell ].warningTime = 5;
CountDoomSpell[ spell ].combatOnly = true;
CountDoomSpell[ spell ].icon = "Interface\\Icons\\Spell_Shadow_AbominationExplosion";
CountDoomSpell[ spell ].soundStart = false;
CountDoomSpell[ spell ].soundWarning = false;
CountDoomSpell[ spell ].soundEnd = false;
CountDoomSpell[ spell ].announceStart = false;
CountDoomSpell[ spell ].announceWarning = false;
CountDoomSpell[ spell ].announceEnd = false;
CountDoomSpellMapping[ CountDoomSpell[ spell ].text ] = spell;

spell = "cos";
CountDoomSpell[ spell ] = {};
CountDoomSpell[ spell ].text = COUNTDOOMSPELL_CURSEOFSHADOW;
CountDoomSpell[ spell ].type = "curse";
CountDoomSpell[ spell ].replacesSameType = true;
CountDoomSpell[ spell ].duration = 300;
CountDoomSpell[ spell ].rankDuration = {};
CountDoomSpell[ spell ].rankDuration[1] = 300;
CountDoomSpell[ spell ].rankDuration[2] = 300;
CountDoomSpell[ spell ].countDown = true;
CountDoomSpell[ spell ].warningTime = 30;
CountDoomSpell[ spell ].combatOnly = true;
CountDoomSpell[ spell ].icon = "Interface\\Icons\\Spell_Shadow_CurseOfAchimonde";
CountDoomSpell[ spell ].soundStart = false;
CountDoomSpell[ spell ].soundWarning = false;
CountDoomSpell[ spell ].soundEnd = false;
CountDoomSpell[ spell ].announceStart = false;
CountDoomSpell[ spell ].announceWarning = false;
CountDoomSpell[ spell ].announceEnd = false;
CountDoomSpellMapping[ CountDoomSpell[ spell ].text ] = spell;

spell = "cot";
CountDoomSpell[ spell ] = {};
CountDoomSpell[ spell ].text = COUNTDOOMSPELL_CURSEOFTONGUES;
CountDoomSpell[ spell ].type = "curse";
CountDoomSpell[ spell ].replacesSameType = true;
CountDoomSpell[ spell ].duration = 30;
CountDoomSpell[ spell ].rankDuration = {};
CountDoomSpell[ spell ].rankDuration[1] = 30;
CountDoomSpell[ spell ].rankDuration[2] = 30;
CountDoomSpell[ spell ].countDown = true;
CountDoomSpell[ spell ].warningTime = 5;
CountDoomSpell[ spell ].combatOnly = true;
CountDoomSpell[ spell ].icon = "Interface\\Icons\\Spell_Shadow_CurseOfTounges";
CountDoomSpell[ spell ].soundStart = false;
CountDoomSpell[ spell ].soundWarning = false;
CountDoomSpell[ spell ].soundEnd = false;
CountDoomSpell[ spell ].announceStart = false;
CountDoomSpell[ spell ].announceWarning = false;
CountDoomSpell[ spell ].announceEnd = false;
CountDoomSpellMapping[ CountDoomSpell[ spell ].text ] = spell;


spell = "cow";
CountDoomSpell[ spell ] = {};
CountDoomSpell[ spell ].text = COUNTDOOMSPELL_CURSEOFWEAKNESS;
CountDoomSpell[ spell ].type = "curse";
CountDoomSpell[ spell ].replacesSameType = true;
CountDoomSpell[ spell ].duration = 120;
CountDoomSpell[ spell ].rankDuration = {};
CountDoomSpell[ spell ].rankDuration[1] = 120;
CountDoomSpell[ spell ].rankDuration[2] = 120;
CountDoomSpell[ spell ].rankDuration[3] = 120;
CountDoomSpell[ spell ].rankDuration[4] = 120;
CountDoomSpell[ spell ].rankDuration[5] = 120;
CountDoomSpell[ spell ].rankDuration[6] = 120;
CountDoomSpell[ spell ].countDown = true;
CountDoomSpell[ spell ].warningTime = 15;
CountDoomSpell[ spell ].combatOnly = true;
CountDoomSpell[ spell ].icon = "Interface\\Icons\\Spell_Shadow_CurseOfMannoroth";
CountDoomSpell[ spell ].soundStart = false;
CountDoomSpell[ spell ].soundWarning = false;
CountDoomSpell[ spell ].soundEnd = false;
CountDoomSpell[ spell ].announceStart = false;
CountDoomSpell[ spell ].announceWarning = false;
CountDoomSpell[ spell ].announceEnd = false;
CountDoomSpellMapping[ CountDoomSpell[ spell ].text ] = spell;

spell = "enslave";
CountDoomSpell[ spell ] = {};
CountDoomSpell[ spell ].text = COUNTDOOMSPELL_ENSLAVEDEMON;
CountDoomSpell[ spell ].type = COUNTDOOMSPELL_ENSLAVEDEMON;
CountDoomSpell[ spell ].replacesSameType = true;
CountDoomSpell[ spell ].duration = 300;
CountDoomSpell[ spell ].rankDuration = {};
CountDoomSpell[ spell ].rankDuration[1] = 300;
CountDoomSpell[ spell ].rankDuration[2] = 300;
CountDoomSpell[ spell ].rankDuration[3] = 300;
CountDoomSpell[ spell ].countDown = false;
CountDoomSpell[ spell ].warningTime = 60;
CountDoomSpell[ spell ].combatOnly = false;
CountDoomSpell[ spell ].icon = "Interface\\Icons\\Spell_Shadow_EnslaveDemon";
CountDoomSpell[ spell ].soundStart = false;
CountDoomSpell[ spell ].soundWarning = true;
CountDoomSpell[ spell ].soundEnd = true;
CountDoomSpell[ spell ].announceStart = true;
CountDoomSpell[ spell ].announceWarning = true;
CountDoomSpell[ spell ].announceEnd = false;
CountDoomSpellMapping[ CountDoomSpell[ spell ].text ] = spell;

spell = "fear";
CountDoomSpell[ spell ] = {};
CountDoomSpell[ spell ].text = COUNTDOOMSPELL_FEAR;
CountDoomSpell[ spell ].type = COUNTDOOMSPELL_FEAR;
CountDoomSpell[ spell ].replacesSameType = true;
CountDoomSpell[ spell ].duration = 20;
CountDoomSpell[ spell ].rankDuration = {};
CountDoomSpell[ spell ].rankDuration[1] = 10;
CountDoomSpell[ spell ].rankDuration[2] = 15;
CountDoomSpell[ spell ].rankDuration[3] = 20;
CountDoomSpell[ spell ].countDown = true;
CountDoomSpell[ spell ].warningTime = 5;
CountDoomSpell[ spell ].combatOnly = true;
CountDoomSpell[ spell ].icon = "Interface\\Icons\\Spell_Shadow_Possession";
CountDoomSpell[ spell ].soundStart = false;
CountDoomSpell[ spell ].soundWarning = false;
CountDoomSpell[ spell ].soundEnd = false;
CountDoomSpell[ spell ].announceStart = false;
CountDoomSpell[ spell ].announceWarning = false;
CountDoomSpell[ spell ].announceEnd = false;
CountDoomSpellMapping[ CountDoomSpell[ spell ].text ] = spell;

spell = "howl";
CountDoomSpell[ spell ] = {};
CountDoomSpell[ spell ].text = COUNTDOOMSPELL_HOWLOFTERROR;
CountDoomSpell[ spell ].type = COUNTDOOMSPELL_HOWLOFTERROR;
CountDoomSpell[ spell ].replacesSameType = true;
CountDoomSpell[ spell ].duration = 15;
CountDoomSpell[ spell ].rankDuration = {};
CountDoomSpell[ spell ].rankDuration[1] = 10;
CountDoomSpell[ spell ].rankDuration[2] = 15;
CountDoomSpell[ spell ].countDown = true;
CountDoomSpell[ spell ].warningTime = 5;
CountDoomSpell[ spell ].combatOnly = true;
CountDoomSpell[ spell ].icon = "Interface\\Icons\\Spell_Shadow_DeathScream";
CountDoomSpell[ spell ].soundStart = false;
CountDoomSpell[ spell ].soundWarning = false;
CountDoomSpell[ spell ].soundEnd = false;
CountDoomSpell[ spell ].announceStart = false;
CountDoomSpell[ spell ].announceWarning = false;
CountDoomSpell[ spell ].announceEnd = false;
CountDoomSpellMapping[ CountDoomSpell[ spell ].text ] = spell;

spell = "immolate";
CountDoomSpell[ spell ] = {};
CountDoomSpell[ spell ].text = COUNTDOOMSPELL_IMMOLATE;
CountDoomSpell[ spell ].type = COUNTDOOMSPELL_IMMOLATE;
CountDoomSpell[ spell ].replacesSameType = true;
CountDoomSpell[ spell ].duration = 15;
CountDoomSpell[ spell ].rankDuration = {};
CountDoomSpell[ spell ].rankDuration[1] = 15;
CountDoomSpell[ spell ].rankDuration[2] = 15;
CountDoomSpell[ spell ].rankDuration[3] = 15;
CountDoomSpell[ spell ].rankDuration[4] = 15;
CountDoomSpell[ spell ].rankDuration[5] = 15;
CountDoomSpell[ spell ].rankDuration[6] = 15;
CountDoomSpell[ spell ].rankDuration[7] = 15;
CountDoomSpell[ spell ].countDown = true;
CountDoomSpell[ spell ].warningTime = 5;
CountDoomSpell[ spell ].combatOnly = true;
CountDoomSpell[ spell ].icon = "Interface\\Icons\\Spell_Fire_Immolation";
CountDoomSpell[ spell ].soundStart = false;
CountDoomSpell[ spell ].soundWarning = false;
CountDoomSpell[ spell ].soundEnd = false;
CountDoomSpell[ spell ].announceStart = false;
CountDoomSpell[ spell ].announceWarning = false;
CountDoomSpell[ spell ].announceEnd = false;
CountDoomSpellMapping[ CountDoomSpell[ spell ].text ] = spell;


spell = "conflagrate";
CountDoomSpell[ spell ] = {};
CountDoomSpell[ spell ].text = COUNTDOOMSPELL_CONFLAGRATE;
CountDoomSpell[ spell ].type = COUNTDOOMSPELL_IMMOLATE;
CountDoomSpell[ spell ].replacesSameType = true;
CountDoomSpell[ spell ].duration = 1;
CountDoomSpell[ spell ].rankDuration = {};
CountDoomSpell[ spell ].rankDuration[1] = 1;
CountDoomSpell[ spell ].countDown = true;
CountDoomSpell[ spell ].warningTime = 0;
CountDoomSpell[ spell ].combatOnly = true;
CountDoomSpell[ spell ].icon = "Interface\\Icons\\Spell_Fire_Fireball";
CountDoomSpell[ spell ].soundStart = false;
CountDoomSpell[ spell ].soundWarning = false;
CountDoomSpell[ spell ].soundEnd = false;
CountDoomSpell[ spell ].announceStart = false;
CountDoomSpell[ spell ].announceWarning = false;
CountDoomSpell[ spell ].announceEnd = false;
CountDoomSpellMapping[ CountDoomSpell[ spell ].text ] = spell;


spell = "siphon";
CountDoomSpell[ spell ] = {};
CountDoomSpell[ spell ].text = COUNTDOOMSPELL_SIPHONLIFE;
CountDoomSpell[ spell ].type = COUNTDOOMSPELL_SIPHONLIFE;
CountDoomSpell[ spell ].replacesSameType = true;
CountDoomSpell[ spell ].duration = 30;
CountDoomSpell[ spell ].rankDuration = {};
CountDoomSpell[ spell ].rankDuration[1] = 30;
CountDoomSpell[ spell ].rankDuration[2] = 30;
CountDoomSpell[ spell ].rankDuration[3] = 30;
CountDoomSpell[ spell ].rankDuration[4] = 30;
CountDoomSpell[ spell ].countDown = true;
CountDoomSpell[ spell ].warningTime = 5;
CountDoomSpell[ spell ].combatOnly = true;
CountDoomSpell[ spell ].icon = "Interface\\Icons\\Spell_Shadow_Requiem";
CountDoomSpell[ spell ].soundStart = false;
CountDoomSpell[ spell ].soundWarning = false;
CountDoomSpell[ spell ].soundEnd = false;
CountDoomSpell[ spell ].announceStart = false;
CountDoomSpell[ spell ].announceWarning = false;
CountDoomSpell[ spell ].announceEnd = false;
CountDoomSpellMapping[ CountDoomSpell[ spell ].text ] = spell;

spell = "seduce";
CountDoomSpell[ spell ] = {};
CountDoomSpell[ spell ].text = COUNTDOOMSPELL_SEDUCE;
CountDoomSpell[ spell ].type = COUNTDOOMSPELL_SEDUCE;
CountDoomSpell[ spell ].replacesSameType = true;
CountDoomSpell[ spell ].duration = 15;
CountDoomSpell[ spell ].rankDuration = {};
CountDoomSpell[ spell ].rankDuration[1] = 15;
CountDoomSpell[ spell ].countDown = true;
CountDoomSpell[ spell ].warningTime = 5;
CountDoomSpell[ spell ].combatOnly = true;
CountDoomSpell[ spell ].icon = "Interface\\Icons\\Spell_Shadow_MindSteal";
CountDoomSpell[ spell ].soundStart = false;
CountDoomSpell[ spell ].soundWarning = false;
CountDoomSpell[ spell ].soundEnd = false;
CountDoomSpell[ spell ].announceStart = false;
CountDoomSpell[ spell ].announceWarning = false;
CountDoomSpell[ spell ].announceEnd = false;
CountDoomSpellMapping[ CountDoomSpell[ spell ].text ] = spell;

spell = "spelllock";
CountDoomSpell[ spell ] = {};
CountDoomSpell[ spell ].text = COUNTDOOMSPELL_SPELL_LOCK;
CountDoomSpell[ spell ].type = COUNTDOOMSPELL_SPELL_LOCK;
CountDoomSpell[ spell ].replacesSameType = true;
CountDoomSpell[ spell ].duration = 3;
CountDoomSpell[ spell ].rankDuration = {};
CountDoomSpell[ spell ].rankDuration[1] = 3;
CountDoomSpell[ spell ].countDown = true;
CountDoomSpell[ spell ].warningTime = 1;
CountDoomSpell[ spell ].combatOnly = true;
CountDoomSpell[ spell ].icon = "Interface\\Icons\\Spell_Shadow_MindRot";
CountDoomSpell[ spell ].soundStart = false;
CountDoomSpell[ spell ].soundWarning = false;
CountDoomSpell[ spell ].soundEnd = false;
CountDoomSpell[ spell ].announceStart = false;
CountDoomSpell[ spell ].announceWarning = false;
CountDoomSpell[ spell ].announceEnd = false;
CountDoomSpellMapping[ CountDoomSpell[ spell ].text ] = spell;


spell = "coil";
CountDoomSpell[ spell ] = {};
CountDoomSpell[ spell ].text = COUNTDOOMSPELL_DEATH_COIL;
CountDoomSpell[ spell ].type = COUNTDOOMSPELL_DEATH_COIL;
CountDoomSpell[ spell ].replacesSameType = true;
CountDoomSpell[ spell ].duration = 3;
CountDoomSpell[ spell ].rankDuration = {};
CountDoomSpell[ spell ].rankDuration[1] = 3;
CountDoomSpell[ spell ].rankDuration[2] = 3;
CountDoomSpell[ spell ].rankDuration[3] = 3;
CountDoomSpell[ spell ].countDown = true;
CountDoomSpell[ spell ].warningTime = 2;
CountDoomSpell[ spell ].combatOnly = true;
CountDoomSpell[ spell ].icon = "Interface\\Icons\\Spell_Shadow_DeathCoil";
CountDoomSpell[ spell ].soundStart = false;
CountDoomSpell[ spell ].soundWarning = false;
CountDoomSpell[ spell ].soundEnd = false;
CountDoomSpell[ spell ].announceStart = false;
CountDoomSpell[ spell ].announceWarning = false;
CountDoomSpell[ spell ].announceEnd = false;
CountDoomSpellMapping[ CountDoomSpell[ spell ].text ] = spell;


CountDoomSpell.Dump = function ( spell )
    if( spell == nil ) then
        return;
    end
    
    local enabled = CountDoom.config.enableSpell[ spell ];
    local config = CountDoomSpell[ spell ];
    
    CountDoom.prt( "Name: " .. config.text );
    CountDoom.prt( "Enabled: " .. CountDoom.ToStr( enabled ) );
    
    local rank = 1;
    while config.rankDuration[ rank ] ~= nil do
        CountDoom.prt( "Duration[" .. rank .. "]: " .. config.rankDuration[ rank ] );
        rank = rank + 1;
    end
    CountDoom.prt( "Countdown: " .. CountDoom.ToStr( config.countDown ) );
    CountDoom.prt( "Warning Time: " .. config.warningTime );
    CountDoom.prt( "Combat Only: " .. CountDoom.ToStr( config.combatOnly ) );
    CountDoom.prt( "Icon: " .. config.icon );

    --CountDoom.prt( "Play Spell Start: " .. CountDoom.ToStr( config.soundStart ) );
    CountDoom.prt( "Play Spell Warn: "  .. CountDoom.ToStr( CountDoom.config.warningSound[ spell ] ) );
    CountDoom.prt( "Play Spell End: "   .. CountDoom.ToStr( CountDoom.config.endSound[ spell ] ) );

    --CountDoom.prt( "Announce Spell Start: " .. CountDoom.ToStr( config.announceStart ) );
    CountDoom.prt( "Announce Spell Warn: "  .. CountDoom.ToStr( config.announceWarning ) );
    CountDoom.prt( "Announce Spell End: "   .. CountDoom.ToStr( config.announceEnd ) );
end;


CountDoomSpell.IsEnabled = function( spell )
    if CountDoomSpell[ spell ] == nil then
        return false;
    end
    
    if CountDoom.config.enableSpell == nil then
        return true;
    end
    
    if CountDoom.config.enableSpell[ spell ] == nil then
        return true;
    end
    
    return CountDoom.config.enableSpell[ spell ];
end;


CountDoomSpell.ToggleEnabled = function( spellAbbreviation )
    if CountDoomSpell[ spellAbbreviation ] == nil then
        return;
    end
    
    if CountDoom.config.enableSpell == nil then
        CountDoom.config.enableSpell = {};
    end
    
    if CountDoomSpell.IsEnabled( spellAbbreviation ) then
        CountDoom.config.enableSpell[ spellAbbreviation ] = false;
        CountDoom.prt( string.format( "Tracking of %s is disabled.", CountDoomSpell[ spellAbbreviation ].text ) );
    else
        CountDoom.config.enableSpell[ spellAbbreviation ] = true;
        CountDoom.prt( string.format( "Tracking of %s is enabled.", CountDoomSpell[ spellAbbreviation ].text ) );
    end
end;


CountDoomSpell.ToggleSound = function( spellAbbreviation )
    if CountDoomSpell[ spellAbbreviation ] == nil then
        return;
    end
    
    if CountDoom.config.enableSpell == nil then
        CountDoom.config.enableSpell = {};
    end
    
    if CountDoomSpell.IsEnabled( spellAbbreviation ) then
        CountDoom.config.enableSpell[ spellAbbreviation ] = false;
        CountDoom.prt( string.format( "Tracking of %s is disabled.", CountDoomSpell[ spellAbbreviation ].text ) );
    else
        CountDoom.config.enableSpell[ spellAbbreviation ] = true;
        CountDoom.prt( string.format( "Tracking of %s is enabled.", CountDoomSpell[ spellAbbreviation ].text ) );
    end
end;


-- Other spell icons
-- Shadow Ward - Spell_Shadow_AntiShadow
-- Shadow Bolt - Spell_Shadow_ShadowBolt
-- Shadow Pain - Spell_Shadow_ScourgeBuild
-- Death Coil - Spell_Shadow_DeathCoil
-- Searing Pain - Spell_Fire_SoulBurn
-- Soul Fire - Spell_Fire_Fireball02
-- Rain of Fire - Spell_Shadow_RainOfFire
-- Hellfire - Spell_Fire_Incinerate
-- Health Funnel - Spell_Shadow_LifeDrain
-- Life Tap - Spell_Shadow_BurningSpirit
-- Drain Soul - Spell_Shadow_Haunting
-- Drain Life - Spell_Shadow_LifeDrain02
-- Drain Mana - Spell_Shadow_SiphonMana
-- Will of the forsaken - Spell_Shadow_RaiseDead
-- Demon Armor - Spell_Shadow_RagingScream
-- Detect Invisibility - Spell_Shadow_DetectInvisibility
-- Ritual of Summoning - Spell_Shadow_Twilight
-- Spell_Shadow_SummonInfernal
-- Spell_Shadow_SummonImp
-- Spell_Shadow_SummonSuccubus
-- Spell_Shadow_SummonVoidWalker
-- Spell_Shadow_SummonFelHunter
-- Spell_Shadow_Metamorphosis
-- Disenchant - Spell_Holy_RemoveCurse
-- Eye of Kilrogg - Spell_Shadow_EvilEye
-- Summon Dreadsteed - Spell_Nature_Swiftness
-- Ritual of Doom - Spell_Shadow_AntiMagicShell
