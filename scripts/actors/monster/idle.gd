extends State

@export var walk_state: State
@export var chase_state: State
@export var death_state: State

var player
var is_active

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"


func enter():
	player = get_tree().get_first_node_in_group("player")
	is_active = true
	animation_player.play('idle')
	var tween = create_tween()
	tween.tween_interval(5)
	tween.tween_callback(emit_transition)


func update(_delta: float):
	if Global.monster_health ==0:
		transitioned.emit(self,death_state.name)


func exit():
	is_active = false


func emit_transition():
	transitioned.emit(self,walk_state.name)


func _on_vision_body_entered(body: Node2D) -> void:
	if is_active and body.is_in_group('player'):
		transitioned.emit(self, chase_state.name)
