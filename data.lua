data.raw["gui-style"].default["tms_button"] =
{
	type = "button_style",
	parent = "button_style",
	top_padding = 1,
	right_padding = 5,
	bottom_padding = 1,
	left_padding = 5,
	left_click_sound =
	{
		{
			filename = "__core__/sound/gui-click.ogg",
			volume = 1
		}
	},

}

data.raw["gui-style"].default["tms_buttonAlpha"] =
{
	type = "button_style",
	parent = "tms_button",
	default_graphical_set =
   {
		type = "composition",
		filename = "__core__/graphics/gui.png",
		priority = "extra-high-no-scale",
		corner_size = {2, 2},
		position = {8, 0}
	},
}

data.raw["gui-style"].default["tms_buttonInactive"] =
{
	type= "button_style",
	parent= "tms_button",
	default_font_color= {r=0.8,g=0.8,b=0.8,a=0.5},
	default_graphical_set =
   {
		type = "composition",
		filename = "__core__/graphics/gui.png",
		priority = "extra-high-no-scale",
		corner_size = {3, 3},
		position = {8, 0}
	},
   hovered_font_color= {r=0.8,g=0.8,b=0.8,a=0.5},
   hovered_graphical_set =
   {
     type = "composition",
     filename = "__core__/graphics/gui.png",
     priority = "extra-high-no-scale",
     corner_size = {3, 3},
     position = {8, 0}
   },
	clicked_font_color= {r=0.8,g=0.8,b=0.8,a=0.5},
}

data.raw["gui-style"].default["tms_buttonInvis"] =
{
	type = "button_style",
	parent = "tms_button",
	default_graphical_set = { type = "none" }
}

data.raw["gui-style"].default["tms_label"] =
{
	type = "label_style",
	parent = "label_style",
	top_padding = 1,
	right_padding = 5,
	bottom_padding = 1,
	left_padding = 5
}

data.raw["gui-style"].default["tms_label_compact"] =
{
	type = "label_style",
	parent = "tms_label",
	right_padding = 1,
	left_padding = 1
}

data.raw["gui-style"].default["tms_label_fat"] =
{
	type = "label_style",
	parent = "tms_label",
	font = "default-frame"
}

data.raw["gui-style"].default["tms_label_title"] =
{
	type = "label_style",
	parent = "tms_label_fat",
	left_padding = 2,
	bottom_padding = 8,
	font = "default-frame"
}

data.raw["gui-style"].default["tms_frame_naked"] =
{
	type = "frame_style",
	parent = "inner_frame_style",
	top_padding = 1,
	right_padding = 1,
	bottom_padding = 1,
	left_padding = 1,
	title_bottom_padding= 0,
	title_top_padding=0,
	flow_style=
	{
		vertical_spacing = 0
	}
}

data.raw["gui-style"].default["tms_frameAlpha"] =
{
	type = "frame_style",
	parent = "tms_frame_naked",
	graphical_set =
   {
		type = "composition",
		filename = "__core__/graphics/gui.png",
		priority = "extra-high-no-scale",
		corner_size = {2, 2},
		position = {8, 0}
		--position = {16, 8}
	},
	horizontal_spacing= 2,
	vertical_spacing= 2,
	top_padding= 2,
	right_padding= 2,
	bottom_padding= 2,
	left_padding= 2
}

data.raw["gui-style"].default["tms_superGui_frame"] =
{
	type = "frame_style",
	parent = "tms_frame_naked",
	--$$ uncoment following code for debuging purposes
	--[[ 
	graphical_set =
	{
		type = "monolith",
		top_monolith_border = 0,
		right_monolith_border = 0,
		bottom_monolith_border = 0,
		left_monolith_border = 0,
		monolith_image =
		{
			filename = "__core__/graphics/gui.png",
			priority = "extra-high-no-scale",
			width = 1,
			height = 1,
			x = 221,
			y = 36
		}
	}
	--]]
}

data.raw["gui-style"].default["tms_frame_compact"] =
{
	type= "frame_style",
	parent= "frame_style",
	top_padding= 1,
	right_padding= 4,
	bottom_padding= 1,
	left_padding= 4,
	title_bottom_padding= 4,
	title_top_padding= 0,
	horizontal_spacing= 0,
	vertical_spacing= 0,
	graphical_set =
   {
		type = "composition",
		filename = "__ThunderGui__/graphics/gui.png",
		priority = "extra-high-no-scale",
		corner_size = {2, 2},
		--position = {8, 0}
		position = {0, 24}
	}
}

data.raw["gui-style"].default["tms_flow_compact"] =
{
	type= "flow_style",
	parent= "flow_style",
	horizontal_spacing= 0,
	vertical_spacing= 0,
	top_padding= 0,
	right_padding= 0,
	bottom_padding= 0,
	left_padding= 0
}
