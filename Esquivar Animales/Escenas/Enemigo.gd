extends RigidBody2D

export var min_speed = 240
export var max_speed = 340


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_VisibilityEnabler2D_screen_exited():
	queue_free()


