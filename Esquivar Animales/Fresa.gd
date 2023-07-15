extends Area2D


func _ready():

	$animacion.interpolate_property(
		$AnimatedSprite,
		"scale",
		$AnimatedSprite.scale,
		$AnimatedSprite.scale * 2,
		0.3,Tween.TRANS_QUART,
		Tween.EASE_IN_OUT
	)
	$animacion.interpolate_property(
		$AnimatedSprite,
		"modulate",
		Color(1, 1, 1, 1),
		Color(1, 1, 1, 0),
		0.3,Tween.TRANS_QUART,
		Tween.EASE_IN_OUT
	)

func pickup():
	$animacion.start()
	yield($animacion,"tween_completed")
	$Frutilla.play()
	queue_free()


func _on_LifeTimer_timeout():
	queue_free()
