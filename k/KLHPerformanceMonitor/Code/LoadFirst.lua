
--[[
KMT_LoadFirst.lua

Make sure this file is the first one loaded. i.e. put it at the top of the list of files in the mod's .toc file.

The top of your other .lua files should then have
	local mod = thismod
	local me = { }
	mod.mymodulename = me

]]--

klhpm = { }
thismod = klhpm