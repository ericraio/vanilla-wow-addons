-- Advanced Trade Skill Window v0.4.0
-- copyright 2006 by Rene Schneider (Slarti on EU-Blackhand)

-- custom sorting options script file

atsw_customsorting={};
atsw_customheaders={};
atsw_uncategorized={};
atsw_opencategory=0;

function ATSWCS_OnLoad()
	if(atsw_customsorting[UnitName("player")]==nil) then
		atsw_customsorting[UnitName("player")]={};
	end
	if(atsw_customsorting[UnitName("player")][atsw_selectedskill]==nil) then
		atsw_customsorting[UnitName("player")][atsw_selectedskill]={};
	end
	if(atsw_customheaders[UnitName("player")]==nil) then
		atsw_customheaders[UnitName("player")]={};
	end
	if(atsw_customheaders[UnitName("player")][atsw_selectedskill]==nil) then
		atsw_customheaders[UnitName("player")][atsw_selectedskill]={};
	end
	FauxScrollFrame_SetOffset(ATSWCSUListScrollFrame, 0);
	FauxScrollFrame_SetOffset(ATSWCSSListScrollFrame, 0);
	ATSWCS_UpdateUncategorizedList();
	ATSWCS_UpdateSkillList();
end

function ATSWCS_OnHide()

end

function ATSWCSFrame_OnEvent()
	
end

function ATSWCS_HideWindow()
	HideUIPanel(ATSWCSFrame);
end

function ATSWCS_Update()
	ATSWCS_UpdateSkillList();
end

function ATSWCS_UpdateSkillList()
	if(atsw_customsorting[UnitName("player")]==nil) then
		atsw_customsorting[UnitName("player")]={};
	end
	if(atsw_customsorting[UnitName("player")][atsw_selectedskill]==nil) then
		atsw_customsorting[UnitName("player")][atsw_selectedskill]={};
	end
	if(atsw_customheaders[UnitName("player")]==nil) then
		atsw_customheaders[UnitName("player")]={};
	end
	if(atsw_customheaders[UnitName("player")][atsw_selectedskill]==nil) then
		atsw_customheaders[UnitName("player")][atsw_selectedskill]={};
	end
	local totalcount=table.getn(atsw_uncategorized);
	local offset=FauxScrollFrame_GetOffset(ATSWCSUListScrollFrame);
	for i=1,23,1 do
		local skillbutton=getglobal("ATSWCSSkill"..i);
		if(atsw_uncategorized[offset+i]) then		
			skillbutton:SetText(atsw_uncategorized[offset+i].name);
			skillbutton:Show();
			skillbutton.skillname=atsw_uncategorized[offset+i].name;
			local color=ATSWTypeColor[atsw_uncategorized[offset+i].type];
			if(color) then
				skillbutton:SetTextColor(color.r, color.g, color.b);
			end
		else
			skillbutton:Hide();
		end
	end
	offset=FauxScrollFrame_GetOffset(ATSWCSSListScrollFrame);
	local header=1;
	local skill=0;
	local i=1-offset;
	repeat
		local skillbutton=nil;
		local skillframe=nil;
		if(i>=1 and i<=17) then
			skillbutton=getglobal("ATSWCSCSkill"..i.."SkillButton");
			skillframe=getglobal("ATSWCSCSkill"..i);
		end
		if(atsw_customheaders[UnitName("player")][atsw_selectedskill][header] and skill==0) then
			if(i>=1 and i<=17) then
				skillbutton:SetText(atsw_customheaders[UnitName("player")][atsw_selectedskill][header].name);
				skillbutton:SetTextColor(ATSWTypeColor.header.r, ATSWTypeColor.header.g, ATSWTypeColor.header.b);
				skillframe.skillname=atsw_customheaders[UnitName("player")][atsw_selectedskill][header].name;
				skillbutton:GetParent().btype="header";
			end
			if(header==atsw_opencategory) then
				if(i>=1 and i<=17) then skillbutton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up"); end
				skill=1;
			else
				if(i>=1 and i<=17) then	skillbutton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up"); end
				header=header+1;
			end
			if(i>=1 and i<=17) then
				getglobal("ATSWCSCSkill"..i.."SkillButtonHighlight"):SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
				skillbutton:UnlockHighlight();
				skillframe:Show();
				skillbutton:Show();
				getglobal("ATSWCSCSkill"..i.."MoveUp"):Show();
				getglobal("ATSWCSCSkill"..i.."MoveDown"):Show();
				getglobal("ATSWCSCSkill"..i.."Delete"):Show();
			end
		elseif(atsw_opencategory==header) then
			if(atsw_customsorting[UnitName("player")][atsw_selectedskill] and atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][header].name]) then
				if(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][header].name][skill]) then
					if(i>=1 and i<=17) then
						skillbutton:SetText(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][header].name][skill].name);
						skillframe.skillname=atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][header].name][skill].name;
						skillbutton:SetTextColor(ATSWTypeColor[atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][header].name][skill].type].r, ATSWTypeColor[atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][header].name][skill].type].g, ATSWTypeColor[atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][header].name][skill].type].b);
						skillframe:Show();
						skillbutton:Show();
						skillbutton:SetNormalTexture("");
						getglobal("ATSWCSCSkill"..i.."MoveUp"):Show();
						getglobal("ATSWCSCSkill"..i.."MoveDown"):Show();
						getglobal("ATSWCSCSkill"..i.."Delete"):Show();
						getglobal("ATSWCSCSkill"..i.."SkillButtonHighlight"):SetTexture("");
						skillbutton:GetParent().btype="recipe";
					end
					skill=skill+1;
				else
					if(skill==1) then
						if(i>=1 and i<=17) then
							skillbutton:SetText(ATSWCS_NOTHINGINCATEGORY);
							skillframe.skillname=ATSWCS_NOTHINGINCATEGORY;
							skillbutton:SetTextColor(0.6, 0.6, 0.6);
							skillframe:Show();
							skillbutton:Show();
							skillbutton:SetNormalTexture("");
							getglobal("ATSWCSCSkill"..i.."SkillButtonHighlight"):SetTexture("");
							getglobal("ATSWCSCSkill"..i.."MoveUp"):Hide();
							getglobal("ATSWCSCSkill"..i.."MoveDown"):Hide();
							getglobal("ATSWCSCSkill"..i.."Delete"):Hide();
						end
					else
						i=i-1;
					end
					skill=0;
					header=header+1;
				end
			else
				if(skill==1) then
					if(i>=1 and i<=17) then
						skillbutton:SetText(ATSWCS_NOTHINGINCATEGORY);
						skillframe.skillname=ATSWCS_NOTHINGINCATEGORY;
						skillbutton:SetTextColor(0.6, 0.6, 0.6);
						skillframe:Show();
						skillbutton:Show();
						skillbutton:SetNormalTexture("");
						getglobal("ATSWCSCSkill"..i.."SkillButtonHighlight"):SetTexture("");
						getglobal("ATSWCSCSkill"..i.."MoveUp"):Hide();
						getglobal("ATSWCSCSkill"..i.."MoveDown"):Hide();
						getglobal("ATSWCSCSkill"..i.."Delete"):Hide();
					end
				else
					i=i-1;
				end
				skill=0;
				header=header+1;
			end
		else
			if(i>=1 and i<=17) then
				skillbutton:Show();
				skillframe:Hide();
				skillframe.skillname=nil;
			end
		end
		i=i+1;
	until(i>17);
	local totalcount2=0;
	if(atsw_customheaders[UnitName("player")][atsw_selectedskill]) then
		totalcount2=totalcount2+table.getn(atsw_customheaders[UnitName("player")][atsw_selectedskill]);
		if(atsw_opencategory~=0) then
			if(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][atsw_opencategory].name]) then
				totalcount2=totalcount2+table.getn(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][atsw_opencategory].name]);
			else
				totalcount2=totalcount2+1;
			end
		end
	end
	FauxScrollFrame_Update(ATSWCSUListScrollFrame, totalcount, 23, 16);
	FauxScrollFrame_Update(ATSWCSSListScrollFrame, totalcount2, 17, 16);
	ATSW_CreateSkillListing();
	ATSWFrame_Update();
