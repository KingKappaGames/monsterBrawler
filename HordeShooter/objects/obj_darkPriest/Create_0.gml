event_inherited();

allegiance = E_allegiance.barbarian;

HealthMax = 50;
poiseMax = 500;

attackRange = 120;

damage = 2;
knockback = 1.5;
knockbackHeight = 1.5;

sprite_index = spr_darkOne;

SM.add("attack", {
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
			if(instance_exists(agroId)) {
				var _aimDir = point_direction(x, y, agroId.x, agroId.y);
				script_createAttack(obj_grenade, agroId.x, agroId.y, 0, 0, 1200,,, damage, knockback, knockbackHeight, 5);
			}
		}
    },
	leave: function() {
		image_angle = 0;
	}
});

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