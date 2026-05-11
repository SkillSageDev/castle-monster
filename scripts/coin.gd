extends Area2D

@onready var coin_collected:AudioStreamPlayer2D = $CoinCollected
@onready var coin_animation : AnimatedSprite2D = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	coin_animation.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('player'):
		Global.coins +=1
		remove_child(coin_collected)
		get_tree().root.add_child(coin_collected)
		coin_collected.play()
		coin_collected.finished.connect(coin_collected.queue_free)
		print("coin added: " + str(Global.coins))
		queue_free()
