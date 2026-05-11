extends CanvasLayer

@export var start_menu : PackedScene
@onready var click_sound = $Sounds/ClickSound
@onready var hover_sound = $Sounds/HoverSound

func _on_retry_pressed() -> void:
	click_sound.play()
	await get_tree().create_timer(0.5, true).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_back_pressed() -> void:
	click_sound.play()
	await get_tree().create_timer(0.5, true).timeout
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
	


func _on_retry_mouse_entered() -> void:
	hover_sound.play()


func _on_back_mouse_entered() -> void:
	hover_sound.play()
