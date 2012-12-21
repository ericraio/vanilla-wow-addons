idChat2 = AceLibrary('AceAddon-2.0'):new('AceConsole-2.0', 'AceDB-2.0', 'AceDebug-2.0', 'AceEvent-2.0', 'AceHook-2.0', 'AceModuleCore-2.0')
idChat2:RegisterDB('idChat2DB')
idChat2:SetModuleMixins('AceEvent-2.0', 'AceHook-2.0')
idChat2.Options = {
    type = 'group',
    args = {}
}

function idChat2:OnEnable()
    self:RegisterChatCommand({'/idchat'}, self.Options)
end

function idChat2:OnDisable()
end

