-- Raid zones
CT_RABOSS_LOCATIONS_NAXXRAMAS = "Naxxramas";
CT_RABOSS_LOCATIONS_AHNQIRAJTEMPLE = "Ahn'Qiraj Temple";
CT_RABOSS_LOCATIONS_AHNQIRAJRUINS = "Ahn'Qiraj Ruins";
CT_RABOSS_LOCATIONS_MOLTENCORE = "Molten Core";
CT_RABOSS_LOCATIONS_BLACKWINGSLAIR = "Blackwing's Lair";
CT_RABOSS_LOCATIONS_ONYXIASLAIR = "Onyxia's Lair";
CT_RABOSS_LOCATIONS_ZULGURUB = "Zul'Gurub";
CT_RABOSS_LOCATIONS_OUTDOOR = "Outdoor";
CT_RABOSS_LOCATIONS_OTHER = "Other";

-- Raid zones (as they appear in minimap)
CT_RABOSS_MINIMAPLOC_NAXXRAMAS = "Naxxramas";
CT_RABOSS_MINIMAPLOC_AHNQIRAJTEMPLE = "Ahn'Qiraj";
CT_RABOSS_MINIMAPLOC_AHNQIRAJRUINS = "Ruins of Ahn'Qiraj";
CT_RABOSS_MINIMAPLOC_MOLTENCORE = "Molten Core";
CT_RABOSS_MINIMAPLOC_BLACKWINGSLAIR = "Blackwing Lair";
CT_RABOSS_MINIMAPLOC_ONYXIASLAIR = "Onyxia's Lair";
CT_RABOSS_MINIMAPLOC_ZULGURUB = "Zul'Gurub";
CT_RABOSS_MINIMAPLOC_OUTDOOR = "Outdoor";
CT_RABOSS_MINIMAPLOC_OTHER = "Other";

-- Common strings
CT_RABOSS_REQ_LEADER_OR_PROM 	= "|c00FF0000Requires promoted or leader status.|r";
CT_RABOSS_ANNOUNCE				= "Announce to raid";
CT_RABOSS_ANNOUNCE_INFO			= "Announces the alert to the whole raid. ";

if ( GetLocale() == "deDE" ) then
	-- Raid zones
	CT_RABOSS_LOCATIONS_MOLTENCORE 		= "Geschmolzener Kern";
	CT_RABOSS_LOCATIONS_BLACKWINGSLAIR 		= "Pechschwingenhort";
	CT_RABOSS_LOCATIONS_ONYXIASLAIR 		= "Onyxias Hort";
	CT_RABOSS_LOCATIONS_ZULGURUB 		= "Zul'Gurub";
	CT_RABOSS_LOCATIONS_OUTDOOR 	= "Wildnis";
	CT_RABOSS_LOCATIONS_OTHER 	= "Sonstiges";
	
	-- Raidzones
	CT_RABOSS_MINIMAPLOC_MOLTENCORE 		= "Geschmolzener Kern";
	CT_RABOSS_MINIMAPLOC_BLACKWINGSLAIR 		= "Pechschwingenhort";
	CT_RABOSS_MINIMAPLOC_ONYXIASLAIR 		= "Onyxias Hort";
	CT_RABOSS_MINIMAPLOC_ZULGURUB 		= "Zul'Gurub";
	CT_RABOSS_MINIMAPLOC_OUTDOOR 	= "Wildnis";
	CT_RABOSS_MINIMAPLOC_OTHER 	= "Sonstiges";

	-- Common strings
	CT_RABOSS_REQ_LEADER_OR_PROM 	= "|c00FF0000Ben\195\182tigt Leiter oder bef\195\182rdert Status.|r";
	CT_RABOSS_ANNOUNCE				= "Schlachtgruppe melden";
	CT_RABOSS_ANNOUNCE_INFO			= "Meldet den Alarm der ganzen Schlachtgruppe. ";
end