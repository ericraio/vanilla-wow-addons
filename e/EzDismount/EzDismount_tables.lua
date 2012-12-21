--------------------
-- EzDismount Tables
--------------------

EzDSitErr = SPELL_FAILED_NOT_STANDING;

EzDMountTable = {
	["Exclude"] = {"aspect of the cheetah",
                  "aspect of the pack"
                 },
 };

 EzDHelp = {
         ["List"] = {"Type /ezd (config menu)",
                     "Type /ezd reset (reset configuration)",
                     "Type /ezd reload (reload UI)",
                     "Type /ezd debug (debug info on current buffs)",
                     " ",
                     "Available macro functions :",
                     "EzD_getdown()     (Dismounts you if mounted)",
                     "EzD_drop(buffname)     (Cancel the buff specified)",
                     "EzD_buffexist(buffname)     (Returns TRUE if specified buff is found)"
                    },
 };

 -- list from globalstrings.lua
 EzDShiftErr = {
         ["Error"] = {SPELL_FAILED_NOT_SHAPESHIFT,
                      SPELL_FAILED_NO_ITEMS_WHILE_SHAPESHIFTED,
                      SPELL_NOT_SHAPESHIFTED,
                      SPELL_NOT_SHAPESHIFTED_NOSPACE,
                      ERR_CANT_INTERACT_SHAPESHIFTED,
                      ERR_NOT_WHILE_SHAPESHIFTED,
                      ERR_NO_ITEMS_WHILE_SHAPESHIFTED,
                      ERR_TAXIPLAYERSHAPESHIFTED,
                      ERR_MOUNT_SHAPESHIFTED,
                      ERR_EMBLEMERROR_NOTABARDGEOSET,
                     },
 };

 -- list from globalstrings.lua
 EzDMountErr = {
         ["Error"] = {SPELL_FAILED_NOT_MOUNTED,
                      ERR_ATTACK_MOUNTED,
                     },
 };
