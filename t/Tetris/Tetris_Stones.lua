--[[ 
infoart
1 = info des entsprechenden bausteins (anz_lagen, anz_steine)
2 = info einer bestimmten bausteinlage
		z.b. Tetris_bausteine_info (4,2.3)
				baustein 4
				info 2
				lage 3

SCHEMA

--X
if (baustein == X) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 7;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		local s6 = "";
		local s7 = "";
		if (lage == 1) then
			s1 = "x0y0";
			s2 = "x0y0";
			s3 = "x0y0";
			s4 = "x0y0";
			s5 = "x0y0";
			s6 = "x0y0";
			s7 = "x0y0";
		end
		if (lage == 2) then
			s1 = "x0y0";
			s2 = "x0y0";
			s3 = "x0y0";
			s4 = "x0y0";
			s5 = "x0y0";
			s6 = "x0y0";
			s7 = "x0y0";
		end
		if (lage == 3) then
			s1 = "x0y0";
			s2 = "x0y0";
			s3 = "x0y0";
			s4 = "x0y0";
			s5 = "x0y0";
			s6 = "x0y0";
			s7 = "x0y0";
		end
		if (lage == 4) then
			s1 = "x0y0";
			s2 = "x0y0";
			s3 = "x0y0";
			s4 = "x0y0";
			s5 = "x0y0";
			s6 = "x0y0";
			s7 = "x0y0";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5, [6]=s6, [7]=s7 };
		return info;
	end
end

--]]

function Tetris_bausteine_laden ()
	
end

--local t = { [1]="green", [2]="orange", [3]="yellow" };
--message(t[1]);



function Tetris_baustein (baustein, infoart, lage)

--1
if (baustein == 1) then
	if (infoart == 1) then
		local anz_lagen = 1;
		local anz_steine = 4;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4 };
		return info;
	end
end

--2
if (baustein == 2) then
	if (infoart == 1) then
		local anz_lagen = 2;
		local anz_steine = 4;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		if (lage == 1) then
			s1 = "x-2y0";
			s2 = "x-1y0";
			s3 = "x0y0";
			s4 = "x1y0";
		end
		if (lage == 2) then
			s1 = "x0y1";
			s2 = "x0y0";
			s3 = "x0y-1";
			s4 = "x0y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4 };
		return info;
	end
end

--3
if (baustein == 3) then
	if (infoart == 1) then
		local anz_lagen = 2;
		local anz_steine = 4;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		if (lage == 1) then
			s1 = "x0y0";
			s2 = "x1y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
		end
		if (lage == 2) then
			s1 = "x0y1";
			s2 = "x0y0";
			s3 = "x1y0";
			s4 = "x1y-1";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4 };
		return info;
	end
end

--4
if (baustein == 4) then
	if (infoart == 1) then
		local anz_lagen = 2;
		local anz_steine = 4;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x0y-1";
			s4 = "x1y-1";
		end
		if (lage == 2) then
			s1 = "x1y1";
			s2 = "x0y0";
			s3 = "x1y0";
			s4 = "x0y-1";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4 };
		return info;
	end
end

--5
if (baustein == 5) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 4;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x1y0";
			s4 = "x-1y-1";
		end
		if (lage == 2) then
			s1 = "x0y1";
			s2 = "x0y0";
			s3 = "x0y-1";
			s4 = "x1y-1";
		end
		if (lage == 3) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x1y0";
			s4 = "x1y1";
		end
		if (lage == 4) then
			s1 = "x-1y1";
			s2 = "x0y1";
			s3 = "x0y0";
			s4 = "x0y-1";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4 };
		return info;
	end
end


--6
if (baustein == 6) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 4;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x1y0";
			s4 = "x1y-1";
		end
		if (lage == 2) then
			s1 = "x0y1";
			s2 = "x0y0";
			s3 = "x0y-1";
			s4 = "x1y1";
		end
		if (lage == 3) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x1y0";
			s4 = "x-1y1";
		end
		if (lage == 4) then
			s1 = "x-1y-1";
			s2 = "x0y1";
			s3 = "x0y0";
			s4 = "x0y-1";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4 };
		return info;
	end
end

--7
if (baustein == 7) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 4;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x1y0";
			s4 = "x0y-1";
		end
		if (lage == 2) then
			s1 = "x0y1";
			s2 = "x0y0";
			s3 = "x0y-1";
			s4 = "x1y0";
		end
		if (lage == 3) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x1y0";
			s4 = "x0y1";
		end
		if (lage == 4) then
			s1 = "x0y1";
			s2 = "x0y0";
			s3 = "x0y-1";
			s4 = "x-1y0";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4 };
		return info;
	end
end

--8
if (baustein == 8) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 4;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x1y0";
			s3 = "x0y-1";
			s4 = "x0y-2";
		end
		if (lage == 2) then
			s1 = "x-1y0";
			s2 = "x0y-1";
			s3 = "x1y-1";
			s4 = "x-1y-2";
		end
		if (lage == 3) then
			s1 = "x0y0";
			s2 = "x0y-1";
			s3 = "x-1y-2";
			s4 = "x1y-2";
		end
		if (lage == 4) then
			s1 = "x1y0";
			s2 = "x0y-1";
			s3 = "x-1y-1";
			s4 = "x0y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4 };
		return info;
	end
