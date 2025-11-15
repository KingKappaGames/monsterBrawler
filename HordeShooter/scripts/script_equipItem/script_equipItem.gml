function script_equipItem(itemInfo, receiver = id, updateSkeleton = true) {
	with(receiver) {
		if(dropItem) {
			script_createItemPickup(x, y, item.index); // drop old item
		}
		
		dropItem = true;
		
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