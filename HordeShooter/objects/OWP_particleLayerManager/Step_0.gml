moveCollection();

if(OWPshowDebug) {
	var _layerAdd = round(((mouse_y - (previousEdgeY))) / sysSpacing) - 1; // the mouse layer is accurate
	var _sysIndex = (currentSysEdge + _layerAdd) % sysCount;
	if(_sysIndex < 0) {
		_sysIndex = sysCount + (_sysIndex - 1);
	}
	mouseLayer = _sysIndex;
	
	if(mouse_check_button(mb_middle)) {
		OWP_createPart(debugPart, mouse_x, mouse_y, 1, choose(c_red, c_blue, c_green)); // create debug parts on middle click, may be annoying though if you don't want them, lol!
	}
}