end

--9
if (baustein == 9) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 4;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x0y-1";
			s3 = "x1y-1";
			s4 = "x0y-2";
		end
		if (lage == 2) then
			s1 = "x0y0";
			s2 = "x0y-1";
			s3 = "x1y-1";
			s4 = "x-1y-2";
		end
		if (lage == 3) then
			s1 = "x0y0";
			s2 = "x0y-1";
			s3 = "x-1y-1";
			s4 = "x1y-2";
		end
		if (lage == 4) then
			s1 = "x1y0";
			s2 = "x0y-1";
			s3 = "x-1y-1";
			s4 = "x0y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4 };
		return info;
	end
end

--10
if (baustein == 10) then
	if (infoart == 1) then
		local anz_lagen = 1;
		local anz_steine = 1;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		if (lage == 1) then
			s1 = "x0y0";
		end
		local info = { [1]=s1 };
		return info;
	end
end

--11
if (baustein == 11) then
	if (infoart == 1) then
		local anz_lagen = 2;
		local anz_steine = 2;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		if (lage == 1) then
			s1 = "x0y0";
			s2 = "x1y0";
		end
		if (lage == 2) then
			s1 = "x0y0";
			s2 = "x0y-1";
		end
		local info = { [1]=s1, [2]=s2 };
		return info;
	end
end

--12
if (baustein == 12) then
	if (infoart == 1) then
		local anz_lagen = 2;
		local anz_steine = 2;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		if (lage == 1) then
			s1 = "x0y0";
			s2 = "x1y-1";
		end
		if (lage == 2) then
			s1 = "x1y0";
			s2 = "x0y-1";
		end
		local info = { [1]=s1, [2]=s2 };
		return info;
	end
end

--13
if (baustein == 13) then
	if (infoart == 1) then
		local anz_lagen = 2;
		local anz_steine = 2;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x1y0";
		end
		if (lage == 2) then
			s1 = "x0y1";
			s2 = "x0y-1";
		end
		local info = { [1]=s1, [2]=s2 };
		return info;
	end
end

--14
if (baustein == 14) then
	if (infoart == 1) then
		local anz_lagen = 2;
		local anz_steine = 3;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";

		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x1y0";
		end
		if (lage == 2) then
			s1 = "x0y1";
			s2 = "x0y0";
			s3 = "x0y-1";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3 };
		return info;
	end
end

--15
if (baustein == 15) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 3;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		if (lage == 1) then
			s1 = "x0y0";
			s2 = "x1y0";
			s3 = "x-1y-1";
		end
		if (lage == 2) then
			s1 = "x0y1";
			s2 = "x0y0";
			s3 = "x1y-1";
		end
		if (lage == 3) then
			s1 = "x0y0";
			s2 = "x-1y0";
			s3 = "x1y1";
		end
		if (lage == 4) then
			s1 = "x-1y1";
			s2 = "x0y0";
			s3 = "x0y-1";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3 };
		return info;
	end
end

--16
if (baustein == 16) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 3;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";

		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x1y-1";
		end
		if (lage == 2) then
			s1 = "x1y1";
			s2 = "x0y0";
			s3 = "x0y-1";
		end
		if (lage == 3) then
			s1 = "x-1y1";
			s2 = "x0y0";
			s3 = "x1y0";
		end
		if (lage == 4) then
			s1 = "x0y1";
			s2 = "x0y0";
			s3 = "x-1y-1";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3 };
		return info;
	end
end

--17
if (baustein == 17) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 3;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";

		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x1y0";
			s3 = "x0y-1";
		end
		if (lage == 2) then
			s1 = "x0y1";
			s2 = "x0y-1";
			s3 = "x1y0";
		end
		if (lage == 3) then
			s1 = "x-1y0";
			s2 = "x1y0";
			s3 = "x0y1";
		end
		if (lage == 4) then
			s1 = "x0y1";
			s2 = "x0y-1";
			s3 = "x-1y0";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3 };
		return info;
	end
end

--18
if (baustein == 18) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 3;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";

		if (lage == 1) then
			s1 = "x0y-1";
			s2 = "x1y0";
			s3 = "x0y0";
		end
		if (lage == 2) then
			s1 = "x0y-1";
			s2 = "x1y-1";
			s3 = "x0y0";
		end
		if (lage == 3) then
			s1 = "x0y-1";
			s2 = "x1y0";
			s3 = "x1y-1";
		end		
		if (lage == 4) then
			s1 = "x0y0";
			s2 = "x1y0";
			s3 = "x1y-1";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3 };
		return info;
	end
end

--19
if (baustein == 19) then
	if (infoart == 1) then
		local anz_lagen = 2;
		local anz_steine = 3;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";

		if (lage == 1) then
			s1 = "x1y0";
			s2 = "x0y-1";
			s3 = "x-1y-2";
		end
		if (lage == 2) then
			s1 = "x-1y0";
			s2 = "x0y-1";
			s3 = "x1y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3 };
		return info;
	end
end

