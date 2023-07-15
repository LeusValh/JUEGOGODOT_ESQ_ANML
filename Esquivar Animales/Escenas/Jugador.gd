extends Area2D

signal hit
signal picked
signal run

var speed = 210
var velocity = Vector2.ZERO
var screen_size

#CONTROL TACTIL
var touch_left = false
var touch_right = false
var touch_up = false
var touch_down = false
var touch_power = false

func _ready():
	
	screen_size = get_viewport_rect().size
	OS.center_window()
	position = Vector2(240, 450)
	$CacareoTimer.start()

func _process(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_left") or touch_left:
		velocity.x = -1
	if Input.is_action_pressed("ui_right") or touch_right:
		velocity.x = 1
	if Input.is_action_pressed("ui_up") or touch_up:
		velocity.y = -1
	if Input.is_action_pressed("ui_down") or touch_down:
		velocity.y = 1
	if Input.is_action_pressed("ui_select") or touch_power:
		chicken_runner()
		emit_signal("run")

	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed * delta
	position += velocity

	if position.x >= 470:
		position.x = 470
	if position.x <= 25:
		position.x = 25
	if position.y >= 660:
		position.y = 660
	if position.y <= 140:
		position.y = 140
	
	# ANIMACIONES DEL PERSONAJE
	if velocity.length() != 0:
		$AnimatedSprite.play("run")
		if velocity.x < 0:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.play("idle")


func _on_Jugador_body_entered(body):	
	set_process(false)
	$AnimatedSprite.play("die")
	emit_signal("hit")
	$Mainsong.stop()
	$Hitsong.play()
	#$CollisionShape2D.set_deferred("disabled", true)
	$CacareoTimer.stop()


func _on_CacareoTimer_timeout():
	$cacareo.play()

#BOTON IZQUIERDA
func _on_Biz_pressed():
	touch_left = true

func _on_Biz_released():
	touch_left = false

#BOTON DERECHA
func _on_Bde_pressed():
	touch_right = true

func _on_Bde_released():
	touch_right = false

#BOTON ARRIBA
func _on_Bar_pressed():
	touch_up = true

func _on_Bar_released():
	touch_up = false

#BOTON ABAJO
func _on_Bab_pressed():
	touch_down = true

func _on_Bab_released():
	touch_down = false

#BOTON CORRER
func _on_Bco_pressed():
	touch_power = true
	
func _on_Bco_released():
	touch_power = false


func _on_Jugador_area_entered(area):
	if area.is_in_group("fresa"):
		emit_signal("picked")
		$frutillasong.play()
		area.pickup()


#RECUPERAR LAS FUNCIONES DEL JUEGO AL TOCAR EN REJUGAR
func _on_Rejugar_pressed():
	set_process(true)
	$Mainsong.play()
	$AnimatedSprite.play("idle")
	$CacareoTimer.start()

func chicken_runner():
	speed = 500
	var intrval = rand_range(0.5, 1)
	$RunTimer.wait_time = intrval
	$RunTimer.start()


func _on_RunTimer_timeout():
	$RunTimer.stop()
	speed = 210
	

func _on_Main_losegame():
	$Losesong.play()


func _on_Main_startgame():
	$Mainsong.play()
