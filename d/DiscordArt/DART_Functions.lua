function DART_Alpha(textureIndex, alpha)
	if (not alpha) then return; end
	if (not tonumber(alpha)) then return; end
	if (alpha < 0 or alpha > 1) then return; end
	if (not textureIndex) then return; end
	local texture = getglobal("DART_Texture_"..textureIndex.."_Texture");
	if (not texture) then return; end
	DART_Settings[DART_INDEX][textureIndex].alpha = alpha;
	if (not texture.fauxhidden) then
		texture:SetAlpha(alpha);
	end
end

function DART_Attach(textureIndex, attach, attachframe, attachpoint, attachto, xoffset, yoffset)
	if ((not textureIndex) or (not attach) or (not attachframe) or (not attachpoint) or (not attachto) or (not xoffset) or (not yoffset)) then return; end
	if (attachframe == "") then return; end
	local texture = getglobal("DART_Texture_"..textureIndex);
	if (not texture) then return; end
	if (not getglobal(attachframe)) then return; end
	if ((not tonumber(xoffset)) or (not tonumber(yoffset)) or (not tonumber(attach))) then return; end
	if (attach < 1 or attach > 4) then return; end
	local ap, at;
	for i=1, 9 do
		if (attachpoint == DART_ATTACH_POINTS[i]) then
			ap = i;
		end
		if (attachto == DART_ATTACH_POINTS[i]) then
			at = i;
		end
	end
	if ((not ap) or (not at)) then return; end
	DART_Settings[DART_INDEX][textureIndex].attachframe[attach] = attachframe;
	DART_Settings[DART_INDEX][textureIndex].attachpoint[attach] = ap;
	DART_Settings[DART_INDEX][textureIndex].attachto[attach] = at;
	DART_Settings[DART_INDEX][textureIndex].xoffset[attach] = xoffset;
	DART_Settings[DART_INDEX][textureIndex].yoffset[attach] = yoffset;
	texture:ClearAllPoints();
	for i=1,4 do
		if (DART_Settings[DART_INDEX][textureIndex].attachframe[i] and DART_Settings[DART_INDEX][textureIndex].attachframe[i] ~= "") then
			texture:SetPoint(DART_ATTACH_POINTS[DART_Settings[DART_INDEX][textureIndex].attachpoint[i]], DART_Settings[DART_INDEX][textureIndex].attachframe[i], DART_ATTACH_POINTS[DART_Settings[DART_INDEX][textureIndex].attachto[i]], DART_Settings[DART_INDEX][textureIndex].xoffset[i], DART_Settings[DART_INDEX][textureIndex].yoffset[i]);
		end
	end
end

function DART_BackgroundAlpha(textureIndex, a)
	if ((not textureIndex) or (not a)) then return; end
	local texture = getglobal("DART_Texture_"..textureIndex);
	if (not texture) then return; end
	if (not tonumber(a)) then return; end
	if (a < 0 or a > 1) then return; end
	DART_Settings[DART_INDEX][textureIndex].bgalpha = a;
	if (not DART_Settings[DART_INDEX][textureIndex].hidebg) then
		texture:SetBackdropColor(DART_Settings[DART_INDEX][textureIndex].bgcolor.r, DART_Settings[DART_INDEX][textureIndex].bgcolor.g, DART_Settings[DART_INDEX][textureIndex].bgcolor.b, a);
	end
end

function DART_BackgroundColor(textureIndex, r, g, b, a)
	if ((not textureIndex) or (not r) or (not g) or (not b)) then return; end
	local texture = getglobal("DART_Texture_"..textureIndex);
	if (not texture) then return; end
	if (not a) then
		a = DART_Settings[DART_INDEX][textureIndex].bgalpha;
	end
	if ((not tonumber(r)) or (not tonumber(g)) or (not tonumber(b)) or (not tonumber(a))) then return; end
	if (a < 0 or a > 1) then return; end
	if (r < 0 or r > 1) then return; end
	if (g < 0 or g > 1) then return; end
	if (b < 0 or b > 1) then return; end
	DART_Settings[DART_INDEX][textureIndex].bgcolor.r = r;
	DART_Settings[DART_INDEX][textureIndex].bgcolor.g = g;
	DART_Settings[DART_INDEX][textureIndex].bgcolor.b = b;
	DART_Settings[DART_INDEX][textureIndex].bgalpha = a;
	if (not DART_Settings[DART_INDEX][textureIndex].hidebg) then
		texture:SetBackdropColor(r, g, b, a);
	end
