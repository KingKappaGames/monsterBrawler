

///@desc A basic script to create debris of some variety.
///@param sprite What sprite to use
///@param imageIndex What image of the sprite to use
///@param tragectoryType The type of trajectory or movement type that the particle will use. 0 is no movement, 1 is move in line, 2 is bouncing, 3 is sliding after drop
///@param spawnX The x position to create the debris
///@param spawnY The y position to create the debris
///@param debrisIndex What kind of debris to use. Default is base
///@param duration How many frames the debris should last before drawing or deleting.
///@param xChange The x speed
///@param yChange The y speed
///@param spinSpeed How fast the debris should spin while moving.
///@param moveSpeedDecay How fast the debris slows down in spin and speed
///@param speedSpecialAdjust This adjusts how bouncy bouncer objects are, that's all for now
///@param heightStart Determines the start height for the debris to fall
///@param heightChange The vertical speed
///@param damageGround Whether the debris should leave further marks when hitting ground like heavy stones or whatever
///@param drawToGround Whether the debris should store itself visually in the debris surface permanantly or just disappear
function script_createDebris(sprite, imageIndex, tragectoryType, spawnX, spawnY, debrisIndex = obj_DebrisBase, duration = 240, xChange = 0, yChange = 0, spinSpeed = 0, moveSpeedDecay = .96, speedSpecialAdjust = .8, heightStart = 10, heightChange = 0){
	var _debris = instance_create_depth(spawnX, spawnY, depth, debrisIndex);
	_debris.sprite_index = sprite;
	_debris.image_index = imageIndex;
	_debris.airHeight = heightStart;
	_debris.heightChange = heightChange;
	_debris.xChange = xChange;
	_debris.yChange = yChange;
	_debris.movementType = tragectoryType; // 0 is no movement, 1 is move in line, 2 is bouncing, 3 is sliding after drop
	_debris.movementAdjust = speedSpecialAdjust;
	_debris.speedDecay = moveSpeedDecay;
	_debris.spinSpeed = spinSpeed;
	_debris.canExpire = 0;
	_debris.duration = duration;
	
	return _debris;
}