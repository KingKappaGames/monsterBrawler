function script_equipItem(itemInfo, receiver = id) {
	with(receiver) {
		script_createItemPickup(receiver.x, receiver.y, receiver.item.index); // drop old item
		
		item = itemInfo;
		
		meleeHitFunc = itemInfo.hitFunc;
		
		itemMeleDamage = itemInfo.itemMeleDamage;
		itemMagicDamage = itemInfo.itemMagicDamage;
		itemKnockback = itemInfo.itemKnockback;
		itemKnockbackHeight = itemInfo.itemKnockbackHeight;
		itemStun = itemInfo.itemStun;
		
		calculateStats();
		
		script_setSkeletonPart(E_bodyPart.item, item.sprite, 0); // how to deal with image?
	}
}