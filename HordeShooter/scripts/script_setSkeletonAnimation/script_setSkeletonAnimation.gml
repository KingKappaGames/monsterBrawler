function script_setSkeletonAnimation(animation, image = 0, speed = undefined, spanTime = undefined, spanFromBeginning = undefined) {
	script_setAnimation(global.animations[animation], image, speed, spanTime, spanFromBeginning);
	
	skeletonAnimation = animation; // store index of animation (in enum and for arrays, same thing)
}