end

function DART_BorderAlpha(textureIndex, a)
	if ((not textureIndex) or (not a)) then return; end
	local texture = getglobal("DART_Texture_"..textureIndex);
	if (not texture) then return; end
	if (not tonumber(a)) then return; end
	if (a < 0 or a > 1) then return; end
	DART_Settings[DART_INDEX][textureIndex].borderalpha = a;
	if (not DART_Settings[DART_INDEX][textureIndex].hidebg) then
		texture:SetBackdropBorderColor(DART_Settings[DART_INDEX][textureIndex].bordercolor.r, DART_Settings[DART_INDEX][textureIndex].bordercolor.g, DART_Settings[DART_INDEX][textureIndex].bordercolor.b, a);
	end
end

function DART_BorderColor(textureIndex, r, g, b, a)
	if ((not textureIndex) or (not r) or (not g) or (not b)) then return; end
	local texture = getglobal("DART_Texture_"..textureIndex);
	if (not texture) then return; end
	if (not a) then
		a = DART_Settings[DART_INDEX][textureIndex].borderalpha;
	end
	if ((not tonumber(r)) or (not tonumber(g)) or (not tonumber(b)) or (not tonumber(a))) then return; end
	if (a < 0 or a > 1) then return; end
	if (r < 0 or r > 1) then return; end
	if (g < 0 or g > 1) then return; end
	if (b < 0 or b > 1) then return; end
	DART_Settings[DART_INDEX][textureIndex].bordercolor.r = r;
	DART_Settings[DART_INDEX][textureIndex].bordercolor.g = g;
	DART_Settings[DART_INDEX][textureIndex].bordercolor.b = b;
	DART_Settings[DART_INDEX][textureIndex].borderalpha = a;
	if (not DART_Settings[DART_INDEX][textureIndex].hidebg) then
		texture:SetBackdropBorderColor(r, g, b, a);
	end
end

function DART_Color(textureIndex, r, g, b, a)
	if ((not textureIndex) or (not r) or (not g) or (not b)) then return; end
	local texture = getglobal("DART_Texture_"..textureIndex.."_Texture");
	if (not texture) then return; end
	if (not a) then
		a = DART_Settings[DART_INDEX][textureIndex].alpha;
	end
	if ((not tonumber(r)) or (not tonumber(g)) or (not tonumber(b)) or (not tonumber(a))) then return; end
	if (a < 0 or a > 1) then return; end
	if (r < 0 or r > 1) then return; end
	if (g < 0 or g > 1) then return; end
	if (b < 0 or b > 1) then return; end
	DART_Settings[DART_INDEX][textureIndex].color.r = r;
	DART_Settings[DART_INDEX][textureIndex].color.g = g;
	DART_Settings[DART_INDEX][textureIndex].color.b = b;
	DART_Settings[DART_INDEX][textureIndex].alpha = a;
	texture:SetVertexColor(r, g, b);
	texture:SetAlpha(a);
end

function DART_FauxHide(textureIndex)
	local texture = getglobal("DART_Texture_"..textureIndex);
	if (texture.fauxhidden) then return; end
	texture.fauxhidden = true;
	texture:SetAlpha(0);
	texture:EnableMouse(false);
	texture:EnableMouseWheel(false);
end

function DART_FauxShow(textureIndex)
	local texture = getglobal("DART_Texture_"..textureIndex);
	if (not texture.fauxhidden) then return; end
	texture.fauxhidden = nil;
	texture:SetAlpha(1);
	texture:EnableMouse(1);
	texture:EnableMouseWheel(1);
	texture:SetBackdropColor(DART_Settings[DART_INDEX][textureIndex].bgcolor.r, DART_Settings[DART_INDEX][textureIndex].bgcolor.g, DART_Settings[DART_INDEX][textureIndex].bgcolor.b, DART_Settings[DART_INDEX][textureIndex].bgalpha);
	texture:SetBackdropBorderColor(DART_Settings[DART_INDEX][textureIndex].bordercolor.r, DART_Settings[DART_INDEX][textureIndex].bordercolor.g, DART_Settings[DART_INDEX][textureIndex].bordercolor.b, DART_Settings[DART_INDEX][textureIndex].borderalpha);
	getglobal("DART_Texture_"..textureIndex.."_Texture"):SetAlpha(DART_Settings[DART_INDEX][textureIndex].alpha);
	getglobal("DART_Texture_"..textureIndex.."_Texture"):SetBlendMode(DART_Settings[DART_INDEX][textureIndex].blendmode);
