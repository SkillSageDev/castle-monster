extends State
@onready var nav_mesh_agent_2d: NavigationAgent2D = $"../../NavigationAgent2D"
@onready var flip_container: Node2D = $"../../FlipContainer"
var player
@onready var monster_character_body_2d = owner
@onready var is_active = false
@export var min_distance = 3
@export var max_distance = 5
@export var speed = 190
@export var idle_state: State

func enter():
    is_active = true
    player = get_tree().get_first_node_in_group("player")
    set_random_target()

func exit():
    is_active = false

func physics_update(_delta: float):
    if not player: return

    if nav_mesh_agent_2d.is_navigation_finished():
        if is_active == true:
            monster_character_body_2d.velocity = Vector2.ZERO
            transitioned.emit(self,idle_state.name)
            return

    var next_path_position = nav_mesh_agent_2d.get_next_path_position()
    var direction = monster_character_body_2d.global_position.direction_to(next_path_position)
    monster_character_body_2d.velocity = direction * speed
    monster_character_body_2d.move_and_slide()


func update(_delta: float):
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




"""
# --- THE RANGE CHECK ---
    # Check how far the player is from the monster's current destination
    var dist_to_target = player.global_position.distance_to(nav_mesh_agent_2d.target_position)
    
    # If player is outside the max_distance, the target is "stale." Reset it.
    if dist_to_target > max_distance:
        set_random_target()
    # -----------------------
"""