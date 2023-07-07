extends Node2D

onready var BulletScene = preload("res://scenes/Bullet.tscn")

var bullets = []

func _ready():
	pass


func _process(delta):
	for bullet_index in range(bullets.size()-1, -1, -1):
		var bullet = bullets[bullet_index]
		if bullet.collided:
			bullets.remove(bullet_index)
			remove_child(bullet)


func shoot():
	var offset = rand_range(0, 360)
	for i in range(8):
		var bullet = BulletScene.instance()
		
		bullet.velocity = Vector2(100, 0).rotated(deg2rad((i * 45) + offset))
		
		bullets.append(bullet)
		add_child(bullet)


func _on_ShootTimer_timeout():
	shoot()
