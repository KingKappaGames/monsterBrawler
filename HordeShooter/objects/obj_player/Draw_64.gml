if (live_call()) return live_result;

var _healthBarXLeft = view_wport[0] * .065;
var _healthBarYTop = view_hport[0] * .045;

var _healthPercent = Health / HealthMax;

draw_sprite_ext(spr_healthBar, 0, _healthBarXLeft, _healthBarYTop, 4, 3, 0, c_white, 1);
draw_sprite_part_ext(spr_healthBarColor, 0, 0, 0, sprite_get_width(spr_healthBarColor) * _healthPercent, sprite_get_height(spr_healthBarColor), _healthBarXLeft, _healthBarYTop, 4, 3, c_white, 1);