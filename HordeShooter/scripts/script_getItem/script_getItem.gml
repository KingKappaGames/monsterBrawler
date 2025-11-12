enum E_item {
	branch = 0,
	broadSword = 1,
	woodenClub = 2,
	blackPoker = 3,
	crabClaw = 4,
	desertStaff = 5,
	woodenSpear = 6,
	icicle = 7,
	toyHammer = 8,
	hammer = 9,
	woodenCane = 10,
	baton = 11,
	woodCutterAxe = 12
}

function script_getItemInfo(index) {
	
	var _item = {
		hitFunc : undefined,
		itemDamage : 0,
		itemGeneralDamage : 0,
		itemKnockback : 0,
		itemKnockbackHeight : 0,
		itemStun : 0,
	}
	
	with(_item) {
	
		if(index == E_item.branch) {
			hitFunc = undefined;
			itemDamage = 1;
			itemGeneralDamage = 1;
			itemKnockback = 1;
			itemKnockbackHeight = 1;
			itemStun = 1;
		} else if(index == E_item.broadSword) {
			hitFunc = undefined;
			itemDamage = 1;
			itemGeneralDamage = 1;
			itemKnockback = 1;
			itemKnockbackHeight = 1;
			itemStun = 1;
		} else if(index == E_item.woodenClub) {
			hitFunc = undefined;
			itemDamage = 1;
			itemGeneralDamage = 1;
			itemKnockback = 1;
			itemKnockbackHeight = 1;
			itemStun = 1;
		} else if(index == E_item.blackPoker) {
			hitFunc = undefined;
			itemDamage = 1;
			itemGeneralDamage = 1;
			itemKnockback = 1;
			itemKnockbackHeight = 1;
			itemStun = 1;
		} else if(index == E_item.crabClaw) {
			hitFunc = undefined;
			itemDamage = 1;
			itemGeneralDamage = 1;
			itemKnockback = 1;
			itemKnockbackHeight = 1;
			itemStun = 1;
		} else if(index == E_item.desertStaff) {
			hitFunc = undefined;
			itemDamage = 1;
			itemGeneralDamage = 1;
			itemKnockback = 1;
			itemKnockbackHeight = 1;
			itemStun = 1;
		} else if(index == E_item.woodenSpear) {
			hitFunc = undefined;
			itemDamage = 1;
			itemGeneralDamage = 1;
			itemKnockback = 1;
			itemKnockbackHeight = 1;
			itemStun = 1;
		} else if(index == E_item.icicle) {
			hitFunc = undefined;
			itemDamage = 1;
			itemGeneralDamage = 1;
			itemKnockback = 1;
			itemKnockbackHeight = 1;
			itemStun = 1;
		} else if(index == E_item.toyHammer) {
			hitFunc = undefined;
			itemDamage = 1;
			itemGeneralDamage = 1;
			itemKnockback = 1;
			itemKnockbackHeight = 1;
			itemStun = 1;
		} else if(index == E_item.hammer) {
			hitFunc = undefined;
			itemDamage = 1;
			itemGeneralDamage = 1;
			itemKnockback = 1;
			itemKnockbackHeight = 1;
			itemStun = 1;
		} else if(index == E_item.woodenCane) {
			hitFunc = undefined;
			itemDamage = 1;
			itemGeneralDamage = 1;
			itemKnockback = 1;
			itemKnockbackHeight = 1;
			itemStun = 1;
		} else if(index == E_item.baton) {
			hitFunc = undefined;
			itemDamage = 1;
			itemGeneralDamage = 1;
			itemKnockback = 1;
			itemKnockbackHeight = 1;
			itemStun = 1;
		} else if(index == E_item.woodCutterAxe) {
			hitFunc = undefined;
			itemDamage = 1;
			itemGeneralDamage = 1;
			itemKnockback = 1;
			itemKnockbackHeight = 1;
			itemStun = 1;
		}
		
	}
	
	return _item;
}