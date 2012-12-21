-- Version : Simplified Chinese
-- Maintained by Firebroo
-- Last Update : 12/13/2005

if (GetLocale() == "zhCN") then
	-- "Bonus" inventory types
	-- WARNING: these lines must match the text displayed by the client exactly.
	-- Can't use arbitrary phrases. Edit and translate with care.
	EQUIPCOMPARE_INVTYPE_WAND = "魔杖";
	EQUIPCOMPARE_INVTYPE_GUN = "枪械";
	EQUIPCOMPARE_INVTYPE_GUNPROJECTILE = "弹药";
	EQUIPCOMPARE_INVTYPE_BOWPROJECTILE = "弹药";
	EQUIPCOMPARE_INVTYPE_CROSSBOW = "弩";
	EQUIPCOMPARE_INVTYPE_THROWN = "投掷武器";

	-- Usage text
	EQUIPCOMPARE_USAGE_TEXT = { "EquipCompare "..EQUIPCOMPARE_VERSIONID.." 使用方法 :",
								"当鼠标在物品上悬停时显示该物品和你所装备同类物品的信息比较.",
								"命令 :",
								"/eqc 	       - 切换装备比较功能的开启或关闭状态",
								"/eqc [on|off] - 开启或关闭装备比较功能",
								"/eqc control  - 开启或关闭 Ctrl 键模式(摁住 Ctrl 键进行装备比较)",
							  	"/eqc cv       - 开启或关闭 CharactersViewer 的装备比较功能",
							  	"/eqc alt      - 开启或关闭 CharactersViewer 装备比较的 Alt 键模式(摁住 Alt 键进行装备比较)",
								"/eqc shift    - 切换比较信息提示框位置自动修正功能开/关(自动修正与主信息提示框的的底部位置对应)",
								"/eqc help     - 本帮助信息",
								"(你可以使用 /equipcompare 命令替代 /eqc 执行)" };

	-- Feedback text
	EQUIPCOMPARE_HELPTIP = "(执行 /equipcompare help 或 /eqc help 以获得帮助信息)";
	EQUIPCOMPARE_TOGGLE_ON = "装备比较功能开启";
	EQUIPCOMPARE_TOGGLE_OFF = "装备比较功能关闭";
	EQUIPCOMPARE_TOGGLECONTROL_ON = "Ctrl 键模式开启";
	EQUIPCOMPARE_TOGGLECONTROL_OFF = "Ctrl 键模式关闭";
	EQUIPCOMPARE_TOGGLECV_ON = "CharactersViewer 装备比较功能开启";
	EQUIPCOMPARE_TOGGLECV_OFF = "CharactersViewer 装备比较功能关闭";
	EQUIPCOMPARE_TOGGLEALT_ON = "CharactersViewer 装备比较的 Alt 键模式开启";
	EQUIPCOMPARE_TOGGLEALT_OFF = "CharactersViewer 装备比较的 Alt 键模式关闭";
	EQUIPCOMPARE_SHIFTUP_ON = "装备比较插件将自动修正信息提示框位置";
	EQUIPCOMPARE_SHIFTUP_OFF = "装备比较插件将不再自动修正信息提示框位置";
	
	-- Cosmos configuration texts
	EQUIPCOMPARE_COSMOS_SECTION = "装备比较";
	EQUIPCOMPARE_COSMOS_SECTION_INFO = "装备比较选项.";
	EQUIPCOMPARE_COSMOS_HEADER = "装备比较 "..EQUIPCOMPARE_VERSIONID;
	EQUIPCOMPARE_COSMOS_HEADER_INFO = "装备比较选项.";
	EQUIPCOMPARE_COSMOS_ENABLE = "开启装备比较功能";
	EQUIPCOMPARE_COSMOS_ENABLE_INFO = "开启后，在鼠标悬停在物品上时将提供该物品与你当前装备物品的比较信息.";
	EQUIPCOMPARE_COSMOS_CONTROLMODE = "开启装备比较功能的 Ctrl 键模式";
	EQUIPCOMPARE_COSMOS_CONTROLMODE_INFO = "开启后, 只有当你摁住 Ctrl 键时才会显示装备比较信息.";
	EQUIPCOMPARE_COSMOS_CVMODE = "为 CharactersViewer 开启装备比较功能";
	EQUIPCOMPARE_COSMOS_CVMODE_INFO = "开启之后，装备比较功能会将物品与在 CharactersViewer 中选择的装备进行 "..
                                                                                               "比较，而不是当前角色身上的同类装备.";
	EQUIPCOMPARE_COSMOS_ALTMODE = "为 CharactersViewer 开启装备比较功能的 Alt 键模式";
	EQUIPCOMPARE_COSMOS_ALTMODE_INFO = "开启之后, 只有在你摁住 Alt 键时才会进行物品与 CharactersViewer 中所 "..
                                                                                               "选装备的比较.";
	EQUIPCOMPARE_COSMOS_SHIFTUP = "在需要时提升比较信息提示框位置"
	EQUIPCOMPARE_COSMOS_SHIFTUP_INFO = "开启之后, 当比较信息提示框的底部低于主提示框的底部时, 将会自动提升比 "..
                                                                                                "较信息提示框的位置.";
	EQUIPCOMPARE_COSMOS_SLASH_DESC = "设定装备比较功能的开启或关闭. 执行 /equipcompare help 以获得详细的帮助信息."

	-- Misc labels
	EQUIPCOMPARE_EQUIPPED_LABEL = "您目前的装备";
	EQUIPCOMPARE_GREETING = "装备比较插件 "..EQUIPCOMPARE_VERSIONID.." 已载入.";

end
