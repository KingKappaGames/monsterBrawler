function distanceTo(targetId) {
	gml_pragma("forceinline");
	
	return point_distance(x, y, targetId.x, targetId.y);
}