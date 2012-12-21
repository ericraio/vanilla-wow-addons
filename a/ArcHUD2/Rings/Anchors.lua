local module = ArcHUD:NewModule("Anchors")

function module:Initialize()
	-- Setup the frames we need
	self.Left = self:CreateRing(false, ArcHUDFrame)
	self.Right = self:CreateRing(false, ArcHUDFrame)

	self.Left:SetAlpha(0)

	self.Right:SetReversed(true)
	self.Right:SetAlpha(0)
end
