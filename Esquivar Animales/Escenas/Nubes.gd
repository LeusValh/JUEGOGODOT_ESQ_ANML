extends RigidBody2D

export var min_speed = 90
export var max_speed = 110
var velocity = Vector2.ZERO


func _ready():
	var cloud_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = cloud_types[ randi() % cloud_types.size()]


func _on_VisibilityEnabler2D_screen_exited():
	queue_free()
