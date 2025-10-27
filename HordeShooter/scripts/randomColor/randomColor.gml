///@desc This function returns a random color by default but with a style of 1 will return grey scale, add more in the future?i
///@param style This is the style of color, aka, rainbow:0, or greyscale:1
///@param colorMax This is the max value generated. This can limit greys to only darks or random colors to only dark colors
///@param colorMin This is the min value generated. The opposite of the max to create constricted color range.
function randomColor(style = 0, colorMax = 255, colorMin = 0){
	if(style == 0) {
		return make_color_rgb(irandom_range(colorMin, colorMax), irandom_range(colorMin, colorMax), irandom_range(colorMin, colorMax));
	} else if(style == 1) {
		var _color = irandom_range(colorMin, colorMax);
		return make_color_rgb(_color, _color, _color);
	}
}