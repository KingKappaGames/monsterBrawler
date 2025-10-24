function directionTo(targetId) {
	gml_pragma("forceinline");
	
	return point_direction(x, y, targetId.x, targetId.y);
}