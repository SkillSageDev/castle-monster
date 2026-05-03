extends Control
signal jojo
@onready var quit_button = $CanvasLayer/MarginContainer/VBoxContainer/Quit
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	quit_button.pressed.connect(_on_quit_pressed)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_quit_pressed():
	get_tree().quit()


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")
