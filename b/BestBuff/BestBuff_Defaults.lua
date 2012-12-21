--[[ BestBuff_Defaults.lua

     This is used by BestBuff to load default buffs, in the event
     that it finds no settings in SavedVariables.lua.

     If you tend to delete that file a lot (like I do), then you
     may want to add new default buffs here.  To add them, add a
     line below in this format:

     BBDefaultBuffs["Buff Name"] = { levels };

     levels are the levels the buff is learned, separated by commas.
]]


BBDefaultBuffs = {};
BBDefaultBuffs["Power Word: Fortitude"] = { 1,12,24,36,48,60 };
BBDefaultBuffs["Renew"] = { 8,14,20,26,32,38,44,50,56 };
BBDefaultBuffs["Power Word: Shield"] = { 6,12,18,24,30,36,42,48,54,60 };
BBDefaultBuffs["Arcane Intellect"] = { 1,14,28,42,56 };
BBDefaultBuffs["Mark of the Wild"] = { 1,10,20,30,40,50,60 };
BBDefaultBuffs["Regrowth"] = { 12,18,24,30,36,42,48,54,60 };
BBDefaultBuffs["Rejuvenation"] = { 4,10,16,22,28,34,40,46,52,58 };
BBDefaultBuffs["Thorns"] = { 6,14,24,34,44,54 };
BBDefaultBuffs["Divine Spirit"] = { 40,42,54 };
BBDefaultBuffs["Shadow Protection"] = { 30,42,56 };
BBDefaultBuffs["Blessing of Might"] = { 4,12,22,32,42,52 };
BBDefaultBuffs["Blessing of Light"] = { 40,50,60 };
BBDefaultBuffs["Blessing of Protection"] = { 10,24,38 };
BBDefaultBuffs["Blessing of Sacrifice"] = { 46,54 };
BBDefaultBuffs["Blessing of Sanctuary"] = { 30,40,50,60 };
BBDefaultBuffs["Blessing of Wisdom"] = { 14,24,34,44,54,60 };
BBDefaultBuffs["Amplify Magic"] = { 18,30,42,54 };
BBDefaultBuffs["Dampen Magic"] = { 12,24,36,48,60 };

BBDefault_SelfCast = 0;  -- <- change to 1 to make self cast default
BBDefault_Notify = 0;    -- <- change to 1 to make notify (spam) default

