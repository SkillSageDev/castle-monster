extends Node2D

@export var win_scene : PackedScene
@export var lose_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Global.player_health == 0):
		get_tree().root.add_child(lose_scene.instantiate())
		get_tree().paused = true


func _on_exit_area_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):

		if Global.coins == 5:
			get_tree().root.add_child(win_scene.instantiate())
			get_tree().paused = true

			print("You Won")
