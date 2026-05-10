extends Node

var monster_health = 100


var player_health: int = 4:
    set(value):
        player_health = clamp(value, 0, 10)

var coins = 0;