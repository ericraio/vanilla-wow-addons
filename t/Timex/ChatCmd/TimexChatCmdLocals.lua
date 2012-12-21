if not ace:LoadTranslation("Timex") then

--<< ================================================= >>--
-- Section I: The Chat Options.                          --
--<< ================================================= >>--

local tinsert = table.insert;

if not TimexLocals.ChatOpt then
	TimexLocals.ChatOpt = {};
end
tinsert(TimexLocals.ChatOpt,
	{
		option        = "do",
		desc          = "execute a Timex schedule.",
		method        = "ChatExecute",
		input         = TRUE,
		args          = {
			{
				option  = "help",
				desc    = "the format for adding a schedule is as follows; n=ID:f=Func:r=TRUE:c=5:t=15:a=arg1, arg2, arg3 ... and so on.  The only two of these that are essential are the function and time.  The name is just an ID that can be recognized by the stop command.  If r is TRUE it will repeat until you run the stop command and c is a number that will run 'c' times until it's reached that number or until you run the stop command.  Finally, a represents the function's args."
			}
		}
	});
tinsert(TimexLocals.ChatOpt,
	{
		option        = "stop",
		desc          = "delete a Timex schedule.",
		method        = "ChatDelete",
		input         = TRUE,
		args          = {
			{
				option  = "help",
				desc    = "this command will allow you to delete a named schedule by simply supplying the ID of that schedule with this command.  Example; '/tmx stop MyScheduleOne'."
			}
		}
	});
tinsert(TimexLocals.ChatOpt,
	{
		option        = "addTimer",
		desc          = "add a timer.",
		method        = "ChatAddTimer",
		input         = TRUE,
	});
tinsert(TimexLocals.ChatOpt,
	{
		option        = "deleteTimer",
		desc          = "delete a timer.",
		method        = "ChatDeleteTimer",
		input         = TRUE,
	});
tinsert(TimexLocals.ChatOpt,
	{
		option        = "getTimer",
		desc          = "get the values of a timer.",
		method        = "ChatGetTimer",
		input         = TRUE,
	});
tinsert(TimexLocals.ChatOpt,
	{
		option        = "checkTimer",
		desc          = "check if a timer exists.",
		method        = "ChatCheckTimer",
		input         = TRUE,
	});

--<< ================================================= >>--
-- Section II: The Chat Option Variables.                --
--<< ================================================= >>--

TimexLocals.Chat_BadValues = "You did not supply a proper syntax, either your function or your delay-time was missing.  These are both required elements."
TimexLocals.Chat_Execute   = "Your Timex schedule has been successfully added and will execute on the timer you provided."
TimexLocals.Chat_BadDelete = "The timer named %s does not exist."
TimexLocals.Chat_Delete    = "You have deleted the timer named %s from Timex's database."

--<< ================================================= >>--
-- Section Omega: Closure.                               --
--<< ================================================= >>--

end