if not RecapFu then
	local compost = CompostLib:GetInstance('compost-1')
	RecapFu = compost:Acquire()
end

RecapFu.constants = {
	Title   = "FuBar - RecapFu",
	Cmd     = {"/recapfu", "/fubar_recapfu"},
	Cmd_Opt = {},

	TYPES = {a = "DPS", b = "DPS_IN", c = "DPS_OUT", d = "HEALING", e = "OVERHEAL", f = "MAXHIT"},
}