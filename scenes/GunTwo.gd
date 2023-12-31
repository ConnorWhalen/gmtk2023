extends Node2D

onready var BulletScene = preload("res://scenes/BigBullet.tscn")

export(float) var interval = 0.75

var BULLET_SPEED = 300
var animation_float = 3.0
var shoot_ready = true
var targetPosition = Vector2(0.0, 0.0)
var targetVelocity = Vector2(0.0, 0.0)

var bullets = []

func _ready():
	$ShootTimer.wait_time = 1
	$ShootTimer.start()

func _process(delta):
	var targetDistance = Vector2(position.y - targetPosition.y, position.x - targetPosition.x).length()
	var predictedTarget = Vector2(targetPosition.x + targetVelocity.x/500.0 * targetDistance, targetPosition.y + targetVelocity.y/500.0 * targetDistance)
	$Icon.rotation = atan2(position.y - predictedTarget.y, position.x - predictedTarget.x) - PI / 2
	animation_float += delta * 10.0
	$Icon.frame = int(min(animation_float, 3.0))
	if ($Icon.frame == 2) and shoot_ready:
		shoot()
		shoot_ready = false
	if ($Icon.frame == 3):
		shoot_ready = true
	for bullet_index in range(bullets.size()-1, -1, -1):
		var bullet = bullets[bullet_index]
		if bullet.collided:
			bullets.remove(bullet_index)
			remove_child(bullet)


func shoot():
	var bullet = BulletScene.instance()
	bullet.velocity = Vector2(BULLET_SPEED, 0).rotated($Icon.rotation - PI / 2)
	bullet.position += Vector2(BULLET_SPEED, 0).rotated($Icon.rotation - PI / 2) * 0.4
	bullets.append(bullet)
	add_child(bullet)

func set_target(inTargetPosition: Vector2, inTargetVelocity: Vector2):
	targetPosition = inTargetPosition
	targetVelocity = inTargetVelocity

func _on_ShootTimer_timeout():
	animation_float = 0.0
	$ShootTimer.wait_time = interval
	$ShootTimer.one_shot = false
	$ShootTimer.start()
