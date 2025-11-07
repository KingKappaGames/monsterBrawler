event_inherited();

allegiance = E_allegiance.knight;

HealthMax = 65;
poiseMax = 500;

attackRange = 150;

damage = 5;
meleeDamage = 10;
knockback = 4;

#region animations

animIdle = spr_monkIdle;
animRun = spr_monkRun;
animHit = spr_monkHit;
animJumpStart = spr_monkJumpStart;
animRise = spr_monkJumpRise;
animFall = spr_monkJumpFall;

sprite_index = animIdle;
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
			var _aimDir = irandom(360);
			for(var _i = 0; _i < 18; _i++) {
				_aimDir += 20;
				script_createAttack(obj_bullet, x + lengthdir_x(16, _aimDir), y + lengthdir_y(16, _aimDir), _aimDir, height, .8, 2,,, damage, knockback,, 5);
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