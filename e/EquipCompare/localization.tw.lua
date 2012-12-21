-- Version : Traditional Chinese
-- Submitted by arith
-- Last Update : 17/08/2006

if (GetLocale() == "zhTW") then
	-- "Bonus" inventory types
	-- WARNING: these lines must match the text displayed by the client exactly.
	-- Can't use arbitrary phrases. Edit and translate with care.
	EQUIPCOMPARE_INVTYPE_WAND = "魔杖";
	EQUIPCOMPARE_INVTYPE_GUN = "槍械";
	EQUIPCOMPARE_INVTYPE_GUNPROJECTILE = "彈藥";
	EQUIPCOMPARE_INVTYPE_BOWPROJECTILE = "箭";
	EQUIPCOMPARE_INVTYPE_CROSSBOW = "弩";
	EQUIPCOMPARE_INVTYPE_THROWN = "投擲武器";

	-- Usage text
	EQUIPCOMPARE_USAGE_TEXT = { "EquipCompare "..EQUIPCOMPARE_VERSIONID.." 使用方法:",
							  	"將滑鼠移到物品上以跟你身上所裝備的同類物品做比較.",
							  	"命令列表:",
							  	"/eqc          - 切換裝備比較功能的開啟/關閉",
							  	"/eqc [on|off] - 開啟/關閉裝備比較功能",
							  	"/eqc control  - 開啟/關閉 Ctrl 鍵模式",
							  	"/eqc cv       - 開啟/關閉與 CharactersViewer 的功能整合",
						  		"/eqc alt      - 開啟/關閉 Alt 鍵模式",
								"/eqc shift    - 切換提示訊息的位置自動修正功能",
							  	"/eqc help     - 這個輔助訊息",
							  	"(你也可以用 /equipcompare 來取代 /eqc 的命令)" }

	-- Feedback text
	EQUIPCOMPARE_HELPTIP = "(輸入 /equipcompare help 以取得語法說明)";
	EQUIPCOMPARE_TOGGLE_ON = "EquipCompare 現在被啟動了.";
	EQUIPCOMPARE_TOGGLE_OFF = "EquipCompare 現在被關閉了.";
	EQUIPCOMPARE_TOGGLECONTROL_ON = "EquipCompare Ctrl 模式已啟動.";
	EQUIPCOMPARE_TOGGLECONTROL_OFF = "EquipCompare Ctrl 模式已關閉.";
	EQUIPCOMPARE_TOGGLECV_ON = "EquipCompare 與 CharactersViewer 整合的功能已啟動.";
	EQUIPCOMPARE_TOGGLECV_OFF = "EquipCompare 與 CharactersViewer 整合的功能已關閉.";
	EQUIPCOMPARE_TOGGLEALT_ON = "EquipCompare Alt 模式已啟動.";
	EQUIPCOMPARE_TOGGLEALT_OFF = "EquipCompare Alt 模式已關閉.";
	EQUIPCOMPARE_SHIFTUP_ON = "EquipCompare 將自動修正訊息提示框位置.";
	EQUIPCOMPARE_SHIFTUP_OFF = "EquipCompare 將不會自動修正訊息提示框位置.";

	-- Cosmos configuration texts
	EQUIPCOMPARE_COSMOS_SECTION = "EquipCompare";
	EQUIPCOMPARE_COSMOS_SECTION_INFO = "裝備比較提示訊息選項.";
	EQUIPCOMPARE_COSMOS_HEADER = "EquipCompare "..EQUIPCOMPARE_VERSIONID;
	EQUIPCOMPARE_COSMOS_HEADER_INFO = "裝備比較提示訊息選項.";
	EQUIPCOMPARE_COSMOS_ENABLE = "啟用裝備比較提示訊息";
	EQUIPCOMPARE_COSMOS_ENABLE_INFO = "啟用這個選項後，當你滑鼠移動到物品上方時，該物品與你身上所裝備的相對應物品的比較資訊將會被顯示 ";

	EQUIPCOMPARE_COSMOS_CONTROLMODE = "啟用 Ctrl 鍵模式";
	EQUIPCOMPARE_COSMOS_CONTROLMODE_INFO = "只有當你按下 Ctrl 鍵時，裝備比較的功能才會生效";

	EQUIPCOMPARE_COSMOS_CVMODE = "啟用與 CharactersViewer 的整合功能 (若可取得的話)";
	EQUIPCOMPARE_COSMOS_CVMODE_INFO = "若啟用的話，CharacterViewer 所選擇的角色將會拿來跟當前的物品做比較";

	EQUIPCOMPARE_COSMOS_ALTMODE = "為 CharactersViewer 啟用 Alt 鍵模式";
	EQUIPCOMPARE_COSMOS_ALTMODE_INFO = "只有當你按下 Alt 鍵時，CharacterViewer 所選擇的角色才會與當前的物品做比較";

	EQUIPCOMPARE_COSMOS_SHIFTUP = "自動調整提示訊息位置";
	EQUIPCOMPARE_COSMOS_SHIFTUP_INFO = "啟動後, 若比較的訊息過長，提示訊息的位置將會自動被調整";

	EQUIPCOMPARE_COSMOS_SLASH_DESC = "讓你開啟/關閉 EquipCompare. 輸入 /equipcompare help 觀看使用說明."

	-- Misc labels
	EQUIPCOMPARE_EQUIPPED_LABEL = "當前裝備";
	EQUIPCOMPARE_GREETING = "EquipCompare "..EQUIPCOMPARE_VERSIONID.." 已載入.";

end