--20
if (baustein == 20) then
	if (infoart == 1) then
		local anz_lagen = 1;
		local anz_steine = 5;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		if (lage == 1) then
			s1 = "x0y0";
			s2 = "x0y-1";
			s3 = "x0y-2";
			s4 = "x1y-1";
			s5 = "x-1y-1";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5 };
		return info;
	end
end

--21
if (baustein == 21) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 5;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		if (lage == 1) then
			s1 = "x0y-2";
			s2 = "x-1y-2";
			s3 = "x-2y-2";
			s4 = "x1y-1";
			s5 = "x1y0";
		end
		if (lage == 2) then
			s1 = "x1y0";
			s2 = "x1y-1";
			s3 = "x1y-2";
			s4 = "x0y1";
			s5 = "x-1y1";
		end
		if (lage == 3) then
			s1 = "x1y1";
			s2 = "x0y1";
			s3 = "x-1y1";
			s4 = "x-2y0";
			s5 = "x-2y-1";
		end
		if (lage == 4) then
			s1 = "x-2y1";
			s2 = "x-2y0";
			s3 = "x-2y-1";
			s4 = "x-1y-2";
			s5 = "x0y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5 };
		return info;
	end
end

--22
if (baustein == 22) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 5;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		if (lage == 1) then
			s1 = "x1y0";
			s2 = "x-1y0";
			s3 = "x0y0";
			s4 = "x0y-1";
			s5 = "x0y-2";
		end
		if (lage == 2) then
			s1 = "x-1y0";
			s2 = "x-1y-1";
			s3 = "x-1y-2";
			s4 = "x0y-1";
			s5 = "x1y-1";
		end
		if (lage == 3) then
			s1 = "x0y0";
			s2 = "x0y-1";
			s3 = "x0y-2";
			s4 = "x-1y-2";
			s5 = "x1y-2";
		end
		if (lage == 4) then
			s1 = "x1y0";
			s2 = "x1y-2";
			s3 = "x1y-1";
			s4 = "x0y-1";
			s5 = "x-1y-1";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5 };
		return info;
	end
end

--23
if (baustein == 23) then
	if (infoart == 1) then
		local anz_lagen = 2;
		local anz_steine = 5;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		if (lage == 1) then
			s1 = "x0y0";
			s2 = "x0y-1";
			s3 = "x0y-2";
			s4 = "x-1y-2";
			s5 = "x1y0";
		end
		if (lage == 2) then
			s1 = "x-1y0";
			s2 = "x-1y-1";
			s3 = "x0y-1";
			s4 = "x1y-1";
			s5 = "x1y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5 };
		return info;
	end
end

--24
if (baustein == 24) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 5;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		if (lage == 1) then
			s1 = "x-2y0";
			s2 = "x-1y0";
			s3 = "x1y0";
			s4 = "x0y0";
			s5 = "x1y-1";
		end
		if (lage == 2) then
			s1 = "x-1y1";
			s2 = "x-1y0";
			s3 = "x-1y-1";
			s4 = "x-1y-2";
			s5 = "x0y1";
		end
		if (lage == 3) then
			s1 = "x-2y0";
			s2 = "x-2y-1";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x1y-1";
		end
		if (lage == 4) then
			s1 = "x0y1";
			s2 = "x0y0";
			s3 = "x0y-1";
			s4 = "x0y-2";
			s5 = "x-1y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5 };
		return info;
	end
end

--25
if (baustein == 25) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 5;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		if (lage == 1) then
			s1 = "x-2y0";
			s2 = "x-1y0";
			s3 = "x0y0";
			s4 = "x1y0";
			s5 = "x-2y-1";
		end
		if (lage == 2) then
			s1 = "x-1y1";
			s2 = "x-1y0";
			s3 = "x-1y-1";
			s4 = "x-1y-2";
			s5 = "x0y-2";
		end
		if (lage == 3) then
			s1 = "x-2y-1";
			s2 = "x-1y-1";
			s3 = "x0y-1";
			s4 = "x1y-1";
			s5 = "x1y0";
		end
		if (lage == 4) then
			s1 = "x0y1";
			s2 = "x0y0";
			s3 = "x0y-1";
			s4 = "x0y-2";
			s5 = "x-1y1";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5 };
		return info;
	end
end

--26
if (baustein == 26) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 5;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x1y0";
			s4 = "x-1y-1";
			s5 = "x1y-1";
		end
		if (lage == 2) then
			s1 = "x-1y0";
			s2 = "x-1y-1";
			s3 = "x-1y-2";
			s4 = "x0y0";
			s5 = "x0y-2";
		end
		if (lage == 3) then
			s1 = "x-1y-2";
			s2 = "x0y-2";
			s3 = "x1y-2";
			s4 = "x-1y-1";
			s5 = "x1y-1";
		end
		if (lage == 4) then
			s1 = "x1y0";
			s2 = "x1y-1";
			s3 = "x1y-2";
			s4 = "x0y0";
			s5 = "x0y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5 };
		return info;
	end
end

--27
if (baustein == 27) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 5;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x1y-2";
		end
		if (lage == 2) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x1y1";
		end
		if (lage == 3) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x-2y1";
		end
		if (lage == 4) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x-2y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5 };
		return info;
	end
end