end

function DART_Height(textureIndex, height)
	if (not textureIndex) then return; end
	if (not height) then return; end
	if (not tonumber(height)) then return; end
	if (height <= 0) then return; end
	local texture = getglobal("DART_Texture_"..textureIndex);
	if (not texture) then return; end
	DART_Settings[DART_INDEX][textureIndex].height = height;
	texture:SetHeight(height);
end

function DART_Hide(textureIndex)
	if (not textureIndex) then return; end
	local texture = getglobal("DART_Texture_"..textureIndex);
	if (not texture) then return; end
	DART_Settings[DART_INDEX][textureIndex].hide = true;
	texture:Hide();
end

function DART_HighlightAlpha(textureIndex, alpha)
	if (not alpha) then return; end
	if (not tonumber(alpha)) then return; end
	if (alpha < 0 or alpha > 1) then return; end
	if (not textureIndex) then return; end
	local texture = getglobal("DART_Texture_"..textureIndex.."_Highlight");
	if (not texture) then return; end
	DART_Settings[DART_INDEX][textureIndex].highlightalpha = alpha;
	texture:SetAlpha(alpha);
end

function DART_HighlightColor(textureIndex, r, g, b, a)
	if ((not textureIndex) or (not r) or (not g) or (not b)) then return; end
	local texture = getglobal("DART_Texture_"..textureIndex.."_Highlight");
	if (not texture) then return; end
	if (not a) then
		a = DART_Settings[DART_INDEX][textureIndex].highlightalpha;
	end
	if ((not tonumber(r)) or (not tonumber(g)) or (not tonumber(b)) or (not tonumber(a))) then return; end
	if (a < 0 or a > 1) then return; end
	if (r < 0 or r > 1) then return; end
	if (g < 0 or g > 1) then return; end
	if (b < 0 or b > 1) then return; end
	DART_Settings[DART_INDEX][textureIndex].highlightcolor.r = r;
	DART_Settings[DART_INDEX][textureIndex].highlightcolor.g = g;
	DART_Settings[DART_INDEX][textureIndex].highlightcolor.b = b;
	DART_Settings[DART_INDEX][textureIndex].highlightalpha = a;
	texture:SetVertexColor(r, g, b);
	texture:SetAlpha(a);
end

function DART_MoveDown(textureIndex, attachIndex, amount)
	if ((not textureIndex) or (not attachIndex) or (not amount)) then return; end
	local texture = getglobal("DART_Texture_"..textureIndex);
	if (not texture) then return; end
	if ((not tonumber(attachIndex)) or (not tonumber(amount))) then return; end
	if (attachIndex < 1 or attachIndex > 4) then return; end
	DART_Settings[DART_INDEX][textureIndex].yoffset[attachIndex] = DART_Settings[DART_INDEX][textureIndex].yoffset[attachIndex] - amount;
	texture:ClearAllPoints();
	for i=1,4 do
		if (DART_Settings[DART_INDEX][textureIndex].attachframe[i] and DART_Settings[DART_INDEX][textureIndex].attachframe[i] ~= "") then
			texture:SetPoint(DART_ATTACH_POINTS[DART_Settings[DART_INDEX][textureIndex].attachpoint[i]], DART_Settings[DART_INDEX][textureIndex].attachframe[i], DART_ATTACH_POINTS[DART_Settings[DART_INDEX][textureIndex].attachto[i]], DART_Settings[DART_INDEX][textureIndex].xoffset[i], DART_Settings[DART_INDEX][textureIndex].yoffset[i]);
		end
	end
end

