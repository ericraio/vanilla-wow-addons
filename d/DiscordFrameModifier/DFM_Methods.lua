-- OPTION TYPES
-- 1 - editbox
-- 2 - drop-menu
-- 3 - scroll-menu
-- 4 - slider
-- 5 - checkbox
-- 6 - color
-- 7 - plus/minus box

DFM_METHODS_LIST = {
	{ method="SetParent",
		help = "Sets parent frame of this frame.  It will inherit alpha, scale, and visible/hidden settings from that frame.",
		options={ {name="Parent", option=1, default="UIParent"} },
		detection="GetParent" },
	{ method="SetFrameStrata",
		help = "Sets strata of the frame.  Frames in higher stratas display above those in lower stratas.",
		options={ {name="FrameStrata", option=2, table="DL_FRAMESTRATAS", default="LOW"} },
		detection="GetFrameStrata" },
	{ method="SetFrameLevel",
		help = "Sets the level of the frame within the strata.  Frames with a higher level displays above those with a lower level.  However, FontString and Texture display are unaffected by level.",
		options={ {name="FrameLevel", option=7, default=1} },
		detection="GetFrameLevel" },
	{ method="SetHeight",
		options={ {name="Height", option=4, default=100, min=1, max=300, minlock=true} },
		detection="GetHeight" },
	{ method="SetWidth",
		options={ {name="Width", option=4, default=100, min=1, max=300, minlock=true} },
		detection="GetWidth" },
	{ method="SetScale",
		options={ {name="Scale", option=4, default=1, min=1, max=200, scale=100, minlock=true, maxlock=true} },
		detection="GetScale" },
	{ method="SetTexture",
		options={ {name="Texture", option=3, table="DL_TEXTURES_LIST"} },
		detection="GetTexture" },
	{ method="SetStatusBarTexture",
		options={ {name="StatusBarTexture", option=3, table="DL_TEXTURES_LIST"} },
		detection = "GetStatusBarTexture"
	},
	{ method="SetCheckedTexture",
		options={ {name="CheckedTexture", option=3, table="DL_TEXTURES_LIST"} } },
	{ method="SetDisabledCheckedTexture",
		options={ {name="DisabledCheckedTexture", option=3, table="DL_TEXTURES_LIST"} } },
	{ method="SetDisabledTexture",
		options={ {name="DisabledTexture", option=3, table="DL_TEXTURES_LIST"} } },
	{ method="SetHighlightTexture",
		options={ {name="HighlightTexture", option=3, table="DL_TEXTURES_LIST"} } },
	{ method="SetNormalTexture",
		options={ {name="NormalTexture", option=3, table="DL_TEXTURES_LIST"} } },
	{ method="SetPushedTexture",
		options={ {name="PushedTexture", option=3, table="DL_TEXTURES_LIST"} } },
	{ method="SetTexCoord",
		help = "Specifies a subsection of the texture file to use.",
		options={
			{name="UpperLeftX", option=7, default=0, step=.1, step2=.01, step3=.001},
			{name="UpperLeftY", option=7, default=0, step=.1, step2=.01, step3=.001},
			{name="LowerLeftX", option=7, default=0, step=.1, step2=.01, step3=.001},
			{name="LowerLeftY", option=7, default=1, step=.1, step2=.01, step3=.001},
			{name="UpperRightX", option=7, default=1, step=.1, step2=.01, step3=.001},
			{name="UpperRightY", option=7, default=0, step=.1, step2=.01, step3=.001},
			{name="LowerRightX", option=7, default=1, step=.1, step2=.01, step3=.001},
			{name="LowerRightY", option=7, default=1, step=.1, step2=.01, step3=.001},
		}
	},
	{ method="SetText",
		options={ {name="Text", option=1, default=""} },
		detection="GetText" },
	{ method="SetFont",
		options={
			{name="Font", option=3, table="DL_FONTS_LIST", default="Fonts\\Arial.ttf"},
			{name="FontHeight", option=4, min=1, max=30, default=12, minlock=true}
		},
		detection = "GetFont"
	},
	{ method="SetBackdrop",
		help = "These are settings for a background that appears behind the frame.",
		options={
			{name="BGTexture", option=3, default="Interface\\AddOns\\DiscordLibrary\\PlainBackdrop", table="DL_TEXTURES_LIST" },
			{name="BorderTexture", option=3, default="Interface\\AddOns\\DiscordLibrary\\PlainBackdrop", table="DL_EDGE_FILES"},
			{name="Tile", option=5},
			{name="TileSize", option=4, default=32, min=1, max=100, minlock=true},
			{name="EdgeSize", option=4, default=16, min=1, max=100, minlock=true},
			{name="LeftInset", option=4, default=5, min=1, max=50, minlock=true},
			{name="RightInset", option=4, default=5, min=1, max=50, minlock=true},
			{name="TopInset", option=4, default=5, min=1, max=50, minlock=true},
			{name="BottomInset", option=4, default=5, min=1, max=50, minlock=true},
		}
	},
	{ method="SetAlpha",
		help = "Sets the transparency of the frame.",
		options={ {name="Alpha", option=4, default=1, min=1, max=100, scale=100, minlock=true, maxlock=true} },
		detection="GetAlpha" },
	{ method="SetTextColor",
		options={
			{name="TextColor", option=6, default={r=1, g=1, b=1}},
			{name="TextAlpha", option=4, default=1, min=0, max=100, scale=100, minlock=true, maxlock=true}
		},
		detection="GetTextColor" },
	{ method="SetJustifyH",
		options={ {name="JustifyH", option=2, table="DL_JUSTIFY_H", default="CENTER"} },
		detection = "GetJustifyH"
	},
	{ method="SetJustifyV",
		options={ {name="JustifyV", option=2, table="DL_JUSTIFY_V", default="CENTER"} },
		detection = "GetJustifyV"
	},
	{ method="SetNonSpaceWrap",
		options={ {name="NonSpaceWrap", option=5} } },
	{ method="SetVertexColor",
		help = "Sets the color of the texture.",
		options={ 
			{name="Color", option=6, default={r=1, g=1, b=1}},
			{name="TextureAlpha", option=4, default=1, min=0, max=100, scale=100, minlock=true, maxlock=true}
		},
		detection = "GetVertexColor"
	},
	{ method="EnableMouse",
		help = "Stops this frame from intercepting mouse clicks.",
		options={ {name="DisableMouse", option=5} } },
	{ method="EnableMouseWheel",
		help = "Stops this frame from intercepting input from the mousewheel.",
		options={ {name="DisableMouseWheel", option=5} } },
	{ method="SetBackdropColor",
		options={
			{name="BackgroundColor", option=6, default={r=1, g=1, b=1}},
			{name="BackgroundAlpha", option=4, default=1, min=0, max=100, scale=100, minlock=true, maxlock=true}
		}
	},
	{ method="SetBackdropBorderColor",
		options={
			{name="BorderColor", option=6, default={r=1, g=1, b=1}},
			{name="BorderAlpha", option=4, default=1, min=0, max=100, scale=100, minlock=true, maxlock=true}
		}
	},
	{ method="SetGradient",
		options={
			{name="ColorGradientOrientation", option=2, default="", table="DL_ORIENTATIONS"},
			{name="MinColor", option=6, default={r=1, g=1, b=1}},
			{name="MaxColor", option=6, default={r=1, g=1, b=1}}
		}
	},
	{ method="SetGradientAlpha",
		options={
			{name="AlphaGradientOrientation", option=2, default="", table="DL_ORIENTATIONS"},
			{name="MinColor", option=6, default={r=1, g=1, b=1}},
			{name="MaxColor", option=6, default={r=1, g=1, b=1}},
			{name="MinAlpha", option=4, default=1, min=0, max=100, scale=100, minlock=true, maxlock=true},
			{name="MaxAlpha", option=4, default=1, min=0, max=100, scale=100, minlock=true, maxlock=true}
		}
	},
	{ method="SetDisabledTextColor",
		options={ {name="DisabledTextColor", option=6, default={r=1, g=1, b=1}} } },
	{ method="SetHighlightTextColor",
		options={ {name="HighlightTextColor", option=6, default={r=1, g=1, b=1}} } },
	{ method="SetModel",
		options={ {name="Model", option=1, default=""} } },
	{ method="SetModelScale",
		options={ {name="ModelScale", option=4, default=1, min=1, max=200, scale=100, minlock=true, maxlock=true} },
		detection="GetModelScale"},
	{ method="SetPosition",
		options={
			{name="PositionX", option=4, default=0, min=-100, max=100},
			{name="PositionY", option=4, default=0, min=-100, max=100},
			{name="PositionZ", option=4, default=0, min=-100, max=100}
		}
	},
	{ method="ReplaceIconTexture",
		options={ {name="IconTexture", option=3, table="DL_TEXTURES_LIST"} } },
	{ method="SetCamera",
		options={ {name="Camera", option=4, default=0, min=-100, max=100} } },
	{ method="SetFacing",
		options={ {name="Facing", option=4, default=0, min=0, max=10} } },
	{ method="SetFogColor",
		options={
			{name="FogColor", option=6, default={r=1, g=1, b=1}},
			{name="FogAlpha", option=4, default=1, min=0, max=100, scale=100, minlock=true, maxlock=true}
		}
	},
	{ method="SetFogFar",
		options={ {name="FogFar", option=4, default=6, min=0, max=50} } },
	{ method="SetFogNear",
		options={ {name="FogNear", option=4, default=6, min=0, max=50} } },
	{ method="SetTimeVisible",
		options={ {name="TimeVisible", option=4, default=1, min=0, max=120, minlock=true} },
		detection = "GetTimeVisible"
	},
	{ method="SetMaxLines",
		options={ {name="MaxLines", option=4, default=50, min=0, max=100, minlock=true} } },
	{ method="SetFadeDuration",
		options={ {name="FadeDuration", option=4, default=1, min=0, max=60, minlock=true} },
		detection = "GetFadeDuration"
	},
	{ method="SetStatusBarColor",
		options={
			{name="StatusBarColor", option=6, default={r=1, g=1, b=1}},
			{name="StatusBarAlpha", option=4, default=1, min=0, max=100, scale=100, minlock=true, maxlock=true}
		},
		detection = "GetStatusBarColor"
	},
	{ method="SetRotation",
		options={ {name="Rotation", option=4, default=0, min=0, max=10} } },
	{ method="SetAlphaGradient",
		options={
			{name="AGStart", option=4, default=0, min=0, max=100, minlock=true},
			{name="AGLength", option=4, default=0, min=0, max=100, minlock=true}
		}
	},
	{ method="SetDrawLayer",
		help = "Sets the draw layer of a FontString or Texture.  Regions in a lower draw layer display beneath those in higher layers.  Frame strata takes precedence over draw layer.",
		options={ {name="DrawLayer", option=2, default="ARTWORK", table="DL_DRAWLAYERS"} },
		detection = "GetDrawLayer"
	},
	{ method="SetBlendMode",
		help = "Sets how the FontString or Texture blends with the images beneath it.",
		options={ {name="BlendMode", option=2, default="BLEND", table="DL_BLENDMODES"} },
		detection = "GetBlendMode"},
	{ method="SetFontObject",
		help = "Set the text's font object rather than specifying a particular font file.  Changes to the font object will change this text's font.",
		options={ {name="FontObject", option=1, default=""} },
		detection = "GetFontObject"},
	{ method="SetShadowColor",
		help = "Sets the color and alpha of the drop shadow behind the text.",
		options={
			{name="ShadowColor", option=6, default={r=0, g=0, b=0}},
			{name="ShadowAlpha", option=4, default=1, min=0, max=100, scale=100, minlock=true, maxlock=true}
		},
		detection="GetShadowColor" },
	{ method="SetShadowOffset",
		help = "Sets the horizontal and vertical distance of the text's shadow from the foreground text.",
		options={
			{name="ShadowOffsetX", option=4, default=1, min=-10, max=10},
			{name="ShadowOffsetY", option=4, default=1, min=-10, max=10}
		},
		detection="GetShadowOffset"
	},
	{ method="SetSpacing",
		options={ {name="Spacing", option=4, default=1, min=0, max=100} },
		detection = "GetSpacing"},
	{ method="SetTextFontObject",
		help = "Set the text's font object rather than specifying a particular font file.  Changes to the font object will change this text's font.",
		options={ {name="FontObject", option=1, default=""} },
		detection = "GetTextFontObject"},
	{ method="SetDisabledFontObject",
		help = "Set the disabled text's font object rather than specifying a particular font file.  Changes to the font object will change this text's font.",
		options={ {name="DisabledFontObject", option=1, default=""} },
		detection = "GetDisabledFontObject"},
	{ method="SetHighlightFontObject",
		help = "Set the highlight text's font object rather than specifying a particular font file.  Changes to the font object will change this text's font.",
		options={ {name="HighlightFontObject", option=1, default=""} },
		detection = "GetHighlightFontObject"},
	{ method="SetMaskTexture",
		options={ {name="MaskTexture", option=1, default="Textures\\MinimapMask"} } },
	{ method="SetIconTexture",
		options={ {name="IconTexture", option=1, default="Interface\\Minimap\\POIIcons"} } },
	{ method="SetBlipTexture",
		options={ {name="BlipTexture", option=1, default="Interface\\Minimap\\ObjectIcons"} } },
	{ method="SetOrientation",
		options={ {name="Orientation", option=2, default="HORIZONTAL", table="DL_ORIENTATIONS"} },
		detection = "GetOrientation"
	},
	{ method="SetAltArrowKeyMode",
		options={ {name="AltArrowKeyMode", option=5} },
		detection = "GetAltArrowKeyMode"
	},
	{ method="SetScrollChild",
		options={ {name="ScrollChild", option=1, default=""} },
		detection = "GetScrollChild"
	},
	{ method="SetThumbTexture",
		options={ {name="ThumbTexture", option=1, default=""} }, },
	{ method="SetToplevel",
		help = "Checking this option causes the frame to move to the top of the stack of frames within a frame strata.  It can cause framerate issues if multiple frames in the same strata use this option.",
		options={ {name="SetToplevel", option=5} },
		detection = "IsToplevel"
	},
--	{ method="",
--		options={ {name="", option=, default=} } },
}