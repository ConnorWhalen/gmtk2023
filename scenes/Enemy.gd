extends Node2D

onready var BulletScene = preload("res://scenes/Bullet.tscn")

export(float) var interval = 1
export(int) var shoot_directions = 8

var BULLET_SPEED = 150

var bullets = []

func _ready():
	$ShootTimer.wait_time = 1
	$ShootTimer.start()


func _process(delta):
	for bullet_index in range(bullets.size()-1, -1, -1):
		var bullet = bullets[bullet_index]
		if bullet.collided:
			bullets.remove(bullet_index)
			remove_child(bullet)


func shoot():
	var offset = rand_range(0, 360)
	for i in range(shoot_directions):
		var bullet = BulletScene.instance()
		
		bullet.velocity = Vector2(BULLET_SPEED, 0).rotated(deg2rad((i * 360/shoot_directions) + offset))
		
		bullets.append(bullet)
		add_child(bullet)


func _on_ShootTimer_timeout():
	shoot()
	$ShootTimer.wait_time = interval
	$ShootTimer.one_shot = false
	$ShootTimer.start()
