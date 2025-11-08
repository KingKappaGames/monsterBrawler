/// @desc Sets the sprite, image, and speed values of the animation (this represents the move to the built in management vs my animation manager after all these years..)
/// @param {any*} sprite The sprite to use
/// @param {any*} image The image to start at 
/// @param {any*} speed The multiplier to set image_speed to (again, multiplier of the ide sprite speed) OR if using span, the multiplier applied to the span timing, aka 3 would loop three times / be three times faster (leave as default/1 to do normal span behavior)
/// @param {bool} [spanTime]=false If this is a non zero value it will calculate the length of the animation to fit this many frames, so if you know an action should take 90 frames and you want a 7 frame animation to play over that "span" then this will set the speed to.. ~13 assuming 1 ide speed (also handled)
/// @param {bool} [spanFromBeginning]=false With regards to the span calculations, this will either span the remaining frames to the end, or one full loop of frames. False being from current (the set image index) or true for loop once from wherever you start at
function script_setAnimation(sprite, image = 0, speed = 1, spanTime = 0, spanFromBeginning = false) {
	sprite_index = sprite;
	image_index = image;
	
	if(spanTime != 0) {
		if(spanFromBeginning) {
			image_speed = (60 * image_number / spanTime) / sprite_get_speed(sprite_index);
		} else {
			image_speed = (60 * (image_number - (image_index + 1)) / spanTime) / sprite_get_speed(sprite_index);
		}
		
		image_speed *= speed;
	} else {
		image_speed = speed;
	}
}