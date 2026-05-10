extends State

@export var min_distance = 3
@export var max_distance = 5
@export var speed = 100
@export var attack_state: State
@export var walk_state: State
@export var death_state: State

var player

@onready var nav_mesh_agent_2d: NavigationAgent2D = $"../../NavigationAgent2D"
@onready var flip_container: Node2D = $"../../FlipContainer"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var chase_time:Timer = $"../../ChaseTime"
@onready var monster_character_body_2d = owner
@onready var is_active = false


func enter():
    is_active = true
    player = get_tree().get_first_node_in_group("player")
    set_random_target()
    animation_player.play('walk')


func exit():
    is_active = false
    monster_character_body_2d.velocity = Vector2.ZERO


func physics_update(_delta: float):
    if not player: return

    if nav_mesh_agent_2d.is_navigation_finished():
        if is_active == true:
            monster_character_body_2d.velocity = Vector2.ZERO
            chase_time.stop()
            transitioned.emit(self,attack_state.name)
            return

    var next_path_position = nav_mesh_agent_2d.get_next_path_position()
    var direction = monster_character_body_2d.global_position.direction_to(next_path_position)
    monster_character_body_2d.velocity = direction * speed
    monster_character_body_2d.move_and_slide()


func update(_delta: float):
    
    if Global.monster_health ==0:
        chase_time.stop()
        transitioned.emit(self,death_state.name)

    var dist_to_target = player.global_position.distance_to(nav_mesh_agent_2d.target_position)
    if dist_to_target > max_distance:
        set_random_target()
    if not nav_mesh_agent_2d.is_navigation_finished():
        if monster_character_body_2d.velocity.x <-0.1:
            flip_container.scale.x = -1
        elif monster_character_body_2d.velocity.x > 0.1:
            flip_container.scale.x = 1


func set_random_target():
    if not player: return
    var random_angle = randf() *TAU
    var random_radius = randf_range(min_distance,max_distance)
    var target_vector = player.global_position + Vector2.from_angle(random_angle) * random_radius
    var map_rid = monster_character_body_2d.get_world_2d().navigation_map
    var final_point = NavigationServer2D.map_get_closest_point(map_rid,target_vector)
    nav_mesh_agent_2d.target_position = final_point


func _on_vision_body_exited(body: Node2D) -> void:
    if is_active and body.is_in_group('player'):
        chase_time.start()


func _on_vision_body_entered(body: Node2D) -> void:
     if is_active and body.is_in_group('player'):
        chase_time.stop()


func _on_chase_time_timeout() -> void:
    transitioned.emit(self,walk_state.name)


func _on_attack_vision_body_entered(body: Node2D) -> void:
     if is_active and body.is_in_group('player'):
        chase_time.stop()
        transitioned.emit(self,attack_state.name)
