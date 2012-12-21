--[[
	Functions for "report to textbox"

	meta:
	.InfoFor = nil or name
	.InfoTypeString = The info string displayed (localized)
	.InfoTypeNum = the info number (same throughout languages)
	.SelectedFilter = "NONE", "PC", "NPC", "GROUP", "EGROUP"
	.ClassFilter = "NONE" or Class filter used (capitalized english names)
	.ClassFilterLocalized = Class filter used localized if known, else .ClassFilter
	.ShowPercent = true, false
	.ShowRank = true, false
	.ShowNumber = true, false
	.ReportAmount = 1 to 40 #amount of rows to show
	
	data:
	[1] string
	[2] value
	[3] nil or color{}
	[4] group number (normally 1) - Used to group different "things" e.g. used for details where heal and dmg info is displayed
	[5] % val of total
	
	Be sure to add new functions to SW_TE_Functions at the bottom of this file.
]]--
SW_TE_NL = "\r\n";

function SW_TE_Normal(meta, data)
	
	strOut = meta.InfoTypeString;
	if meta.InfoFor then
		strOut = strOut.." "..meta.InfoFor;	
	end
	strOut = strOut..SW_TE_NL;
	if meta.SelectedFilter ~= "NONE" then
		strOut = strOut..meta.SelectedFilter..SW_TE_NL;
	end
	if meta.ClassFilter ~= "NONE" then
		strOut = strOut..meta.ClassFilterLocalized..SW_TE_NL;
	end
	strOut = strOut..SW_TE_NL;

	for i, v in ipairs(data) do
		if i > meta.ReportAmount then
			break;
		end
		
		if meta.ShowRank then
			strOut = strOut..i.." "..v[1];
		else
			strOut = strOut..v[1];
		end
		if meta.ShowNumber then
			strOut = strOut.."  "..v[2];
		end
		if meta.ShowPercent then
			strOut = strOut.."  ("..v[5].."%)";
		end
		strOut = strOut..SW_TE_NL;
		
		
	end
	return strOut;
end

function SW_TE_HTML(meta, data)
	if meta.InfoFor then
		strOut = "<h1>"..meta.InfoTypeString.." "..meta.InfoFor.."</h1>";	
	else
		strOut = "<h1>"..meta.InfoTypeString.."</h1>";
	end
	strOut = strOut.."<br />"..SW_TE_NL;
	if meta.SelectedFilter ~= "NONE" then
		strOut = strOut..meta.SelectedFilter.."<br />"..SW_TE_NL;
	end
	if meta.ClassFilter ~= "NONE" then
		strOut = strOut..meta.ClassFilterLocalized.."<br />"..SW_TE_NL;
	end
	strOut = strOut..SW_TE_NL.."<table>"..SW_TE_NL;
	
	for i, v in ipairs(data) do
		if i > meta.ReportAmount then
			break;
		end
		strOut = strOut.."<tr>";
		if meta.ShowRank then
			strOut = strOut.."<td>"..i.."</td><td>"..v[1].."</td>";
		else
			strOut = strOut.."<td>"..v[1].."</td>";
			
		end
		if meta.ShowNumber then
			strOut = strOut.."<td>"..v[2].."</td>";
		end
		if meta.ShowPercent then
			strOut = strOut.."<td>("..v[5].."%)</td>";
		end
		strOut = strOut.."</tr>"..SW_TE_NL;
		
		
	end
	return strOut.."</table>";
end

SW_TE_Functions = {
	[1] = {SW_TE_Normal, "Normal"},
	[2] = {SW_TE_HTML, "HTML"},
};