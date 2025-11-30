
inputSurface = surface_get_target();
surfaceWidth = surface_get_width(inputSurface);
surfaceHeight = surface_get_height(inputSurface);

// draw final raindrops surface
if (surface_exists(finalSurf)) {
	draw_surface(finalSurf, 0, 0);
}