function DART_MoveLeft(textureIndex, attachIndex, amount)
	if ((not textureIndex) or (not attachIndex) or (not amount)) then return; end
	local texture = getglobal("DART_Texture_"..textureIndex);
	if (not texture) then return; end
	if ((not tonumber(attachIndex)) or (not tonumber(amount))) then return; end
	if (attachIndex < 1 or attachIndex > 4) then return; end
	DART_Settings[DART_INDEX][textureIndex].xoffset[attachIndex] = DART_Settings[DART_INDEX][textureIndex].xoffset[attachIndex] - amount;
	texture:ClearAllPoints();
	for i=1,4 do
		if (DART_Settings[DART_INDEX][textureIndex].attachframe[i] and DART_Settings[DART_INDEX][textureIndex].attachframe[i] ~= "") then
			texture:SetPoint(DART_ATTACH_POINTS[DART_Settings[DART_INDEX][textureIndex].attachpoint[i]], DART_Settings[DART_INDEX][textureIndex].attachframe[i], DART_ATTACH_POINTS[DART_Settings[DART_INDEX][textureIndex].attachto[i]], DART_Settings[DART_INDEX][textureIndex].xoffset[i], DART_Settings[DART_INDEX][textureIndex].yoffset[i]);
		end
	end
end

function DART_MoveRight(textureIndex, attachIndex, amount)
	if ((not textureIndex) or (not attachIndex) or (not amount)) then return; end
	local texture = getglobal("DART_Texture_"..textureIndex);
	if (not texture) then return; end
	if ((not tonumber(attachIndex)) or (not tonumber(amount))) then return; end
	if (attachIndex < 1 or attachIndex > 4) then return; end
	DART_Settings[DART_INDEX][textureIndex].xoffset[attachIndex] = DART_Settings[DART_INDEX][textureIndex].xoffset[attachIndex] + amount;
	texture:ClearAllPoints();
	for i=1,4 do
		if (DART_Settings[DART_INDEX][textureIndex].attachframe[i] and DART_Settings[DART_INDEX][textureIndex].attachframe[i] ~= "") then
			texture:SetPoint(DART_ATTACH_POINTS[DART_Settings[DART_INDEX][textureIndex].attachpoint[i]], DART_Settings[DART_INDEX][textureIndex].attachframe[i], DART_ATTACH_POINTS[DART_Settings[DART_INDEX][textureIndex].attachto[i]], DART_Settings[DART_INDEX][textureIndex].xoffset[i], DART_Settings[DART_INDEX][textureIndex].yoffset[i]);
		end
	end
end

function DART_MoveUp(textureIndex, attachIndex, amount)
	if ((not textureIndex) or (not attachIndex) or (not amount)) then return; end
	local texture = getglobal("DART_Texture_"..textureIndex);
	if (not texture) then return; end
	if ((not tonumber(attachIndex)) or (not tonumber(amount))) then return; end
	if (attachIndex < 1 or attachIndex > 4) then return; end
	DART_Settings[DART_INDEX][textureIndex].yoffset[attachIndex] = DART_Settings[DART_INDEX][textureIndex].yoffset[attachIndex] + amount;
	texture:ClearAllPoints();
	for i=1,4 do
		if (DART_Settings[DART_INDEX][textureIndex].attachframe[i] and DART_Settings[DART_INDEX][textureIndex].attachframe[i] ~= "") then
			texture:SetPoint(DART_ATTACH_POINTS[DART_Settings[DART_INDEX][textureIndex].attachpoint[i]], DART_Settings[DART_INDEX][textureIndex].attachframe[i], DART_ATTACH_POINTS[DART_Settings[DART_INDEX][textureIndex].attachto[i]], DART_Settings[DART_INDEX][textureIndex].xoffset[i], DART_Settings[DART_INDEX][textureIndex].yoffset[i]);
		end
	end
end

function DART_Padding(textureIndex, padding)
	if ((not textureIndex) or (not padding)) then return; end
	if (not tonumber(padding)) then return; end
	local textureFrame = "DART_Texture_"..textureIndex;
	local texture = getglobal("DART_Texture_"..textureIndex.."_Texture");
	if (not texture) then return; end
	DART_Settings[DART_INDEX][textureIndex].padding = padding;
	texture:ClearAllPoints();
	texture:SetPoint("TOPLEFT", textureFrame, "TOPLEFT", padding, -padding);
	texture:SetPoint("BOTTOMRIGHT", textureFrame, "BOTTOMRIGHT", -padding, padding);
	local texture = getglobal("DART_Texture_"..textureIndex.."_Highlight");
	texture:ClearAllPoints();
	texture:SetPoint("TOPLEFT", textureFrame, "TOPLEFT", padding, -padding);
	texture:SetPoint("BOTTOMRIGHT", textureFrame, "BOTTOMRIGHT", -padding, padding);
