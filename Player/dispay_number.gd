extends Node

func display_number(value: int, position: Vector2, is_aoe = false, is_melee = false, is_jump_melee = false, is_move_melee = false):
	var number = Label.new()
	number.global_position = position
	number.text = str(value)
	number.z_index = 5
	number.label_settings = LabelSettings.new()
	
	var color = "#FFF"
	if is_aoe:
		color = "B22"
	if is_melee:
		color = "#82610f"
	if is_jump_melee:
		color = "#9e9b9b"
	if is_move_melee:
		color = "#9e9b9b"
		
	number.label_settings.font_color = color
	number.label_settings.font_size = 25
	number.label_settings.outline_color = "#000"
	number.label_settings.outline_size = 10
	
	call_deferred("add_child", number)
	
	await number.resized
	number.pivot_offset = Vector2(number.size / 2)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(number, "position:y", number.position.y - 24, 0.5).set_ease(Tween.EASE_OUT)
	tween.tween_property(number, "position:y", number.position.y, 0.75).set_ease(Tween.EASE_IN).set_delay(0.5)
	tween.tween_property(number, "scale", Vector2.ZERO, 0.5).set_ease(Tween.EASE_IN).set_delay(0.5)
	
	await tween.finished
	number.queue_free()
	
