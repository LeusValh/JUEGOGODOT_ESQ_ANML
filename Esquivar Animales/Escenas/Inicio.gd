extends Control



func _ready():
	OS.center_window()


func _on_Button_pressed():
	get_tree().change_scene("res://Escenas/Main.tscn")
