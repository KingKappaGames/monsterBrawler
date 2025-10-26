event_inherited();

allegiance = E_allegiance.barbarian;

HealthMax = 40;
poiseMax = 500;

attackRange = 120;
attackRangeRangedMin = 150;
attackRangeRangedMax = 240;

damage = 2;
knockback = 1.5;
knockbackHeight = 1.5;

sprite_index = spr_darkOne;
image_blend = c_black;

SM.add("attack", {
    enter: function(duration = 45) {
		//die animation
		script_setEventTimer(duration);
		image_angle = 20;
    },
    step: function() {
		stateTimer--;
		if(stateTimer <= 0) {
			SM.change("chase");
		} else if(abs(stateTimer - round(stateTimerMax * .5)) == 0) {
			if(instance_exists(agroId)) {
				var _aimDir = point_direction(x, y, agroId.x, agroId.y);
				script_createAttack(obj_grenade, agroId.x, agroId.y, 0, 0, 2,,, damage, knockback, knockbackHeight, 5);
			}
		}
    },
	leave: function() {
		image_angle = 0;
	}
});

SM.add("attackRanged", {
    enter: function(duration = 50) {
		//die animation
		script_setEventTimer(duration);
		image_angle = 8;
    },
    step: function() {
		stateTimer--;
		if(stateTimer <= 0) {
			SM.change("chase");
		} else if(abs(stateTimer - round(stateTimerMax * .5)) == 0) {
			if(instance_exists(agroId)) {
				var _aimDir = point_direction(x, y, agroId.x, agroId.y);
				script_createAttack(obj_fireJet, x + lengthdir_x(attackCreateDist, _aimDir), y + lengthdir_y(attackCreateDist, _aimDir), _aimDir, 1.3, .8,,, damage, knockback, knockbackHeight, 5);
			}
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
		if(irandom(25) == 0) {
			_state = "attack";
		}
	} else if(_targetDist < attackRangeRangedMax && _targetDist > attackRangeRangedMin) {
		if(irandom(60) == 0) {
			_state = "attackRanged";
		}
	}
	
	if(_state != "none") {
		SM.change(_state);
	}
	
	return _state; // state names randomly chosen, in theory they could probably just call the SM.change themselves but idk man
}