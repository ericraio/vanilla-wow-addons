--wird beim laden ausgeführt
function wowon_OnLoad()
	--slash command
	SLASH_WoWonid1 = "/wowon"
	SLASH_WoWonid2 = "/wowonid"
	SlashCmdList["WoWonid"] = function(msg)
		wowon_cmd(msg)
	end
	
	wowon = {}
	wowon.debug = true
	wowon.ui_created = false
	
	-- tempräre datenbank des aktuellen spiels
	wowon.game = {};
	wowon.game.ingame = false;
	wowon.game.ballfrei = {}
	wowon.game.balle = {}
	wowon.game.feldfrei = {}
	wowon.game.felder = {}
	wowon.game.gfx = {}


	
end

--eventhandler
function wowon_OnEvent()

end

--slashcommand
function wowon_cmd(msg)
	
	if (wowon.ui_created == false) then
		wowon_new_game ()
		wowon_hf:Show()
	else
		if (wowon_hf:IsShown()) then
			wowon_exit_game ()
			wowon_hf:Hide()
		else
			wowon_new_game ()
			wowon_hf:Show()
		end
	end
end

function wowon_debug (x)
--x = debug text
	if (wowon.debug) then
		Sea.IO.banner(x)
	end
end

function wowon_UI_setup ()

	local x = wowon.game.feld.x
	local y = wowon.game.feld.y
	-- offset unten (bereich des balken) / ballfreiheit ist demnach x*(y-o)
	wowon.game.feld.o = 50
	
	-- offset des sf und pf zu hf
	local r = 10
	local o = 25
	local u = r/2
	local m = 10
	
	-- höhe von pf
	local hpf = 50

	-- grösse des hf_titel
	local h = 40
	local b = 150

	if (wowon.ui_created == false) then
		
		-- hauptframe (titel)
		CreateFrame("Frame", "wowon_hf")
		wowon_hf:EnableMouse(true)
		wowon_hf:SetMovable(true)
		wowon_hf:SetScript("OnMouseDown", function() if (arg1 == "LeftButton") then this:StartMoving() end end)
		wowon_hf:SetScript("OnMouseUp", function() if (arg1 == "LeftButton") then this:StopMovingOrSizing() end end)

		wowon_hf:CreateTexture("wowon_hf_textur", "BACKGROUND")
		wowon_hf_textur:SetTexture(0, 0, 0, 1)	
		wowon_hf:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = false, tileSize = 0, edgeSize = 25, insets = { left = 6, right = 6, top = 6, bottom = 6 }});

		wowon_hf:CreateFontString("wowon_hf_text")
		wowon_hf_text:SetFontObject(GameFontNormal)
		--wowon_hf_text:SetText("hf_text")
		wowon_hf_text:SetText("WoWonid")

		CreateFrame("Frame", "wowon_hf_rf")
		wowon_hf_rf:SetBackdrop({bgFile = "Interface/DialogFrame/UI-DialogBox-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = false, tileSize = 0, edgeSize = 25, insets = { left = 6, right = 6, top = 6, bottom = 6 }});
		
		CreateFrame("Frame", "wowon_sf")
		wowon_sf:EnableMouse(true)
		wowon_sf:SetScript("OnEnter", function() wowon_sf_maus_OnEnter() end)
		wowon_sf:SetScript("OnLeave", function() wowon_sf_maus_OnLeave() end)
		wowon_sf:SetScript("OnMouseDown", function() if (arg1 == "LeftButton") then wowon_sf_maus_OnClick() end end)
		wowon_sf:CreateTexture("wowon_sf_textur", "BACKGROUND")
		wowon_sf_textur:SetAllPoints(wowon_sf)
		wowon_sf_textur:SetTexture(0.2, 0.5, 1, 0.5)	-- muss noch besser bestimmt werden
		wowon_sf:CreateTexture("wowon_sf_balken", "ARTWORK")

		wowon_sf:CreateFontString("wowon_sf_text", "OVERLAY")
		wowon_sf_text:SetFont("Fonts\\FRIZQT__.TTF", 46);
		wowon_sf_text:SetText("sf_text")
		wowon_sf_text:SetShadowColor(0,0,0,1)
		wowon_sf_text:SetShadowOffset(4,-4)

		--struktur und frame-level
		wowon_hf:SetParent("UIParent")
		wowon_hf_rf:SetParent("wowon_hf")
		wowon_sf:SetParent("wowon_hf_rf")
	
		wowon_hf:SetFrameLevel(2)
		wowon_hf_rf:SetFrameLevel(1)
		wowon_sf:SetFrameLevel(3)
		wowon_pf:SetFrameLevel(4)
	
		wowon.ui_created = true	
	end


	-- hf setup
	wowon_hf:SetHeight(h)
    wowon_hf:SetWidth(b)
	wowon_hf:SetPoint("CENTER", 0, y/2)
	
	wowon_hf_text:SetPoint("CENTER", 0, 0)

	wowon_hf_textur:SetHeight(h-12)
    wowon_hf_textur:SetWidth(b-12)
    wowon_hf_textur:SetPoint("CENTER", 0, 0)

	wowon_hf_rf:SetHeight(y+o+hpf+u+m)
    wowon_hf_rf:SetWidth(x+2*r)
	wowon_hf_rf:SetPoint("TOP", "wowon_hf", 0, -15);

	wowon_sf:SetHeight(y)
    wowon_sf:SetWidth(x)
	wowon_sf:SetPoint("TOP", "wowon_hf_rf", "TOP", 0, -o)
	wowon_sf_text:SetPoint("CENTER", 0, 0)
	wowon_sf_text:Hide()

	wowon_pf:SetHeight(hpf)
    wowon_pf:SetWidth(x+r)
    wowon_pf:SetParent("wowon_hf")
	wowon_pf:SetPoint("TOP", "wowon_hf_rf", "TOP", 0, -m-o-y)
	
end

function wowon_new_game ()

	if (wowon.game.ingame == true) then
		wowon_exit_game ()
	end

	-- neuest game
	wowonid_set_lvl (999)
	wowon.game.ingame = true


end


-- spiel beenden, timer stoppen, felder/bälle wieder freigeben
function wowon_exit_game ()

	for i = 1, table.getn(wowon.game.balle) do
		if (wowon.game.ball[wowon.game.balle[i]].ss == 2) or (wowon.game.ball[wowon.game.balle[i]].ss == 4) then
			wowon_timer_ball (false, wowon.game.balle[i])
		end
		table.insert(wowon.game.ballfrei, wowon.game.balle[i])
	end
	wowon.game.balle = {}

	-- gxf effekte beenden
	table.foreach(wowon.game.gfx, wowon_UI_GXF_sf_stop_all)
	wowon.game.gfx = {}
	
	for i = 1, table.getn(wowon.game.felder) do
		table.insert(wowon.game.feldfrei, wowon.game.felder[i])
	end
	wowon.game.felder = {}
	
	-- balken timer
	wowon_timer_balken (false)
	
	wowon.game.ingame = false
	
end
