-----------------------
-- Get/Set functions --
-----------------------
local function GetAuctionPricesVersion()
	return AuctionPrices["version"]
end
local function SetAuctionPricesVersion(version)
	AuctionPrices["version"] = version
end
local function GetAHSnapshotVersion()
	return AHSnapshot["version"]
end
local function SetAHSnapshotVersion(version)
	AHSnapshot["version"] = version
end

---------------------
-- helperfunctions --
---------------------
local function ConvertCatStringToCatInt(array)
	local categories = {GetAuctionItemClasses()}

	for realm, realmArray in array do
		for itemKey, itemData in realmArray do
			for i = 1, table.getn(categories) do
				-- ignore old dataformat
				if (type(itemData) == "table") and
				    itemData["category"]       and
				    (itemData["category"] == categories[i]) then
					itemData["category"] = i
				   break
				end
			end
		end
	end
end

----------------------------
-- AuctionPrices Upgrades --
----------------------------
local function UpgradeAuctionPricesTo_1_0()
	-- convert the categoryvalues to numbers
	ConvertCatStringToCatInt(AuctionPrices)
	
	-- finally set new dataversion
	SetAuctionPricesVersion("1.0")
end
-- upgrades current AuctionPrices version to the next one
local function UpgradeAuctionPrices()
	local version = GetAuctionPricesVersion()

	-- dataversion <= 3.0.10
	if not version then
		UpgradeAuctionPricesTo_1_0()
	end
end

-------------------------
-- AHSnapshot Upgrades --
-------------------------
local function UpgradeAHSnapshotTo_1_0()
	-- convert the categoryvalues to numbers
	ConvertCatStringToCatInt(AHSnapshot)
	
	-- finally set new dataversion
	SetAHSnapshotVersion("1.0")
end
-- upgrades current AHSnapshot version to the next one
local function UpgradeAHSnapshot()
	local version = GetAHSnapshotVersion()

	-- dataversion <= 3.0.10
	if not version then
		UpgradeAHSnapshotTo_1_0()
	end
end

function Auctioneer_ConvertData()
	-- AuctionConfig
		-- no conversion yet
	-- AuctionPrices
		UpgradeAuctionPrices()
	-- AuctionBids
		-- no conversion yet
	-- AHSnapshot
		UpgradeAHSnapshot()
	-- AHSnapshotItemPrices
		-- no conversion yet
end
