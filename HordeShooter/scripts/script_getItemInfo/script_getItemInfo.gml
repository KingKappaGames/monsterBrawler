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
	woodCutterAxe = 12,
	itemCount = 13
}

function script_getItemInfo(itemIndex) {
	
	var _item = {
		index : itemIndex,
		sprite : spr_swordBranch,
		hitFunc : undefined,
		itemMeleDamage : 0,
		itemMagicDamage : 0,
		itemKnockback : 0,
		itemKnockbackHeight : 0,
		itemStun : 0,
	}
	
	with(_item) {
	
		if(itemIndex == E_item.branch) {
			sprite = spr_swordBranch;
			hitFunc = function(target, source) {
				if(irandom(8) == 0) {
					target.applyAcidic(120);
				}
			};
			itemMeleDamage = 1;
			itemMagicDamage = 1;
			itemKnockback = 1;
			itemKnockbackHeight = 1;
			itemStun = 1;
		} else if(itemIndex == E_item.broadSword) {
			sprite = spr_swordFantasy;
			hitFunc = undefined;
			itemMeleDamage = 1.5;
			itemMagicDamage = 1;
			itemKnockback = .8;
			itemKnockbackHeight = .5;
			itemStun = .5;
		} else if(itemIndex == E_item.woodenClub) {
			sprite = spr_swordClub;
			hitFunc = undefined;
			itemMeleDamage = 1;
			itemMagicDamage = 1;
			itemKnockback = 1.5;
			itemKnockbackHeight = 1;
			itemStun = 1.2;
		} else if(itemIndex == E_item.blackPoker) {
			sprite = spr_swordBlackPoker;
			hitFunc = undefined;
			itemMeleDamage = 1;
			itemMagicDamage = 1.5;
			itemKnockback = .5;
			itemKnockbackHeight = 0;
			itemStun = .5;
		} else if(itemIndex == E_item.crabClaw) {
			sprite = spr_swordCrabClaw;
			hitFunc = undefined;
			itemMeleDamage = 1;
			itemMagicDamage = 1;
			itemKnockback = 1;
			itemKnockbackHeight = 5;
			itemStun = 1;
		} else if(itemIndex == E_item.desertStaff) {
			sprite = spr_swordDesertStaff;
			hitFunc = undefined;
			itemMeleDamage = 1;
			itemMagicDamage = 1;
			itemKnockback = 1;
			itemKnockbackHeight = 1;
			itemStun = 1;
		} else if(itemIndex == E_item.woodenSpear) {
			sprite = spr_swordSpear;
			hitFunc = undefined;
			itemMeleDamage = 1;
			itemMagicDamage = 1;
			itemKnockback = .8;
			itemKnockbackHeight = .5;
			itemStun = .6;
		} else if(itemIndex == E_item.icicle) {
			sprite = spr_swordIce;
			hitFunc = function(target, source) {
				if(irandom(25) == 0) {
					target.applyFreezing(300);
				}
			};
			itemMeleDamage = 1;
			itemMagicDamage = 1;
			itemKnockback = .7;
			itemKnockbackHeight = .7;
			itemStun = .7;
		} else if(itemIndex == E_item.toyHammer) {
			sprite = spr_swordToyHammer;
			hitFunc = undefined;
			itemMeleDamage = .5;
			itemMagicDamage = 1;
			itemKnockback = 3;
			itemKnockbackHeight = .5;
			itemStun = 1.25;
		} else if(itemIndex == E_item.hammer) {
			sprite = spr_swordHammer;
			hitFunc = undefined;
			itemMeleDamage = 1;
			itemMagicDamage = 1;
			itemKnockback = 1.75;
			itemKnockbackHeight = 1;
			itemStun = 1.75;
		} else if(itemIndex == E_item.woodenCane) {
			sprite = spr_swordCane;
			hitFunc = undefined;
			itemMeleDamage = 1;
			itemMagicDamage = 1;
			itemKnockback = 1;
			itemKnockbackHeight = 1;
			itemStun = 1;
		} else if(itemIndex == E_item.baton) {
			sprite = spr_swordBaton;
			hitFunc = undefined;
			itemMeleDamage = .6;
			itemMagicDamage = 1;
			itemKnockback = .6;
			itemKnockbackHeight = .6;
			itemStun = 2;
		} else if(itemIndex == E_item.woodCutterAxe) {
			sprite = spr_swordAxe;
			hitFunc = undefined;
			itemMeleDamage = 2;
			itemMagicDamage = 1;
			itemKnockback = 1;
			itemKnockbackHeight = 1;
			itemStun = 1;
		}
		
	}
	
	return _item;
}