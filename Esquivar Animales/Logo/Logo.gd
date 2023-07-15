extends Control

func _ready():
	OS.center_window()
	$MusicInt.play()
	
	$ImgLogo/anim.interpolate_property(
		$ImgLogo/Sprite,
		"scale",
		$ImgLogo/Sprite.scale,
		$ImgLogo/Sprite.scale * 2,
		1,Tween.TRANS_QUART,
		Tween.EASE_IN_OUT
	)
	
	$ImgLogo/anim.interpolate_property(
		$ImgLogo/Sprite,
		"modulate",
		Color(1, 1, 1, 1),
		Color(1, 1, 1, 0),
		1,Tween.TRANS_QUART,
		Tween.EASE_IN_OUT
	)
	
	$Scn.interpolate_property(
		$Label,
		"modulate",
		Color(1, 1, 1, 1),
		Color(1, 1, 1, 0),
		1,Tween.TRANS_QUART,
		Tween.EASE_IN_OUT
	)
	
func _on_LogoTimer_timeout():
	$ImgLogo/anim.start()
	$Scn.start()
	yield($ImgLogo/anim,"tween_completed")
	yield($Scn,"tween_completed")
	get_tree().change_scene("res://Escenas/Inicio.tscn")
