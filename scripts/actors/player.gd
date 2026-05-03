extends CharacterBody2D


@export var walk_speed: float = 100.0 #movement speed
@export var sprint_speed: float = 300.0 # sprint_speed

var _speed: float = walk_speed #dont touch it, this is changes automaticlly

var direction:Vector2

@onready var animated_sprite2D = $AnimatedSprite2D

var anim


func _ready() -> void:
	animated_sprite2D.play('idle')

func _process(delta: float) -> void:

	anim = 'walk' if direction.length()>0 else 'idle'

	if animated_sprite2D.animation != anim:
		animated_sprite2D.play(anim)

	if direction.x !=0:
		animated_sprite2D.flip_h = direction.x<0

	_speed = sprint_speed if Input.is_action_pressed('sprint') else walk_speed


func _physics_process(delta: float) -> void:
	direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = direction.normalized()*_speed
	move_and_slide()