--28
if (baustein == 28) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 5;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x1y-1";
		end
		if (lage == 2) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x0y1";
		end
		if (lage == 3) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x-2y0";
		end
		if (lage == 4) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x-1y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5 };
		return info;
	end
end

--29
if (baustein == 29) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 5;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x1y0";
		end
		if (lage == 2) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x-1y1";
		end
		if (lage == 3) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x-2y-1";
		end
		if (lage == 4) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x0y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5 };
		return info;
	end
end

--30
if (baustein == 30) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 5;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		if (lage == 1) then
			s1 = "x-2y0";
			s2 = "x-1y0";
			s3 = "x0y0";
			s4 = "x1y0";
			s5 = "x0y-1";
		end
		if (lage == 2) then
			s1 = "x-1y1";
			s2 = "x-1y0";
			s3 = "x-1y-1";
			s4 = "x-1y-2";
			s5 = "x0y0";
		end
		if (lage == 3) then
			s1 = "x-2y-1";
			s2 = "x-1y-1";
			s3 = "x0y-1";
			s4 = "x1y-1";
			s5 = "x-1y0";
		end
		if (lage == 4) then
			s1 = "x0y1";
			s2 = "x0y0";
			s3 = "x0y-2";
			s4 = "x0y-1";
			s5 = "x-1y-1";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5 };
		return info;
	end
end

--31
if (baustein == 31) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 5;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		if (lage == 1) then
			s1 = "x-2y0";
			s2 = "x-1y0";
			s3 = "x0y0";
			s4 = "x1y0";
			s5 = "x-1y-1";
		end
		if (lage == 2) then
			s1 = "x-1y1";
			s2 = "x-1y0";
			s3 = "x-1y-1";
			s4 = "x-1y-2";
			s5 = "x0y-1";
		end
		if (lage == 3) then
			s1 = "x-1y-1";
			s2 = "x-2y-1";
			s3 = "x0y-1";
			s4 = "x1y-1";
			s5 = "x0y0";
		end
		if (lage == 4) then
			s1 = "x0y1";
			s2 = "x0y0";
			s3 = "x0y-2";
			s4 = "x0y-1";
			s5 = "x-1y0";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5 };
		return info;
	end
end

--32
if (baustein == 32) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 5;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		if (lage == 1) then
			s1 = "x0y0";
			s2 = "x0y-1";
			s3 = "x-1y-1";
			s4 = "x0y-2";
			s5 = "x1y-2";
		end
		if (lage == 2) then
			s1 = "x1y0";
			s2 = "x1y-1";
			s3 = "x0y-1";
			s4 = "x-1y-1";
			s5 = "x0y-2";
		end
		if (lage == 4) then
			s1 = "x0y0";
			s2 = "x-1y-1";
			s3 = "x0y-1";
			s4 = "x1y-1";
			s5 = "x-1y-2";
		end
		if (lage == 3) then
			s1 = "x0y0";
			s2 = "x-1y0";
			s3 = "x0y-1";
			s4 = "x0y-2";
			s5 = "x1y-1";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5 };
		return info;
	end
end

--33
if (baustein == 33) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 5;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		if (lage == 1) then
			s1 = "x1y0";
			s2 = "x0y0";
			s3 = "x0y-1";
			s4 = "x0y-2";
			s5 = "x-1y-1";
		end
		if (lage == 2) then
			s1 = "x-1y0";
			s2 = "x1y-1";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x0y-2";
		end
		if (lage == 3) then
			s1 = "x0y0";
			s2 = "x0y-1";
			s3 = "x0y-2";
			s4 = "x-1y-2";
			s5 = "x1y-1";
		end
		if (lage == 4) then
			s1 = "x1y-1";
			s2 = "x0y-1";
			s3 = "x-1y-1";
			s4 = "x0y0";
			s5 = "x1y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5 };
		return info;
	end
end

--34
if (baustein == 34) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 5;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		if (lage == 1) then
			s1 = "x0y0";
			s2 = "x1y0";
			s3 = "x0y-1";
			s4 = "x-1y-1";
			s5 = "x-1y-2";
		end
		if (lage == 2) then
			s1 = "x-1y0";
			s2 = "x-1y-1";
			s3 = "x0y-1";
			s4 = "x0y-2";
			s5 = "x1y-2";
		end
		if (lage == 3) then
			s1 = "x1y0";
			s2 = "x1y-1";
			s3 = "x0y-1";
			s4 = "x0y-2";
			s5 = "x-1y-2";
		end
		if (lage == 4) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x0y-1";
			s4 = "x1y-1";
			s5 = "x1y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5 };
		return info;
	end
end

--35
if (baustein == 35) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 5;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x1y0";
			s4 = "x-1y-1";
			s5 = "x-2y-2";
		end
		if (lage == 2) then
			s1 = "x-1y1";
			s2 = "x-1y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x1y-2";
		end
		if (lage == 3) then
			s1 = "x-2y-1";
			s2 = "x-1y-1";
			s3 = "x0y-1";
			s4 = "x0y0";
			s5 = "x1y1";
		end
		if (lage == 4) then
			s1 = "x-2y1";
			s2 = "x-1y0";
			s3 = "x0y0";
			s4 = "x0y-1";
			s5 = "x0y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5 };
		return info;
	end
end

