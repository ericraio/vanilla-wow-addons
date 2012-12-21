--Needs to be on top of all Map Packs in case IMBA hasn't loaded its default map images yet
if not IMBA_MapImages then
	IMBA_MapImages={}
end

if not IMBA_MapZones then
	IMBA_MapZones={}
end

--Naxx Boss Maps Included With IMBA
tinsert(IMBA_MapZones,IMBA_LOCATIONS_NAXX);
tinsert(IMBA_MapImages,{zone=IMBA_LOCATIONS_NAXX;name="Anub'Rekhan";image="Interface\\AddOns\\IMBA\\textures\\MapImages\\anub"})
tinsert(IMBA_MapImages,{zone=IMBA_LOCATIONS_NAXX;name="Four Horsemen";image="Interface\\AddOns\\IMBA\\textures\\MapImages\\4H"})
tinsert(IMBA_MapImages,{zone=IMBA_LOCATIONS_NAXX;name="Gluth";image="Interface\\AddOns\\IMBA\\textures\\MapImages\\gluth"})
tinsert(IMBA_MapImages,{zone=IMBA_LOCATIONS_NAXX;name="Gothik the Harvester";image="Interface\\AddOns\\IMBA\\textures\\MapImages\\gothik"})
tinsert(IMBA_MapImages,{zone=IMBA_LOCATIONS_NAXX;name="Grand Widow Faerlina";image="Interface\\AddOns\\IMBA\\textures\\MapImages\\faerlina"})
tinsert(IMBA_MapImages,{zone=IMBA_LOCATIONS_NAXX;name="Heigan the Unclean";image="Interface\\AddOns\\IMBA\\textures\\MapImages\\heigan"})
tinsert(IMBA_MapImages,{zone=IMBA_LOCATIONS_NAXX;name="Kel'Thuzad";image="Interface\\AddOns\\IMBA\\textures\\MapImages\\kelthuzad"})
tinsert(IMBA_MapImages,{zone=IMBA_LOCATIONS_NAXX;name="Instructor Razuvious";image="Interface\\AddOns\\IMBA\\textures\\MapImages\\razuvious"})
tinsert(IMBA_MapImages,{zone=IMBA_LOCATIONS_NAXX;name="Maexxna";image="Interface\\AddOns\\IMBA\\textures\\MapImages\\maexxna"})
tinsert(IMBA_MapImages,{zone=IMBA_LOCATIONS_NAXX;name="Noth the Plaguebringer";image="Interface\\AddOns\\IMBA\\textures\\MapImages\\noth"})
tinsert(IMBA_MapImages,{zone=IMBA_LOCATIONS_NAXX;name="Sapphiron";image="Interface\\AddOns\\IMBA\\textures\\MapImages\\sapphiron"})

