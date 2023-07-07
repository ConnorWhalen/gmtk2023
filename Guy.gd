extends KinematicBody2D

var INTENSITY = 100
var WIGGLE_INERTIA = 4
var MOVEMENT_INERTIA = 10

var wiggle_velocity = Vector2(0, 0)
var movement_velocity = Vector2(0, 0)
var velocity = Vector2(0, 0)

func _ready():
	pass

func _physics_process(delta):
	wiggle_velocity.x = (wiggle_velocity.x*WIGGLE_INERTIA + rand_range(-INTENSITY, INTENSITY)) / (WIGGLE_INERTIA+1)
	wiggle_velocity.y = (wiggle_velocity.y*WIGGLE_INERTIA + rand_range(-INTENSITY, INTENSITY)) / (WIGGLE_INERTIA+1)
	
	velocity = (velocity*MOVEMENT_INERTIA + movement_velocity) / (MOVEMENT_INERTIA+1)
	
	move_and_slide(velocity + wiggle_velocity)

func add_movement(velocity: Vector2):
	movement_velocity += velocity