--36
if (baustein == 36) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 5;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		if (lage == 1) then
			s1 = "x-2y0";
			s2 = "x-1y0";
			s3 = "x0y0";
			s4 = "x0y-1";
			s5 = "x1y-2";
		end
		if (lage == 2) then
			s1 = "x1y1";
			s2 = "x0y0";
			s3 = "x-1y0";
			s4 = "x-1y-1";
			s5 = "x-1y-2";
		end
		if (lage == 3) then
			s1 = "x-2y1";
			s2 = "x-1y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x1y-1";
		end
		if (lage == 4) then
			s1 = "x0y1";
			s2 = "x0y0";
			s3 = "x0y-1";
			s4 = "x-1y-1";
			s5 = "x-2y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5 };
		return info;
	end
end

--37
if (baustein == 37) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 5;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		if (lage == 1) then
			s1 = "x-2y-1";
			s2 = "x-1y-1";
			s3 = "x0y-1";
			s4 = "x0y0";
			s5 = "x1y0";
		end
		if (lage == 2) then
			s1 = "x-1y1";
			s2 = "x-1y0";
			s3 = "x0y0";
			s4 = "x0y-1";
			s5 = "x0y-2";
		end
		if (lage == 3) then
			s1 = "x-2y-1";
			s2 = "x-1y-1";
			s3 = "x-1y0";
			s4 = "x0y0";
			s5 = "x1y0";
		end
		if (lage == 4) then
			s1 = "x-1y1";
			s2 = "x-1y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x0y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5 };
		return info;
	end
end

--38
if (baustein == 38) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 5;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x-2y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x1y-1";
		end
		if (lage == 2) then
			s1 = "x0y1";
			s2 = "x0y0";
			s3 = "x0y-1";
			s4 = "x-1y-1";
			s5 = "x-1y-2";
		end
		if (lage == 3) then
			s1 = "x-2y0";
			s2 = "x-1y0";
			s3 = "x0y0";
			s4 = "x0y-1";
			s5 = "x1y-1";
		end
		if (lage == 4) then
			s1 = "x0y1";
			s2 = "x0y0";
			s3 = "x-1y0";
			s4 = "x-1y-1";
			s5 = "x-1y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5 };
		return info;
	end
end

--39
if (baustein == 39) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 5;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x-1y-1";
			s3 = "x-1y-2";
			s4 = "x0y-2";
			s5 = "x1y-2";
		end
		if (lage == 2) then
			s1 = "x1y0";
			s2 = "x1y-1";
			s3 = "x1y-2";
			s4 = "x0y-2";
			s5 = "x-1y-2";
		end
		if (lage == 3) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x1y0";
			s4 = "x1y-1";
			s5 = "x1y-2";
		end
		if (lage == 4) then
			s1 = "x1y0";
			s2 = "x0y0";
			s3 = "x-1y0";
			s4 = "x-1y-1";
			s5 = "x-1y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5 };
		return info;
	end
end

--40
if (baustein == 40) then
	if (infoart == 1) then
		local anz_lagen = 2;
		local anz_steine = 6;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		local s6 = "";
		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x1y0";
			s4 = "x-1y-2";
			s5 = "x0y-2";
			s6 = "x1y-2";
		end
		if (lage == 2) then
			s1 = "x-1y0";
			s2 = "x-1y-1";
			s3 = "x-1y-2";
			s4 = "x1y0";
			s5 = "x1y-1";
			s6 = "x1y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5, [6]=s6 };
		return info;
	end
end

--41
if (baustein == 41) then
	if (infoart == 1) then
		local anz_lagen = 2;
		local anz_steine = 6;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		local s6 = "";
		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x-1y-1";
			s3 = "x-1y-2";
			s4 = "x0y0";
			s5 = "x0y-1";
			s6 = "x0y-2";
		end
		if (lage == 2) then
			s1 = "x-1y-1";
			s2 = "x0y-1";
			s3 = "x1y-1";
			s4 = "x-1y-2";
			s5 = "x0y-2";
			s6 = "x1y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5, [6]=s6 };
		return info;
	end
end

--42
if (baustein == 42) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 6;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		local s6 = "";
		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x1y-1";
			s6 = "x0y-2";
		end
		if (lage == 2) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x0y1";
			s6 = "x1y0";
		end
		if (lage == 3) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x-1y1";
			s6 = "x-2y0";
		end
		if (lage == 4) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x-2y-1";
			s6 = "x-1y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5, [6]=s6 };
		return info;
	end
end

--43
if (baustein == 43) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 6;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		local s6 = "";
		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x1y0";
			s6 = "x-1y-2";
		end
		if (lage == 2) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x-1y1";
			s6 = "x1y-1";
		end
		if (lage == 3) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x0y1";
			s6 = "x-2y-1";
		end
		if (lage == 4) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x-2y0";
			s6 = "x0y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5, [6]=s6 };
		return info;
	end
end

--44
if (baustein == 44) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 6;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		local s6 = "";
		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x1y0";
			s6 = "x0y-2";
		end
		if (lage == 2) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x-1y1";
			s6 = "x1y0";
		end
		if (lage == 3) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x-1y1";
			s6 = "x-2y-1";
		end
		if (lage == 4) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x-2y-1";
			s6 = "x0y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5, [6]=s6 };
		return info;
	end
