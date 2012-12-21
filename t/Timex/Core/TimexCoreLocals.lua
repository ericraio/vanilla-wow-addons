if not ace:LoadTranslation("Timex") then
TimexLocals = {}

--<< ================================================= >>--
-- Section I: The Chat Options.                          --
--<< ================================================= >>--

TimexLocals.ChatCmd = {"/timex", "/tmx"}
TimexLocals.ChatOpt = {
		{
			option = "debug",
			desc   = "Toggles debugging",
			method = "Debug",
			input = false
		},
	}

--<< ================================================= >>--
-- Section II: AddOn Information.                        --
--<< ================================================= >>--

TimexLocals.Title   = "Timex"
TimexLocals.Version = "RA.23"
TimexLocals.Desc    = "A timing system, yay!"

TimexLocals.TimexBar_Title = "TimexBar"

--<< ================================================= >>--
-- Section Omega: Closure.                               --
--<< ================================================= >>--

end