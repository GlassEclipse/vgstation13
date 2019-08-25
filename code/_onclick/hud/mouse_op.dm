/datum/hud/proc/mouse_op_hud(var/ui_style='icons/mob/screen1_Midnight.dmi')
	src.adding = list()
	src.other = list()
	ui_style = 'icons/mob/screen1_Midnight.dmi'

	var/obj/abstract/screen/using

	
	using = getFromPool(/obj/abstract/screen)
	using.name = "drop"
	using.icon = ui_style
	using.icon_state = "act_drop"
	using.screen_loc = ui_drop_throw
	using.layer = HUD_BASE_LAYER
	src.adding += using
	for(var/i = 1 to mymob.held_items.len) //Hands
		var/obj/abstract/screen/inventory/inv_box = getFromPool(/obj/abstract/screen/inventory)
		inv_box.name = "[mymob.get_index_limb_name(i)]"

		if(mymob.get_direction_by_index(i) == "right_hand")
			inv_box.dir = WEST
		else
			inv_box.dir = EAST

		inv_box.icon = ui_style 
		inv_box.icon_state = "hand_inactive"
		if(mymob && mymob.active_hand == i)
			inv_box.icon_state = "hand_active"
		inv_box.screen_loc = mymob.get_held_item_ui_location(i)
		inv_box.slot_id = null
		inv_box.hand_index = i
		inv_box.layer = HUD_BASE_LAYER
		//inv_box.color = new_color ? new_color : inv_box.color
		//inv_box.alpha = new_alpha ? new_alpha : inv_box.alpha
		src.hand_hud_objects += inv_box
		src.adding += inv_box
		
	//Pinpointer Graphic
	var/obj/abstract/screen/pinpointer_graphic = getFromPool(/obj/abstract/screen)
	pinpointer_graphic.name = "pinpointer"
	pinpointer_graphic.icon = ui_style 
	pinpointer_graphic.icon_state = "template"
	pinpointer_graphic.screen_loc = mymob.get_held_item_ui_location(2)
	pinpointer_graphic.layer = HUD_BASE_LAYER
	src.hand_hud_objects += pinpointer_graphic
	src.adding += pinpointer_graphic	

	mymob.healths = getFromPool(/obj/abstract/screen)
	mymob.healths.icon = ui_style
	mymob.healths.icon_state = "health0"
	mymob.healths.name = "health"
	mymob.healths.screen_loc = ui_health

	mymob.pullin = getFromPool(/obj/abstract/screen)
	mymob.pullin.icon = ui_style
	mymob.pullin.icon_state = "pull0"
	mymob.pullin.name = "pull"
	mymob.pullin.screen_loc = ui_pull_resist

	mymob.zone_sel = getFromPool(/obj/abstract/screen/zone_sel)
	mymob.zone_sel.icon = ui_style
	mymob.zone_sel.overlays.len = 0
	mymob.zone_sel.overlays += image('icons/mob/zone_sel.dmi', "[mymob.zone_sel.selecting]")
	mymob.client.reset_screen()

	mymob.client.screen += list(mymob.zone_sel, mymob.healths, mymob.pullin)
	mymob.client.screen += src.adding + src.other