end

function DART_Scale(textureIndex, scale)
	if (not scale) then return; end
	if (not tonumber(scale)) then return; end
	if (scale < 0) then return; end
	if (not textureIndex) then return; end
	local texture = getglobal("DART_Texture_"..textureIndex);
	if (not texture) then return; end
	DART_Settings[DART_INDEX][textureIndex].scale = scale;
	texture:SetScale(scale);
	texture.scale = texture:GetScale();
end

function DART_Show(textureIndex)
	if (not textureIndex) then return; end
	local texture = getglobal("DART_Texture_"..textureIndex);
	if (not texture) then return; end
	DART_Settings[DART_INDEX][textureIndex].hide = nil;
	texture:Show();
end

function DART_StartFlashing(textureIndex)
	local texture = getglobal("DART_Texture_"..textureIndex);
	if (not texture) then return; end
	texture.flashing = true;
	texture.direction = nil;
	texture.flashtime = .5;
end

function DART_StatusBar(textureIndex, percent, dimension, direction, basex1, basex2, basey1, basey2)
	local x1, x2, y1, y2 = 0, 1, 0, 1;
	if (basex1) then x1 = basex1; end
	if (basex2) then x2 = basex2; end
	if (basey1) then y1 = basey1; end
	if (basey2) then y2 = basey2; end
	if (percent > 1) then percent = 1; end
	if (percent < 0) then percent = 0; end
	if (direction == 1) then
		x1 = x2 - percent * (x2 - x1);
	elseif (direction == 2) then
		y2 = y2 - (1 - percent) * (y2 - y1);
	elseif (direction == 3) then
		y1 = y2 - percent * (y2 - y1);
	else
		x2 = percent * (x2 - x1);
	end
	if (direction == 2 or direction == 3) then
		DART_Height(textureIndex, dimension * percent);
	else
		DART_Width(textureIndex, dimension * percent);
	end
	DART_Texture(textureIndex, DART_Settings[DART_INDEX][textureIndex].texture, {x1, x2, y1, y2});
end

function DART_StopFlashing(textureIndex)
	local texture = getglobal("DART_Texture_"..textureIndex);
	if (not texture) then return; end
	texture.flashing = nil;
	texture:SetAlpha(1);
end

function DART_Text(textureIndex, text)
	if (not textureIndex) then return; end
	local textbox = getglobal("DART_Texture_"..textureIndex.."_Text");
	if (not textbox) then return; end
	if (not text) then text = ""; end
	DART_Settings[DART_INDEX][textureIndex].text.text = text;
	textbox:SetText(text);
end

function DART_TextAlpha(textureIndex, a)
	if ((not textureIndex) or (not a)) then return; end
	local text = getglobal("DART_Texture_"..textureIndex.."_Text");
	if (not text) then return; end
	if (not tonumber(a)) then return; end
	if (a < 0 or a > 1) then return; end
	DART_Settings[DART_INDEX][textureIndex].text.alpha = a;
	text:SetAlpha(a);
end

function DART_TextColor(textureIndex, r, g, b, a)
	if ((not textureIndex) or (not r) or (not g) or (not b)) then return; end
	local text = getglobal("DART_Texture_"..textureIndex.."_Text");
	if (not text) then return; end
	if (not a) then
		a = DART_Settings[DART_INDEX][textureIndex].text.alpha;
	end
	if ((not tonumber(r)) or (not tonumber(g)) or (not tonumber(b)) or (not tonumber(a))) then return; end
	if (a < 0 or a > 1) then return; end
	if (r < 0 or r > 1) then return; end
	if (g < 0 or g > 1) then return; end
	if (b < 0 or b > 1) then return; end
	DART_Settings[DART_INDEX][textureIndex].text.color.r = r;
	DART_Settings[DART_INDEX][textureIndex].text.color.g = g;
	DART_Settings[DART_INDEX][textureIndex].text.color.b = b;
	DART_Settings[DART_INDEX][textureIndex].text.alpha = a;
	text:SetTextColor(r, g, b);
	text:SetAlpha(a);
