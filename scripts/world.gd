extends Node2D

@export var win_scene : PackedScene
@export var lose_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Global.player_health <= 0):
		get_tree().change_scene_to_file("res://scenes/lose_scene.tscn")


func _on_exit_area_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		if Global.coins == 5:
			get_tree().change_scene_to_file("res://scenes/win_scene.tscn")

			print("You Won")