end

function ATSWCS_UpdateUncategorizedList()
	atsw_uncategorized={};
	for i=1,table.getn(atsw_tradeskilllist),1 do
		if(ATSWCS_CheckIfCategorized(atsw_tradeskilllist[i].name)==false) then
			table.insert(atsw_uncategorized,{name=atsw_tradeskilllist[i].name, type=atsw_tradeskilllist[i].type}); 
		end
	end
	table.sort(atsw_uncategorized,ATSWCS_SortUncategorizedList);
end

function ATSWCS_SortUncategorizedList(i,j)
	return string.lower(i.name) < string.lower(j.name);
end

function ATSWCS_CheckIfCategorized(skillName)
	if(atsw_customsorting[UnitName("player")]) then
		if(atsw_customsorting[UnitName("player")][atsw_selectedskill]) then
			for i=1,table.getn(atsw_customheaders[UnitName("player")][atsw_selectedskill]),1 do
				if(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name]) then
					for k=1,table.getn(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name]),1 do
						if(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name][k].name==skillName) then
							return true;
						end
					end
				end
			end
		end
	end
	return false;
end

function ATSWCS_AddCategory(categoryName)
	for i=1,table.getn(atsw_customheaders[UnitName("player")][atsw_selectedskill]),1 do
		if(atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name==categoryName) then return; end
	end
	table.insert(atsw_customheaders[UnitName("player")][atsw_selectedskill],{name=categoryName, expanded=false});
	ATSWCS_UpdateSkillList();
end

