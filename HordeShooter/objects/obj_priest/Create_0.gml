event_inherited();

allegiance = E_allegiance.knight;

HealthMax = 65;
poiseMax = 500;

attackRange = 150;

damage = 5;
meleeDamage = 10;
knockback = 4;

attackRange = 50;
attackRangeRangedMax = 180;
attackRangeRangedMin = 110;

#region animations
useSkeletonAnimations = true;

image_blend = #94daff;

#endregion

SM.add("attackRanged", {
    enter: function(duration = 30) {
		//die animation
		script_setEventTimer(duration);
		image_angle = 20;
    },
    step: function() {
		stateTimer--;
		if(stateTimer <= 0) {
			SM.change("chase");
		} else if(abs(stateTimer - round(stateTimerMax * .5)) == 0) {
			var _radiant = script_createAttackRadiant(obj_radiantAttack, x, y, 0,, 20, 32, 100, .7, #ccccff);
			//var _aimDir = irandom(360);
			//for(var _i = 0; _i < 18; _i++) {
				//_aimDir += 20;
				//script_createAttack(obj_bullet, x + lengthdir_x(16, _aimDir), y + lengthdir_y(16, _aimDir), _aimDir, height, .8, 2,,, damage, knockback,, 5);
			//}
		}
    },
	leave: function() {
		image_angle = 0;
	}
});

determineAttack = function() {
	var _state = "none";
	var _targetDist = point_distance(x, y, agroId.x, agroId.y);
	if(_targetDist < attackRange) {
		if(irandom(15) == 0) {
			_state = "melee";
		}
	} else if(_targetDist < attackRangeRangedMax && _targetDist > attackRangeRangedMin) {
		if(irandom(500) == 0) {
			_state = "attackRanged";
		}
	}
	
	if(_state != "none") {
		SM.change(_state);
	}
	
	return _state; // state names randomly chosen, in theory they could probably just call the SM.change themselves but idk man
}

//SM.add_child("chase", "chaseKill", {
	//enter: function() {
    	//SM.inherit();
	//},
	//step: function() {
		//SM.inherit();
		//if(irandom(10) == 0) {
			//script_AOEDamageHit(,,, 100, 1, 5,, 2, 20);
		//}
	//}
//});