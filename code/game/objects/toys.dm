/*--------
//CONTAINS
CRAYONS
--------*/
/obj/item/toy/crayonbox/New()
	..()
	new /obj/item/toy/crayon/red(src)
	new /obj/item/toy/crayon/orange(src)
	new /obj/item/toy/crayon/yellow(src)
	new /obj/item/toy/crayon/green(src)
	new /obj/item/toy/crayon/blue(src)
	new /obj/item/toy/crayon/purple(src)
	updateIcon()

/obj/item/toy/crayonbox/proc/updateIcon()
	overlays = list() //resets list
	overlays += image('crayons.dmi',"crayonbox")
	for(var/obj/item/toy/crayon/crayon in contents)
		overlays += image('crayons.dmi',crayon.colourName)

/obj/item/toy/crayonbox/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/toy/crayon))
		switch(W:colourName)
			if("mime")
				usr << "This crayon is too sad to be contained in this box."
				return
			if("rainbow")
				usr << "This crayon is too powerful to be contained in this box."
				return
			else
				usr << "You add the crayon to the box."
				user.drop_item()
				W.loc = src
				add_fingerprint(user)
				updateIcon()
				return
	else
		..()

/obj/item/toy/crayonbox/attack_hand(mob/user as mob)
	if(user.r_hand == src || user.l_hand == src)
		if(!contents.len)
			user << "\red You're out of crayons!"
			return
		else
			var/list/crayons = new()
			for(var/obj/item/toy/crayon/C in contents)
				crayons[C:colourName] = C
			var/choice = input(user, "Pick a color:", "Crayon Box") in crayons as text|null
			if(choice)
				var/obj/crayon = crayons[choice]
				user.put_in_hand(crayon)
				user << "You take the [crayon:colourName] crayon out of the box."
				updateIcon()
	else
		return ..()
	icon_state = "crayonbox[contents.len]"
	return

/obj/item/toy/crayon/red
	icon_state = "crayonred"
	colour = "#DA0000"
	shadeColour = "#810C0C"
	colourName = "red"

/obj/item/toy/crayon/orange
	icon_state = "crayonorange"
	colour = "#FF9300"
	shadeColour = "#A55403"
	colourName = "orange"

/obj/item/toy/crayon/yellow
	icon_state = "crayonyellow"
	colour = "#FFF200"
	shadeColour = "#886422"
	colourName = "yellow"

/obj/item/toy/crayon/green
	icon_state = "crayongreen"
	colour = "#A8E61D"
	shadeColour = "#61840F"
	colourName = "green"

/obj/item/toy/crayon/blue
	icon_state = "crayonblue"
	colour = "#00B7EF"
	shadeColour = "#0082A8"
	colourName = "blue"

/obj/item/toy/crayon/purple
	icon_state = "crayonpurple"
	colour = "#DA00FF"
	shadeColour = "#810CFF"
	colourName = "purple"

/obj/item/toy/crayon/mime
	icon_state = "crayonmime"
	desc = "A very sad-looking crayon."
	colour = "#FFFFFF"
	shadeColour = "#000000"
	colourName = "mime"
	uses = 0

/obj/item/toy/crayon/mime/attack_self(mob/living/user as mob) //inversion
	if(colour != "#FFFFFF" && shadeColour != "#000000")
		colour = "#FFFFFF"
		shadeColour = "#000000"
		user << "You will now draw in white and black with this crayon."
	else
		colour = "#000000"
		shadeColour = "#FFFFFF"
		user << "You will now draw in black and white with this crayon."
	return

/obj/item/toy/crayon/rainbow
	icon_state = "crayonrainbow"
	colour = "#FFF000"
	shadeColour = "#000FFF"
	colourName = "rainbow"
	uses = 0

/obj/item/toy/crayon/rainbow/attack_self(mob/living/user as mob)
	colour = input(user, "Please select the main colour.", "Crayon colour") as color
	shadeColour = input(user, "Please select the shade colour.", "Crayon colour") as color
	return

/obj/item/toy/crayon/afterattack(atom/target, mob/user as mob)
	if(istype(target,/turf/simulated/floor))
		var/drawtype = input("Choose what you'd like to draw.", "Crayon scribbles") in list("graffiti","rune","letter")
		switch(drawtype)
			if("letter")
				drawtype = input("Choose the letter.", "Crayon scribbles") in list("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")
				user << "You start drawing a letter on the [target.name]."
			if("graffiti")
				user << "You start drawing graffiti on the [target.name]."
			if("rune")
				user << "You start drawing a rune on the [target.name]."
		if(instant || do_after(user, 50))
			new /obj/effect/decal/cleanable/crayon(target,colour,shadeColour,drawtype)
			user << "You finish drawing."
			if(uses)
				uses--
				if(!uses)
					user << "\red You used up your crayon!"
					del(src)
	return

/obj/item/toy/crayon/attack(mob/M as mob, mob/user as mob)
	if(M == user)
		user << "You take a bite of the crayon. Delicious!"
		user.nutrition += 5
		if(uses)
			uses -= 5
			if(uses <= 0)
				user << "\red You ate your crayon!"
				del(src)
	else
		..()

/obj/effect/decal/cleanable/crayon
	name = "rune"
	desc = "A rune drawn in crayon."
	icon = 'rune.dmi'
	layer = 2.1
	anchored = 1


	examine()
		set src in view(2)
		..()
		return


	New(location,main = "#FFFFFF",shade = "#000000",var/type = "rune")
		..()
		loc = location

		name = type
		desc = "A [type] drawn in crayon."

		switch(type)
			if("rune")
				type = "rune[rand(1,6)]"
			if("graffiti")
				type = pick("amyjon","face","matt","revolution","engie","guy","end","dwarf","uboa")

		var/icon/mainOverlay = new/icon('crayondecal.dmi',"[type]",2.1)
		var/icon/shadeOverlay = new/icon('crayondecal.dmi',"[type]s",2.1)

		mainOverlay.Blend(main,ICON_ADD)
		shadeOverlay.Blend(shade,ICON_ADD)

		overlays += mainOverlay
		overlays += shadeOverlay