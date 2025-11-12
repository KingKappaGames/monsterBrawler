function script_equipItem(itemInfo, receiver = id) {
	
	//drop old item
	
	with(receiver) {
		meleeHitFunc = itemInfo.hitFunc;
		
		itemDamage = itemInfo.itemDamage;
		itemGeneralDamage = itemInfo.itemGeneralDamage;
		itemKnockback = itemInfo.itemKnockback;
		itemKnockbackHeight = itemInfo.itemKnockbackHeight;
		itemStun = itemInfo.itemStun;
		
		calculateStats();
	}
}