function ATSWCS_MoveUp(skillName)
	for i=1,table.getn(atsw_customheaders[UnitName("player")][atsw_selectedskill]),1 do
		if(atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name==skillName) then
			if(i>1) then
				local buffer=atsw_customheaders[UnitName("player")][atsw_selectedskill][i-1];
				atsw_customheaders[UnitName("player")][atsw_selectedskill][i-1]=atsw_customheaders[UnitName("player")][atsw_selectedskill][i];
				atsw_customheaders[UnitName("player")][atsw_selectedskill][i]=buffer;
				break;
			end
		end
	end
	if(atsw_customsorting[UnitName("player")]) then
		if(atsw_customsorting[UnitName("player")][atsw_selectedskill]) then
			for i=1,table.getn(atsw_customheaders[UnitName("player")][atsw_selectedskill]),1 do
				if(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name]) then
					for k=1,table.getn(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name]),1 do
						if(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name][k].name==skillName) then
							if(k>1) then
								local buffer=atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name][k-1];
								atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name][k-1]=atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name][k]
								atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name][k]=buffer;
								break;
							end
						end
					end
				end
			end
		end
	end
	ATSWCS_UpdateSkillList();
end

function ATSWCS_MoveDown(skillName)
	for i=1,table.getn(atsw_customheaders[UnitName("player")][atsw_selectedskill]),1 do
		if(atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name==skillName) then
			if(i<table.getn(atsw_customheaders[UnitName("player")][atsw_selectedskill])) then
				local buffer=atsw_customheaders[UnitName("player")][atsw_selectedskill][i+1];
				atsw_customheaders[UnitName("player")][atsw_selectedskill][i+1]=atsw_customheaders[UnitName("player")][atsw_selectedskill][i];
				atsw_customheaders[UnitName("player")][atsw_selectedskill][i]=buffer;
				break;
			end
		end
	end
	if(atsw_customsorting[UnitName("player")]) then
		if(atsw_customsorting[UnitName("player")][atsw_selectedskill]) then
			for i=1,table.getn(atsw_customheaders[UnitName("player")][atsw_selectedskill]),1 do
				if(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name]) then
					for k=1,table.getn(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name]),1 do
						if(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name][k].name==skillName) then
							if(k<table.getn(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name])) then
								local buffer=atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name][k+1];
								atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name][k+1]=atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name][k]
								atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name][k]=buffer;
								break;
							end
						end
					end
				end
			end
		end
	end
	ATSWCS_UpdateSkillList();
end

function ATSWCS_Delete(skillName,onlySkill)
	if(this:GetParent().btype=="header" and onlySkill==nil) then
		for i=1,table.getn(atsw_customheaders[UnitName("player")][atsw_selectedskill]),1 do
			if(atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name==skillName) then
				if(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name]) then
					for j=table.getn(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name]),1,-1 do
						ATSWCS_Delete(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name][j].name,true);
					end
				end
				table.remove(atsw_customheaders[UnitName("player")][atsw_selectedskill],i);
				if(atsw_opencategory==i) then atsw_opencategory=0; end
			end
		end
	end
	if(atsw_customsorting[UnitName("player")]) then
		if(atsw_customsorting[UnitName("player")][atsw_selectedskill]) then
			for i=1,table.getn(atsw_customheaders[UnitName("player")][atsw_selectedskill]),1 do
				if(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name]) then
					for k=1,table.getn(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name]),1 do
						if(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name][k].name==skillName) then
							table.remove(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name],k);
							break;
						end
					end
				end
			end
		end
	end
	ATSWCS_UpdateUncategorizedList();
	ATSWCS_UpdateSkillList();
end

function ATSWCSCSkillButton_OnClick(skillName)
	if(this:GetParent().btype=="header") then
		for i=1,table.getn(atsw_customheaders[UnitName("player")][atsw_selectedskill]),1 do
			if(atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name==skillName) then
				if(atsw_opencategory==i) then
					atsw_opencategory=0;
				else
					atsw_opencategory=i;
				end
				ATSWCS_UpdateUncategorizedList();
				ATSWCS_UpdateSkillList();
				return;
			end
		end
	end
	if(atsw_customsorting[UnitName("player")]) then
		if(atsw_customsorting[UnitName("player")][atsw_selectedskill]) then
			for i=1,table.getn(atsw_customheaders[UnitName("player")][atsw_selectedskill]),1 do
				if(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name]) then
					for k=1,table.getn(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name]),1 do
						if(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name][k].name==skillName) then
							table.remove(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name],k);
							break;
						end
					end
				end
			end
		end
	end
	ATSWCS_UpdateUncategorizedList();
	ATSWCS_UpdateSkillList();
end

function ATSWCSSkillButton_OnClick(skillName)
	if(atsw_opencategory==0) then return; end
	for i=1,table.getn(atsw_uncategorized),1 do
		if(atsw_uncategorized[i].name==skillName) then
			if(atsw_customsorting[UnitName("player")][atsw_selectedskill]==nil) then atsw_customsorting[UnitName("player")][atsw_selectedskill]={}; end
			if(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][atsw_opencategory].name]==nil) then atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][atsw_opencategory].name]={}; end
			table.insert(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][atsw_opencategory].name],{name=skillName,type=atsw_uncategorized[i].type});
		end
	end
	ATSWCS_UpdateUncategorizedList();
	ATSWCS_UpdateSkillList();
end