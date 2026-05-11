extends CanvasLayer

@onready var heart : AnimatedSprite2D = $Control/UI/Heart
@onready var coin_count = $Control/UI/Coins/CoinCount
func _process(delta: float) -> void:
	heart.frame = Global.player_health
	coin_count.text = "{coins}".format({"coins": Global.coins})
