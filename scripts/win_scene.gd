extends CanvasLayer

@export var start_menu : PackedScene

func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_back_pressed() -> void:
	get_tree().change_scene_to_packed(start_menu)
