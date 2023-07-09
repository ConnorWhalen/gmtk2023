extends KinematicBody2D

var SFX_FILES = [
	"gmtk2023_1#01.wav",
	"gmtk2023_1#03.3.wav",
	"gmtk2023_1#03.7.wav",
	"gmtk2023_1#03.11.wav",
	"gmtk2023_1#03.12.wav",
	"gmtk2023_1#03.15.wav",
	"gmtk2023_1#03.18.wav",
]

var INTENSITY = 100
var WIGGLE_INERTIA = 4
var MOVEMENT_INERTIA = 10

var wiggle_velocity = Vector2(0, 0)
var movement_velocity = Vector2(0, 0)
var velocity = Vector2(0, 0)
var animation_float = 0.0

var dead = false
var dispose = false
var won = false

var sfx_node
var sfx_cheer_node

func _ready():
	animation_float = rand_range(0.0, 0.25)
	

func _process(delta):
	animation_float += delta
	$Icon.frame = int(animation_float / 0.25) % 4
	
	var sfx_index = randi() % 7
	sfx_node = get_node("SFXPlayer" + str(sfx_index))
	
	var sfx_cheer_index = randi() % 6
	sfx_cheer_node = get_node("SFXCheerPlayer" + str(sfx_cheer_index))

func _physics_process(delta):
	if not dead:
		animation_float += delta * (velocity.length() / 200.0)

		wiggle_velocity.x = (wiggle_velocity.x*WIGGLE_INERTIA + rand_range(-INTENSITY, INTENSITY)) / (WIGGLE_INERTIA+1)
		wiggle_velocity.y = (wiggle_velocity.y*WIGGLE_INERTIA + rand_range(-INTENSITY, INTENSITY)) / (WIGGLE_INERTIA+1)
		
		velocity = (velocity*MOVEMENT_INERTIA + movement_velocity) / (MOVEMENT_INERTIA+1)
		move_and_slide(velocity + wiggle_velocity)
		
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.collider.is_in_group("Bullet"):
				collision.collider.hit()
				hit()
	if dead:
		animation_float += delta
		$DeadIcon.frame = int(min(animation_float / 0.25, 11.0))
		

func add_movement(velocity: Vector2):
	movement_velocity += velocity

func hit():
	sfx_node.play()
	
	animation_float = 0.0
	dead = true
	$Icon.visible = false
	$DeadIcon.frame = 0
	$DeadIcon.visible = true
	$CollisionShape2D.disabled = true
	

func win():
	sfx_cheer_node.play()
	won = true
	