end

function DART_TextFontSize(textureIndex, fontsize)
	if ((not textureIndex) or (not fontsize)) then return; end
	local text = getglobal("DART_Texture_"..textureIndex.."_Text");
	if (not text) then return; end
	if (not tonumber(fontsize)) then return; end
	if (fontsize <= 0) then return; end
	DART_Settings[DART_INDEX][textureIndex].text.fontsize = fontsize;
	text:SetTextHeight(fontsize);
	local texture = getglobal("DART_Texture_"..textureIndex);
	local scale = texture:GetScale();
	texture:SetScale(scale + .1);
	texture:SetScale(scale);
end

function DART_TextHeight(textureIndex, height)
	if ((not textureIndex) or (not height)) then return; end
	local text = getglobal("DART_Texture_"..textureIndex.."_Text");
	if (not text) then return; end
	if (not tonumber(height)) then return; end
	if (height <= 0) then return; end
	DART_Settings[DART_INDEX][textureIndex].text.height = height;
	text:SetHeight(height);
end

function DART_TextHide(textureIndex)
	if (not textureIndex) then return; end
	local text = getglobal("DART_Texture_"..textureIndex.."_Text");
	if (not text) then return; end
	DART_Settings[DART_INDEX][textureIndex].text.hide = true;
	text:Hide();
end

function DART_TextMoveDown(textureIndex, amount)
	if ((not textureIndex) or (not amount)) then return; end
	local texture = getglobal("DART_Texture_"..textureIndex);
	if (not texture) then return; end
	if (not tonumber(amount)) then return; end
	DART_Settings[DART_INDEX][textureIndex].text.yoffset = DART_Settings[DART_INDEX][textureIndex].text.yoffset - amount;
	local textbox = getglobal("DART_Texture_"..textureIndex.."_Text");
	textbox:ClearAllPoints();
	textbox:SetPoint(DART_ATTACH_POINTS[DART_Settings[DART_INDEX][textureIndex].text.attachpoint], texture:GetName(), DART_ATTACH_POINTS[DART_Settings[DART_INDEX][textureIndex].text.attachto], DART_Settings[DART_INDEX][textureIndex].text.xoffset, DART_Settings[DART_INDEX][textureIndex].text.yoffset);
end

function DART_TextMoveLeft(textureIndex, amount)
	if ((not textureIndex) or (not amount)) then return; end
	local texture = getglobal("DART_Texture_"..textureIndex);
	if (not texture) then return; end
	if (not tonumber(amount)) then return; end
	DART_Settings[DART_INDEX][textureIndex].text.xoffset = DART_Settings[DART_INDEX][textureIndex].text.xoffset - amount;
	local textbox = getglobal("DART_Texture_"..textureIndex.."_Text");
	textbox:ClearAllPoints();
	textbox:SetPoint(DART_ATTACH_POINTS[DART_Settings[DART_INDEX][textureIndex].text.attachpoint], texture:GetName(), DART_ATTACH_POINTS[DART_Settings[DART_INDEX][textureIndex].text.attachto], DART_Settings[DART_INDEX][textureIndex].text.xoffset, DART_Settings[DART_INDEX][textureIndex].text.yoffset);
end

function DART_TextMoveRight(textureIndex, amount)
	if ((not textureIndex) or (not amount)) then return; end
	local texture = getglobal("DART_Texture_"..textureIndex);
	if (not texture) then return; end
	if (not tonumber(amount)) then return; end
	DART_Settings[DART_INDEX][textureIndex].text.xoffset = DART_Settings[DART_INDEX][textureIndex].text.xoffset + amount;
	local textbox = getglobal("DART_Texture_"..textureIndex.."_Text");
	textbox:ClearAllPoints();
	textbox:SetPoint(DART_ATTACH_POINTS[DART_Settings[DART_INDEX][textureIndex].text.attachpoint], texture:GetName(), DART_ATTACH_POINTS[DART_Settings[DART_INDEX][textureIndex].text.attachto], DART_Settings[DART_INDEX][textureIndex].text.xoffset, DART_Settings[DART_INDEX][textureIndex].text.yoffset);
