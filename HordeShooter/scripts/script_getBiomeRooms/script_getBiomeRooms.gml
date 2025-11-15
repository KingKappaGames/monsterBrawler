function script_getBiomeRooms(biome, returnRandom = false) {
	var _roomSet;
	
	//[rm_mapDesertOpen, rm_mapField, rm_mapFieldOpen, rm_mapForest, rm_mapIceOpen, rm_mapPlaza, rm_mapVillage, rm_mapVolcanoFlat];
	
	if(biome == E_biome.grass) {
		_roomSet = [rm_mapField, rm_mapFieldOpen, rm_mapForest, rm_mapFieldOpen, rm_mapFieldOpen, rm_mapFieldOpen, rm_mapFieldOpen];
	} else if(biome == E_biome.village) {
		_roomSet = [rm_mapVillage, rm_mapHayFields];
	} else if(biome == E_biome.lava) {
		_roomSet = [rm_mapPlaza, rm_mapVolcanoFlat];
	} else if(biome == E_biome.ice) {
		_roomSet = [rm_mapIceOpen, rm_mapIcePit, rm_mapIceFlats];
	} else if(biome == E_biome.city) {
		_roomSet = [rm_mapVillage];
	} else if(biome == E_biome.swamp) {
		_roomSet = [rm_mapField];
	} else if(biome == E_biome.desert) {
		_roomSet = [rm_mapDesertOpen, rm_mapDesertPits, rm_mapDesertPlain];
	} else if(biome == E_biome.forest) {
		_roomSet = [rm_mapForest, rm_mapField];
	} else if(biome == E_biome.rockFlats) {
		_roomSet = [rm_mapPlaza];
	}
	
	if(returnRandom) {
		return _roomSet[irandom(array_length(_roomSet) - 1)];
	} else {
		return _roomSet;
	}
}