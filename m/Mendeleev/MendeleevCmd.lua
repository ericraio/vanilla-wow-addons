--Cmd options
MendeleevLocals.cmd 			= {"/Mendeleev","/Mend"}
MendeleevLocals.cmdOptions 		= {
{ 
	option	= "toggle",
	desc		= MendeleevLocals.Cmdstrings.Toggle,
 	method	= "CMDtoggle",
	input	= TRUE,
},

{
	option	= "KCI",
	desc		= MendeleevLocals.Cmdstrings.Int,
 	method	= "KCItoggle",
 	input	= TRUE,
	args    	= {
        			{
            			option  = "toggle",
            			desc    = MendeleevLocals.Cmdstrings.IntTog,
        			},
        			{
            			option  = "report",
            			desc    = MendeleevLocals.Cmdstrings.IntRep,
        			},
        		}
},
}