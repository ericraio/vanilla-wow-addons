WANDCANCEL = {}

if( not ace:LoadTranslation("WandCancel") ) then

ace:RegisterGlobals({
    version = 1.02,

    ACEG_MAP_ONOFF = {[0]="|cffff5050Off|r",[1]="|cff00ff00On|r"},
})

WANDCANCEL.COMMANDS		= {"/wandcancel"}
WANDCANCEL.CMD_OPTIONS	= {}

end
