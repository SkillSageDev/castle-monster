extends State

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@export var walk_state: State
@export var death_state: State
func enter():
	animation_player.play('idle')
	var tween = create_tween()
	tween.tween_interval(5)
	tween.tween_callback(emit_transition)


func emit_transition():
	transitioned.emit(self,walk_state.name)


func update(_delta: float):
	if Global.monster_health ==0:
		transitioned.emit(self,death_state.name)