end

--45
if (baustein == 45) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 6;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		local s6 = "";
		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x1y-1";
			s6 = "x-1y-2";
		end
		if (lage == 2) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x0y1";
			s6 = "x1y-1";
		end
		if (lage == 3) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x0y1";
			s6 = "x-2y0";
		end
		if (lage == 4) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x-2y0";
			s6 = "x-1y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5, [6]=s6 };
		return info;
	end
end

--46
if (baustein == 46) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 6;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		local s6 = "";
		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x1y0";
			s6 = "x-2y0";
		end
		if (lage == 2) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x-1y1";
			s6 = "x-1y-2";
		end
		if (lage == 3) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x1y-1";
			s6 = "x-2y-1";
		end
		if (lage == 4) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x-1y-1";
			s4 = "x0y-1";
			s5 = "x0y1";
			s6 = "x0y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5, [6]=s6 };
		return info;
	end
end

--47
if (baustein == 47) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 6;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		local s6 = "";
		if (lage == 1) then
			s1 = "x-1y0";
			s2 = "x-1y-1";
			s3 = "x-1y-2";
			s4 = "x0y-2";
			s5 = "x1y-2";
			s6 = "x1y-1";
		end
		if (lage == 2) then
			s1 = "x0y0";
			s2 = "x1y0";
			s3 = "x1y-2";
			s4 = "x1y-1";
			s5 = "x0y-2";
			s6 = "x-1y-2";
		end
		if (lage == 3) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x1y0";
			s4 = "x-1y-1";
			s5 = "x1y-1";
			s6 = "x1y-2";
		end
		if (lage == 4) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x1y0";
			s4 = "x-1y-1";
			s5 = "x-1y-2";
			s6 = "x0y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5, [6]=s6 };
		return info;
	end
end

--48
if (baustein == 48) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 6;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		local s6 = "";
		if (lage == 1) then
			s1 = "x1y0";
			s2 = "x1y-1";
			s3 = "x1y-2";
			s4 = "x0y-2";
			s5 = "x-1y-2";
			s6 = "x-1y-1";
		end
		if (lage == 2) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x1y0";
			s4 = "x1y-1";
			s5 = "x1y-2";
			s6 = "x0y-2";
		end
		if (lage == 3) then
			s1 = "x-1y0";
			s2 = "x0y0";
			s3 = "x1y0";
			s4 = "x1y-1";
			s5 = "x-1y-1";
			s6 = "x-1y-2";
		end
		if (lage == 4) then
			s1 = "x0y0";
			s2 = "x-1y0";
			s3 = "x-1y-1";
			s4 = "x-1y-2";
			s5 = "x0y-2";
			s6 = "x1y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5, [6]=s6 };
		return info;
	end
end

--49
if (baustein == 49) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 6;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		local s6 = "";
		if (lage == 1) then
			s1 = "x1y-1";
			s2 = "x0y-1";
			s3 = "x-1y-1";
			s4 = "x-2y-1";
			s5 = "x-2y0";
			s6 = "x-2y-2";
		end
		if (lage == 2) then
			s1 = "x1y-2";
			s2 = "x0y-2";
			s3 = "x-1y-2";
			s4 = "x0y-1";
			s5 = "x0y0";
			s6 = "x0y1";
		end
		if (lage == 3) then
			s1 = "x-2y-1";
			s2 = "x-1y-1";
			s3 = "x0y-1";
			s4 = "x1y-1";
			s5 = "x1y0";
			s6 = "x1y-2";
		end
		if (lage == 4) then
			s1 = "x-1y1";
			s2 = "x0y1";
			s3 = "x1y1";
			s4 = "x0y0";
			s5 = "x0y-1";
			s6 = "x0y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5, [6]=s6 };
		return info;
	end
end

--50
if (baustein == 50) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 6;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		local s6 = "";
		if (lage == 1) then
			s1 = "x-2y-1";
			s2 = "x-1y-1";
			s3 = "x0y-1";
			s4 = "x1y-1";
			s5 = "x-1y0";
			s6 = "x-1y-2";
		end
		if (lage == 2) then
			s1 = "x0y1";
			s2 = "x0y0";
			s3 = "x0y-1";
			s4 = "x0y-2";
			s5 = "x-1y-1";
			s6 = "x1y-1";
		end
		if (lage == 3) then
			s1 = "x-2y-1";
			s2 = "x-1y-1";
			s3 = "x0y-1";
			s4 = "x1y-1";
			s5 = "x0y0";
			s6 = "x0y-2";
		end
		if (lage == 4) then
			s1 = "x0y1";
			s2 = "x0y0";
			s3 = "x0y-1";
			s4 = "x0y-2";
			s5 = "x-1y0";
			s6 = "x1y0";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5, [6]=s6 };
		return info;
	end
end

