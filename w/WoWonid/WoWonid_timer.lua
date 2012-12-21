--[[
Timers

wowon_balken
wowon_b xx

]]



function wowon_timer_balken (x)
-- x = true oder false, timer starten beenden
	--update geschwindigkeit
	local up = 0.01
	if (x==true) then
		Timex:AddNamedSchedule("wowon_balken", up, true, nil, wowon_sf_balken_move)
	end
	if (x==false) then
		Timex:DeleteNamedSchedule("wowon_balken")
	end
end


function wowon_timer_ball (x, b)
-- x = true oder false, timer starten beenden
-- b = ballnummer
	local up = 0.035
	if (x==true) then
		Timex:AddNamedSchedule("wowon_b"..b, up, true, nil, wowon_event_ball, b)
	end
	if (x==false) then
		Timex:DeleteNamedSchedule("wowon_b"..b)
	end
end


function wowon_timer_gxf (x, art, n)
-- x = true oder false, timer starten beenden
-- art = ball/feld/balken
-- n = nummer des ball/feld
	local up = 0.035
	if (x==true) then
		Timex:AddNamedSchedule("wowon_gxf_"..art..n, up, true, nil, wowon_UI_GXF_sf, art, n)
	end
	if (x==false) then
		Timex:DeleteNamedSchedule("wowon_gxf_"..art..n)
	end
end



--[[

Timex:NamedScheduleCheck("n")

Example:
Timex:CheckNamedSchedule("MyAddOnSchedNameOne")

-- return TRUE or nil.

Timex:AddNamedSchedule(n, t, r, c, f, a)

Key:
n	The name of the schedule, this is a string.
t	The delay before it fires, this is a number.
r	Whether it constantly repeats, this is a boolean.
c	The amount of times to run, this is a number.
f	The function name, this is not a string.
a	The function arguments.

Example:	
Timex:AddNamedSchedule("MyAddOnSchedNameTwo",5,TRUE,nil,ace["print"],ace,"Hello World!")


Timex:DeleteNamedSchedule("n")

Example:
Timex:DeleteNamedSchedule("MyAddOnSchedNameOne")

]]
