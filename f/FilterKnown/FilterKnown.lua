--[[

FilterKnown
    By Robert Jenkins (Merrem@Perenolde)
  
  Colors "Already known" items blue in the auction house.

]]

FILTERKNOWN_VERSION = "1.03";

AlreadyKnown_ORIG_AuctionFrameBrowse_Update = nil;

function FilterKnown_Update()

	-- Do original update.
	if ( AlreadyKnown_ORIG_AuctionFrameBrowse_Update ) then
		AlreadyKnown_ORIG_AuctionFrameBrowse_Update();
	end

	local offset = FauxScrollFrame_GetOffset(BrowseScrollFrame);
	local index, x, i;
	local info, num_lines;

	for i=1, NUM_BROWSE_TO_DISPLAY do
		index = offset + i;

		FilterKnownTooltip:SetAuctionItem("list", index);

		info = "";
		num_lines = FilterKnownTooltip:NumLines();

		-- Check at most 4 lines.
		if num_lines > 4 then
			num_lines = 4;
		end

		for x=2, num_lines do
			info = info .. "\n" .. getglobal("FilterKnownTooltipTextLeft" .. x):GetText(); 
		end

		if info ~= "" and string.find(info, ITEM_SPELL_KNOWN) then
			-- Set color of icon to blue to make it easy to see that you already know it.
			iconTexture = getglobal("BrowseButton"..i.."ItemIconTexture");
			iconTexture:SetVertexColor(0.1, 0.1, 1.0);
		end
	end
end

function FilterKnown_OnLoad()
	AlreadyKnown_ORIG_AuctionFrameBrowse_Update = AuctionFrameBrowse_Update;
	AuctionFrameBrowse_Update = FilterKnown_Update;
end
