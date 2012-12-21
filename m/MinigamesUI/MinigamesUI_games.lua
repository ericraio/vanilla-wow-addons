--namesliste der minigames (in übersetzter form)
function mgames_minigames()
	local minigamesliste = {
		"WoWonid",
		"Sweep",
		"Goblin Minesweeper",
		"Tetris",
		"Solitaire",
		"Sudoku",
		"Gems",
		"MiniGames Multiplayer (Cosmos)",
	}
	mgames_minigamesliste = {}
	for i=1, table.getn(minigamesliste) do
		if (mgames_minigames_addonloadedliste[i]) then
	  		table.insert(mgames_minigamesliste, minigamesliste[i])
	  	else
	  		table.insert(mgames_minigamesliste, "|cFFFF0000"..minigamesliste[i].."|r")
		end
	end
end

--addon-namesliste der minigames (programmname der addons)
function mgames_minigames_addon()
	mgames_minigames_addonliste = {
		"WoWonid",
		"Sweep",
		"Minesweeper",
		"Tetris",
		"Solitaire",
		"Sudoku",
		"Gems",
		"MiniGames",
	}
end

function mgames_game_Go()
	if (mgames_minigames_addonloadedliste[MinigamesUI.game]) then
		if (MinigamesUI.game==1) then
			wowon_cmd(msg)
		elseif (MinigamesUI.game==2) then
			Sweep_SlashCommand("")
		elseif (MinigamesUI.game==3) then
			Minesweeper_SlashHandler("")
		elseif (MinigamesUI.game==4) then
			Tetris_SlashCommand("")
		elseif (MinigamesUI.game==5) then
			Solitaire_SlashHandler("")
		elseif (MinigamesUI.game==6) then
			Sudoku_SlashCommand("")
		elseif (MinigamesUI.game==7) then
			Gems_SlashCommand("")
		else
			ShowUIPanel(GamesListFrame)
		end
	end
end

function mgames_credit_text()

	local credits = {
	
		[1] = { -- wowonid
		"0.3", -- version
		"Rewad", -- autor
		"/wowon", -- slashcommand
		"Timex", -- dependencies
		"A Arcanoid Clone for WoW", -- info
		},

		[2] = { --sweep
		"1.0", -- version
		"Vallerius", -- autor
		"/sweep", -- slashcommand
		"none", -- dependencies
		"Simple Mineswweper Clone", -- info
		},

		[3] = { -- goblin minesweeper
		"1.0", -- version
		"Necrophob", -- autor
		"/minesweeper", -- slashcommand
		"none", -- dependencies
		"Minesweeper Clone with Goblin feeling", -- info
		},

		[4] = { -- tetris
		"1.2", -- version
		"Rewad", -- autor
		"/tetris", -- slashcommand
		"Timex", -- dependencies
		"Nice Tetris Clone with sound and music", -- info
		},

		[5] = { -- solitar
		"1.2", -- version
		"Necrophob", -- autor
		"/sol", -- slashcommand
		"none", -- dependencies
		"The classic Solitaire card-game", -- info
		},

		[6] = { -- sudoku
		"1.2", -- version
		"Fricks", -- autor
		"/sudo", -- slashcommand
		"none", -- dependencies
		"Sudoku for WoW, learn mathematics ;)", -- info
		},

		[7] = { -- gems
		"1.6", -- version
		"Vallerius", -- autor
		"/gems", -- slashcommand
		"none", -- dependencies
		"The Gems minigame from EQ", -- info
		},
		
		[8] = { -- cosmos minigames
		"none", -- version
		"www.cosmosui.org", -- autor
		"none", -- slashcommand
		"Chronos, Sea", -- dependencies
		"The Cosmos multiplayer minigames\nTicTacToe, Chess and more ", -- info
		},
	
	}
	local e = "\n"
	local a = MinigamesUI.game
	local load = "|cFFFF0000Note: Addon not active|r"..e
	if (mgames_minigames_addonloadedliste[a]) then	
		load = e
	end
		
	return e..mgames_minigamesliste[a]..e..load..e.."Version: "..credits[a][1]..e.."Author: "..credits[a][2]..e.."SlashCommand: "..credits[a][3]..e.."Dependencies: "..credits[a][4]..e..e.."About the game:"..e..credits[a][5]

end
