extends Node2D

export(PackedScene) var Enemigo_scene
export(PackedScene) var Enemigo2
export(PackedScene) var Clouds
export(PackedScene) var Fresa

signal startgame
signal losegame

var score
var Pfresa = 0
var score_max = 0
var Pfresa_max = 0


func _ready():
	$Mainsong.play()
	new_game()
	randomize()
	set_fresa_spawn()
	$GUI/GameOver.visible = false
	$GUI/Rejugar.visible = false
	$GUI/Inicio.visible = false


func _on_Jugador_hit():
	$PuntosTimer.stop()
	$EnemyTimer.stop()
	$SEnemyTimer.stop()
	$FresaTimer.stop()
	emit_signal("losegame")
	$Losesong.play()
	$GUI/GameOver.visible = true
	$GUI/Rejugar.visible = true
	$GUI/Inicio.visible = true


func new_game():
	$InicioTimer.start()
	score = 0
	Pfresa = 0
	$GUI.update_frutillas(Pfresa)
	$GUI.update_score(score)
	emit_signal("startgame")

func _on_PuntosTimer_timeout():
	score += 1
	if score >= 999:
		score = 999
	$GUI.update_score(score)
	$Scoresong.play()


func _on_InicioTimer_timeout():
	$EnemyTimer.start()
	$SEnemyTimer.start()
	$CloudTimer.start()
	$PuntosTimer.start()
	$FresaTimer.start()


#GENERAR ENEMIGOS Y NUBES ALEATOREAS POR EL MAPA 
func _on_EnemyTimer_timeout():
	
	$MobPath/MobPathLocation.offset = randi()
	var mob = Enemigo_scene.instance()
	add_child(mob)
	var direction = $MobPath/MobPathLocation.rotation + PI / 2
	mob.position = $MobPath/MobPathLocation.position
	
	direction += rand_range(-PI / 4, PI / 4)
	#DIRECCION Y VELOCIDAD
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)


func _on_SEnemyTimer_timeout():
	var mob2 = Enemigo2.instance()
	add_child(mob2)
	var direct = $MobPath2/MobPathLocation2.rotation + PI / 2
	mob2.position = $MobPath2/MobPathLocation2.position
	
	direct += rand_range(-PI /4, PI /4)
	#DIRECCION Y VELOCIDAD
	mob2.linear_velocity = Vector2(rand_range(mob2.min_speed, mob2.max_speed), 0)
	mob2.linear_velocity = mob2.linear_velocity.rotated(direct)


func _on_CloudTimer_timeout():
	$CloudPath/CloudPathLocation.offset	= randi()
	var cloud = Clouds.instance()
	add_child(cloud)
	var direc = $MobPath/MobPathLocation.rotation + PI / 2
	cloud.position = $MobPath/MobPathLocation.position
	
	direc += rand_range(-PI / 4, PI / 4)
	#DIRECCION Y VELOCIDAD
	cloud.linear_velocity = Vector2(rand_range(cloud.min_speed, cloud.max_speed), 0)
	cloud.linear_velocity = cloud.linear_velocity.rotated(direc)


#FUNCIONAMIENTO DE LAS FRESAS

func set_fresa_spawn():
	var interval = rand_range(5, 10)
	$FresaTimer.wait_time = interval
	$FresaTimer.start()


func _on_FresaTimer_timeout():
	$FresaTimer.stop()
	var fres = Fresa.instance()
	fres.position.x = rand_range(40, 430)
	fres.position.y = rand_range(110, 630)
	$ContenedorF.add_child(fres)
	set_fresa_spawn()


func _on_Jugador_picked():
	Pfresa += 1
	if Pfresa >= 99:
		Pfresa = 99
	$GUI.update_frutillas(Pfresa)
	$Frutillasong.play()


func _on_Rejugar_pressed():
	$GUI/GameOver.visible = false
	$GUI/Rejugar.visible = false
	$GUI/Inicio.visible = false
	new_game()

#MANDAR A LA PANTALLA INICIAL DEL JUEGO
func _on_Inicio_pressed():
	pass 


func _on_Jugador_run():
	pass
