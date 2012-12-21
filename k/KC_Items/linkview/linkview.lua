local locals = KC_ITEMS_LOCALS.modules.linkview

KC_Linkview = KC_ItemsModule:new({
	type		 = "linkview",
	name		 = locals.name,
	desc		 = locals.description,
	cmdOptions	 = locals.chat,
	dependencies = {"common"},
	dataPath	 = {"linkview"},
	optPath		 = {"linkview", "options"},
})

KC_Items:Register(KC_Linkview)

function KC_Linkview:Enable() end