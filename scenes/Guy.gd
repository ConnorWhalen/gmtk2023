extends KinematicBody2D

var INTENSITY = 100
var WIGGLE_INERTIA = 4
var MOVEMENT_INERTIA = 10

var wiggle_velocity = Vector2(0, 0)
var movement_velocity = Vector2(0, 0)
var velocity = Vector2(0, 0)

var dead = false
var dispose = false
var won = false

func _ready():
	pass

func _physics_process(delta):
	if not dead:
		wiggle_velocity.x = (wiggle_velocity.x*WIGGLE_INERTIA + rand_range(-INTENSITY, INTENSITY)) / (WIGGLE_INERTIA+1)
		wiggle_velocity.y = (wiggle_velocity.y*WIGGLE_INERTIA + rand_range(-INTENSITY, INTENSITY)) / (WIGGLE_INERTIA+1)
		
		velocity = (velocity*MOVEMENT_INERTIA + movement_velocity) / (MOVEMENT_INERTIA+1)
		
		move_and_slide(velocity + wiggle_velocity)
		
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.collider.is_in_group("Bullet"):
				collision.collider.hit()
				hit()

func add_movement(velocity: Vector2):
	movement_velocity += velocity

func hit():
	dead = true
	$Icon.visible = false
	$DeadIcon.visible = true
	$DeathTimer.start()

func win():
	won = true

func _on_DeathTimer_timeout():
	dispose = true
