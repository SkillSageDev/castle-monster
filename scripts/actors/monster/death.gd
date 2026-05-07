extends State

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var monster_character_body_2d = owner

func enter():
	animation_player.play("death")
	monster_character_body_2d.velocity = Vector2.ZERO
