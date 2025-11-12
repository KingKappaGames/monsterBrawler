function script_createItemPickup(xx, yy, item) {
	var _pickup = instance_create_depth(xx, yy, -yy, obj_itemPickup);
	_pickup.itemInfo = script_getItemInfo(item);
}