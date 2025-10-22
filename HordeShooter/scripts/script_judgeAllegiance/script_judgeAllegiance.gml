///@desc This function solely returns the view of one faction to another, it doesn't handle the specific case or edge cases
function script_judgeAllegiance(allegiance1, allegiance2){ // should there be values here for madness or some other way to say, they're this faction but only 50% and they're pretty wild card esque?
	return global.allegianceGrid[# allegiance1, allegiance2];
}