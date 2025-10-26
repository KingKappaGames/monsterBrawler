//-2 for itemResponsible means don't check for effects, -1 means no item in particular just check all items, and 0-12 represent gear positions
//hitInfo = [damageArray, blockable, absolute, statusInfoArray, statusChance, itemResponsible];
#region contains jsdoc stuff           
///@param allegianceOverride             
///@param startX             
///@param startY
///@param directionCheck          
///@param thickness
///@param length
///@param damage array that contains |dmgArr-blockable-absolute-statusInfo-status%Dec-itemResponsible|
///@param knockbackStrength The strength of pushback on whatever thing gets hit.
///@param knockbackDirection The direction of the pushback on the hit thing.
///@param knockbackHeight The height component of the hit knockback
///@param stun This array or -1 passes in stun info, [power, verticallity] using the direction from knockback
///@param hitFunc A function that takes hitId and sourceId (probably the slash object) and runs some code with it, again the params should be target, source aka hitFunc = function(targetId, sourceId) { do stuff }
///@param targets This value is passed through to the collision scripts that game maker uses, so it can be keywords, objects, arrays, tile sets, ect. Direct transfer so whatever gm uses goes here
///@param {ARRAY} exclusions This is an array of white listed instances that if the hit id is contained will not hit
#endregion
function script_MeleeHitBoxRotated(allegianceOverride, startX, startY, directionCheck, thickness, length, damage, knockbackStrength, knockbackDirection, knockbackHeight, stun = -1, hitFunc = undefined, targets = obj_creature, exclusions = []){	
	var _hitThings = script_CollisionRectangleRotated(startX, startY, directionCheck, thickness, length, true, 0, allegianceOverride, targets, exclusions); // get hits that match game values, agro, hitbox, ect, so this is an entirely filtered list besides attempt hit I suppose
	var _hits = []; // the net hits after attempt hit check
	
	for(var _i = array_length(_hitThings) - 1; _i >= 0; _i--) { // agro handled in collision script or no?
		if(!is_undefined(hitFunc)) {
			hitFunc(_hitThings[_i], other);
		}
		
		_hitThings[_i].takeDamage(damage, knockbackDirection, knockbackStrength, knockbackHeight, stun); //damage, direction, force, heightForce, stun = undefined, makeHitNumber = true, doEffects = true
		array_push(_hits, _hitThings[_i]); // push this hit thing after checks within attempt hit, also attempt hit does the hitting itself so hit has gone through at this point
	}
	
	return _hits;
}