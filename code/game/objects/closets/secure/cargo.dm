
/obj/structure/closet/secure_closet/qm_personal
	name = "Quartermaster's Locker"
	req_access = list(access_qm)

	New()
		..()
		sleep(2)
		new /obj/item/wardrobe/qm(src)
		//
		var/obj/item/weapon/storage/backpack/BPK = new /obj/item/weapon/storage/backpack(src)
		var/obj/item/weapon/storage/box/B = new(BPK)
		new /obj/item/weapon/pen(B)
		new /obj/item/weapon/clipboard(src)
		new /obj/item/device/pda/quartermaster(src)
		new /obj/item/clothing/glasses/sunglasses(src)
		new /obj/item/device/radio/headset/heads/qm(src)

/obj/structure/closet/secure_closet/cargo_tech_personal
	name = "Cargo Tech's Locker"
	req_access = list(access_cargo)

	New()
		..()
		sleep(2)
		new /obj/item/wardrobe/cargo_tech(src)
		//
		var/obj/item/weapon/storage/backpack/BPK = new /obj/item/weapon/storage/backpack(src)
		var/obj/item/weapon/storage/box/B = new(BPK)
		new /obj/item/weapon/pen(B)
		new /obj/item/device/pda/quartermaster(src)
		new /obj/item/device/radio/headset/headset_cargo(src)

/obj/structure/closet/secure_closet/miner_personal
	name = "Miner's Locker"
	req_access = list(access_cargo)

	New()
		..()
		sleep(2)
		new /obj/item/wardrobe/cargo_tech(src)
		//
		var/obj/item/weapon/storage/backpack/industrial/BPK = new /obj/item/weapon/storage/backpack/industrial(src)
		var/obj/item/weapon/storage/box/B = new(BPK)
		new /obj/item/weapon/pen(B)
		new /obj/item/device/radio/headset/headset_mine(src)