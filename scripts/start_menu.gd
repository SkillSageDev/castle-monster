extends Control

@onready var quit_button = $CanvasLayer/MarginContainer/VBoxContainer/Quit
@onready var click_sound = $Sounds/ClickSound
@onready var hover_sound = $Sounds/HoverSound

func _ready() -> void:
	quit_button.pressed.connect(_on_quit_pressed)

func _on_quit_pressed():
	click_sound.play()
	await get_tree().create_timer(0.5, true).timeout
	get_tree().quit()


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")
	click_sound.play()


func _on_start_mouse_entered() -> void:
	hover_sound.play()


func _on_quit_mouse_entered() -> void:
	hover_sound.play()


func _on_start_button_down() -> void:
	click_sound.play()
