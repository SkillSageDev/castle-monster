extends State

@export var chase_state: State
@export var death_state: State

@onready var player = get_tree().get_first_node_in_group("player")
@onready var flip_container: Node2D = $"../../FlipContainer"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var monster_character_body_2d = owner
@onready var is_active = false


func enter():
	is_active = true
	if not player: return
	animation_player.play('attack')


func  exit():
	is_active = false


func update(_delta: float):
	if Global.monster_health ==0:
		transitioned.emit(self,death_state.name)


func _on_attack_vision_body_exited(body: Node2D) -> void:
	if is_active == true:
		transitioned.emit(self,chase_state.name)


func _on_attack_body_entered(body: Node2D) -> void:
	if is_active and body.is_in_group('player'):
		Global.player_health = Global.player_health -1
		print(Global.player_health)
