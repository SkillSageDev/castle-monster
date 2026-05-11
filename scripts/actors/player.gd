extends CharacterBody2D


@export var walk_speed: float = 100.0 #movement speed
@export var sprint_speed: float = 300.0 # sprint_speed

var _speed: float = walk_speed #dont touch it, this is changes automaticlly

var direction:Vector2

@onready var animated_sprite2D = $AnimatedSprite2D
@onready var sfx_walk = $Sounds/sfx_walk
@onready var sfx_dead = $Sounds/sfx_death

@export var max_health: int = 4
var health: int

var anim


func _ready() -> void:
	animated_sprite2D.play('idle')
	health = max_health

func _process(delta: float) -> void:

	if health <= 0:
		anim = 'die'
		isdead()
		return

	anim ='walk' if direction.length()>0 else 'idle'

	if animated_sprite2D.animation != anim:
		animated_sprite2D.play(anim)

	if direction.x !=0:
		animated_sprite2D.flip_h = direction.x<0

	_speed = sprint_speed if Input.is_action_pressed('sprint') else walk_speed

	if direction.length() >0:
		if not sfx_walk.playing:
			sfx_walk.play()
			sfx_walk.volume_db = 10
	else:
		if sfx_walk.playing:
			var tween = create_tween()
			tween.tween_property(sfx_walk,"volume_db", -80,0.1)
			tween.tween_callback(sfx_walk.stop)


func _physics_process(delta: float) -> void:
	if health <=0:
		velocity = Vector2.ZERO
		move_and_slide()
		return	

	direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = direction.normalized()*_speed
	move_and_slide()

func isdead():
	if animated_sprite2D.animation !=anim:
		animated_sprite2D.play('die')
		sfx_walk.stop()
		sfx_dead.play()