--51
if (baustein == 51) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 6;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		local s6 = "";
		if (lage == 1) then
			s1 = "x-2y-1";
			s2 = "x-1y-1";
			s3 = "x0y-1";
			s4 = "x1y-1";
			s5 = "x-2y0";
			s6 = "x1y0";
		end
		if (lage == 2) then
			s1 = "x0y1";
			s2 = "x0y0";
			s3 = "x0y-1";
			s4 = "x0y-2";
			s5 = "x-1y1";
			s6 = "x-1y-2";
		end
		if (lage == 3) then
			s1 = "x-2y0";
			s2 = "x-1y0";
			s3 = "x0y0";
			s4 = "x1y0";
			s5 = "x-2y-1";
			s6 = "x1y-1";
		end
		if (lage == 4) then
			s1 = "x-1y1";
			s2 = "x-1y0";
			s3 = "x-1y-1";
			s4 = "x-1y-2";
			s5 = "x0y1";
			s6 = "x0y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5, [6]=s6 };
		return info;
	end
end

--52
if (baustein == 52) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 6;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		local s6 = "";
		if (lage == 1) then
			s1 = "x-2y0";
			s2 = "x-1y0";
			s3 = "x0y0";
			s4 = "x1y0";
			s5 = "x-1y-1";
			s6 = "x1y-1";
		end
		if (lage == 2) then
			s1 = "x-1y1";
			s2 = "x-1y0";
			s3 = "x-1y-1";
			s4 = "x-1y-2";
			s5 = "x0y1";
			s6 = "x0y-1";
		end
		if (lage == 3) then
			s1 = "x-2y-1";
			s2 = "x-1y-1";
			s3 = "x0y-1";
			s4 = "x1y-1";
			s5 = "x0y0";
			s6 = "x-2y0";
		end
		if (lage == 4) then
			s1 = "x0y1";
			s2 = "x0y0";
			s3 = "x0y-1";
			s4 = "x0y-2";
			s5 = "x-1y0";
			s6 = "x-1y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5, [6]=s6 };
		return info;
	end
end

--53
if (baustein == 53) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 6;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		local s6 = "";
		if (lage == 1) then
			s1 = "x-2y0";
			s2 = "x-1y0";
			s3 = "x0y0";
			s4 = "x1y0";
			s5 = "x0y-1";
			s6 = "x-2y-1";
		end
		if (lage == 2) then
			s1 = "x-1y1";
			s2 = "x-1y0";
			s3 = "x-1y-1";
			s4 = "x-1y-2";
			s5 = "x0y0";
			s6 = "x0y-2";
		end
		if (lage == 3) then
			s1 = "x-2y-1";
			s2 = "x-1y-1";
			s3 = "x0y-1";
			s4 = "x1y-1";
			s5 = "x1y0";
			s6 = "x-1y0";
		end
		if (lage == 4) then
			s1 = "x0y1";
			s2 = "x0y0";
			s3 = "x0y-1";
			s4 = "x0y-2";
			s5 = "x-1y1";
			s6 = "x-1y-1";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5, [6]=s6 };
		return info;
	end
end

--54
if (baustein == 54) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 6;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		local s6 = "";
		if (lage == 1) then
			s1 = "x-2y0";
			s2 = "x-1y0";
			s3 = "x0y0";
			s4 = "x1y0";
			s5 = "x-1y-1";
			s6 = "x-2y-1";
		end
		if (lage == 2) then
			s1 = "x-1y1";
			s2 = "x-1y0";
			s3 = "x-1y-1";
			s4 = "x-1y-2";
			s5 = "x0y-1";
			s6 = "x0y-2";
		end
		if (lage == 3) then
			s1 = "x-2y-1";
			s2 = "x-1y-1";
			s3 = "x0y-1";
			s4 = "x1y-1";
			s5 = "x1y0";
			s6 = "x0y0";
		end
		if (lage == 4) then
			s1 = "x0y1";
			s2 = "x0y0";
			s3 = "x0y-1";
			s4 = "x0y-2";
			s5 = "x-1y1";
			s6 = "x-1y0";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5, [6]=s6 };
		return info;
	end
end

--55
if (baustein == 55) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 6;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		local s6 = "";
		if (lage == 1) then
			s1 = "x-2y0";
			s2 = "x-1y0";
			s3 = "x0y0";
			s4 = "x1y0";
			s5 = "x0y-1";
			s6 = "x1y-1";
		end
		if (lage == 2) then
			s1 = "x-1y1";
			s2 = "x-1y0";
			s3 = "x-1y-1";
			s4 = "x-1y-2";
			s5 = "x0y0";
			s6 = "x0y1";
		end
		if (lage == 3) then
			s1 = "x-2y-1";
			s2 = "x-1y-1";
			s3 = "x0y-1";
			s4 = "x1y-1";
			s5 = "x-2y0";
			s6 = "x-1y0";
		end
		if (lage == 4) then
			s1 = "x0y1";
			s2 = "x0y0";
			s3 = "x0y-1";
			s4 = "x0y-2";
			s5 = "x-1y-2";
			s6 = "x-1y-1";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5, [6]=s6 };
		return info;
	end
end