end

function DART_TextMoveUp(textureIndex, amount)
	if ((not textureIndex) or (not amount)) then return; end
	local texture = getglobal("DART_Texture_"..textureIndex);
	if (not texture) then return; end
	if (not tonumber(amount)) then return; end
	DART_Settings[DART_INDEX][textureIndex].text.yoffset = DART_Settings[DART_INDEX][textureIndex].text.yoffset + amount;
	local textbox = getglobal("DART_Texture_"..textureIndex.."_Text");
	textbox:ClearAllPoints();
	textbox:SetPoint(DART_ATTACH_POINTS[DART_Settings[DART_INDEX][textureIndex].text.attachpoint], texture:GetName(), DART_ATTACH_POINTS[DART_Settings[DART_INDEX][textureIndex].text.attachto], DART_Settings[DART_INDEX][textureIndex].text.xoffset, DART_Settings[DART_INDEX][textureIndex].text.yoffset);
end

function DART_TextShow(textureIndex)
	if (not textureIndex) then return; end
	local text = getglobal("DART_Texture_"..textureIndex.."_Text");
	if (not text) then return; end
	DART_Settings[DART_INDEX][textureIndex].text.hide = nil;
	text:Show();
end

function DART_TextWidth(textureIndex, width)
	if ((not textureIndex) or (not width)) then return; end
	local text = getglobal("DART_Texture_"..textureIndex.."_Text");
	if (not text) then return; end
	if (not tonumber(width)) then return; end
	if (width <= 0) then return; end
	DART_Settings[DART_INDEX][textureIndex].text.width = width;
	text:SetWidth(width);
end

function DART_Texture(textureIndex, file, coords)
	if (not textureIndex) then return; end
	if (not file) then return; end
	local x1, x2, y1, y2, URX, URY, LRX, LRY;
	if (coords) then
		x1 = coords[1];
		x2 = coords[2];
		y1 = coords[3];
		y2 = coords[4];
		URX = coords[5];
		URY = coords[6];
		LRX = coords[7];
		LRY = coords[8];
	else
		x1 = DART_Settings[DART_INDEX][textureIndex].coords[1];
		x2 = DART_Settings[DART_INDEX][textureIndex].coords[2];
		y1 = DART_Settings[DART_INDEX][textureIndex].coords[3];
		y2 = DART_Settings[DART_INDEX][textureIndex].coords[4];
		URX = DART_Settings[DART_INDEX][textureIndex].coords[5];
		URY = DART_Settings[DART_INDEX][textureIndex].coords[6];
		LRX = DART_Settings[DART_INDEX][textureIndex].coords[7];
		LRY = DART_Settings[DART_INDEX][textureIndex].coords[8];
	end
	if ((not x1) or (not x2) or (not y1) or (not y2)) then return; end
	local texture = getglobal("DART_Texture_"..textureIndex.."_Texture");
	if (not texture) then return; end
	DART_Settings[DART_INDEX][textureIndex].texture = file;
	DART_Settings[DART_INDEX][textureIndex].coords = { x1, x2, y1, y2, URX, URY, LRX, LRY };
	if (not texture:SetTexture(file)) and (not DART_Settings[DART_INDEX][textureIndex].hide) then
		if (not DART_Settings[DART_INDEX][textureIndex].hide and file ~= "" and file ~= nil) then
			DL_Error("You have entered an invalid filename for Texture "..textureIndex..". Make sure the file is in the right folder and you typed its name right.");
		end
	end
	if ((not URX) or (not URY) or (not LRX) or (not LRY)) then
		texture:SetTexCoord(x1, x2, y1, y2);
	else
		texture:SetTexCoord(x1, x2, y1, y2, URX, URY, LRX, LRY);
	end
end

function DART_Width(textureIndex, width)
	if (not textureIndex) then return; end
	if (not width) then return; end
	if (not tonumber(width)) then return; end
	if (width <= 0) then return; end
	local texture = getglobal("DART_Texture_"..textureIndex);
	if (not texture) then return; end
	DART_Settings[DART_INDEX][textureIndex].width = width;
	texture:SetWidth(width);
end