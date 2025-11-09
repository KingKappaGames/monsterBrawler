//E_biome for the biomes yo

function script_getBiomeBackground(biome) {
	var _background = spr_biomeBackgroundGrass;
	
	if(biome == E_biome.grass) {
		_background = spr_biomeBackgroundGrass;
	} else if(biome == E_biome.village) {
		_background = spr_biomeBackgroundVillage;
	} else if(biome == E_biome.lava) {
		_background = spr_biomeBackgroundLava;
	} else if(biome == E_biome.ice) {
		_background = spr_biomeBackgroundIce;
	} else if(biome == E_biome.city) {
		_background = spr_biomeBackgroundCity;
	} else if(biome == E_biome.swamp) {
		_background = spr_biomeBackgroundSwamp;
	} else if(biome == E_biome.desert) {
		_background = spr_biomeBackgroundDesert;
	} else if(biome == E_biome.forest) {
		_background = spr_biomeBackgroundForest;
	} else if(biome == E_biome.rockFlats) {
		_background = spr_biomeBackgroundRockFlats;
	}
	
	return _background;
}