--56
if (baustein == 56) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 6;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		local s6 = "";
		if (lage == 1) then
			s1 = "x-2y0";
			s2 = "x-1y0";
			s3 = "x0y0";
			s4 = "x1y0";
			s5 = "x1y-1";
			s6 = "x1y-2";
		end
		if (lage == 2) then
			s1 = "x-1y1";
			s2 = "x-1y0";
			s3 = "x-1y-1";
			s4 = "x-1y-2";
			s5 = "x0y1";
			s6 = "x1y1";
		end
		if (lage == 3) then
			s1 = "x-2y-1";
			s2 = "x-1y-1";
			s3 = "x0y-1";
			s4 = "x1y-1";
			s5 = "x-2y1";
			s6 = "x-2y0";
		end
		if (lage == 4) then
			s1 = "x0y1";
			s2 = "x0y0";
			s3 = "x0y-1";
			s4 = "x0y-2";
			s5 = "x-1y-2";
			s6 = "x-2y-2";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5, [6]=s6 };
		return info;
	end
end

--57
if (baustein == 57) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 6;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		local s6 = "";
		if (lage == 1) then
			s1 = "x-2y0";
			s2 = "x-1y0";
			s3 = "x0y0";
			s4 = "x1y0";
			s5 = "x-2y-1";
			s6 = "x-2y-2";
		end
		if (lage == 2) then
			s1 = "x-1y1";
			s2 = "x-1y0";
			s3 = "x-1y-1";
			s4 = "x-1y-2";
			s5 = "x0y-2";
			s6 = "x1y-2";
		end
		if (lage == 3) then
			s1 = "x-2y-1";
			s2 = "x-1y-1";
			s3 = "x0y-1";
			s4 = "x1y-1";
			s5 = "x1y1";
			s6 = "x1y0";
		end
		if (lage == 4) then
			s1 = "x0y1";
			s2 = "x0y0";
			s3 = "x0y-1";
			s4 = "x0y-2";
			s5 = "x-2y1";
			s6 = "x-1y1";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5, [6]=s6 };
		return info;
	end
end

--58
if (baustein == 58) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 7;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		local s6 = "";
		local s7 = "";
		if (lage == 1) then
			s1 = "x1y0";
			s2 = "x-1y0";
			s3 = "x1y-1";
			s4 = "x-1y-1";
			s5 = "x1y-2";
			s6 = "x-1y-2";
			s7 = "x0y0";
		end
		if (lage == 2) then
			s1 = "x1y0";
			s2 = "x-1y0";
			s3 = "x0y0";
			s4 = "x-1y-2";
			s5 = "x0y-2";
			s6 = "x1y-2";
			s7 = "x-1y-1";
		end
		if (lage == 3) then
			s1 = "x1y0";
			s2 = "x-1y0";
			s3 = "x1y-1";
			s4 = "x-1y-1";
			s5 = "x1y-2";
			s6 = "x-1y-2";
			s7 = "x0y-2";
		end
		if (lage == 4) then
			s1 = "x1y0";
			s2 = "x-1y0";
			s3 = "x0y0";
			s4 = "x-1y-2";
			s5 = "x0y-2";
			s6 = "x1y-2";
			s7 = "x1y-1";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5, [6]=s6, [7]=s7 };
		return info;
	end
end

--59
if (baustein == 59) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 6;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		local s6 = "";
		if (lage == 1) then
			s1 = "x0y0";
			s2 = "x-1y-1";
			s3 = "x-1y-2";
			s4 = "x1y-1";
			s5 = "x1y-2";
			s6 = "x0y-1";
		end
		if (lage == 2) then
			s1 = "x0y0";
			s2 = "x1y0";
			s3 = "x0y-2";
			s4 = "x1y-2";
			s5 = "x-1y-1";
			s6 = "x0y-1";
		end
		if (lage == 3) then
			s1 = "x1y0";
			s2 = "x1y-1";
			s3 = "x-1y0";
			s4 = "x-1y-1";
			s5 = "x0y-2";
			s6 = "x0y-1";
		end
		if (lage == 4) then
			s1 = "x0y0";
			s2 = "x-1y0";
			s3 = "x0y-2";
			s4 = "x-1y-2";
			s5 = "x1y-1";
			s6 = "x0y-1";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5, [6]=s6 };
		return info;
	end
end

--60
if (baustein == 60) then
	if (infoart == 1) then
		local anz_lagen = 4;
		local anz_steine = 5;
		local infos = { [1]=anz_lagen, [2]=anz_steine };
		return infos;
	end
	if (infoart == 2) then
		local s1 = "";
		local s2 = "";
		local s3 = "";
		local s4 = "";
		local s5 = "";
		if (lage == 1) then
			s1 = "x0y0";
			s2 = "x-1y-1";
			s3 = "x-1y-2";
			s4 = "x1y-1";
			s5 = "x1y-2";
		end
		if (lage == 2) then
			s1 = "x0y0";
			s2 = "x1y0";
			s3 = "x0y-2";
			s4 = "x1y-2";
			s5 = "x-1y-1";
		end
		if (lage == 3) then
			s1 = "x1y0";
			s2 = "x1y-1";
			s3 = "x-1y0";
			s4 = "x-1y-1";
			s5 = "x0y-2";
		end
		if (lage == 4) then
			s1 = "x0y0";
			s2 = "x-1y0";
			s3 = "x0y-2";
			s4 = "x-1y-2";
			s5 = "x1y-1";
		end
		local info = { [1]=s1, [2]=s2, [3]=s3, [4]=s4, [5]=s5 };
		return info;
	end
end

end

