extends KinematicBody2D

var velocity = Vector2(0,0)
var collided = false

func _ready():
	pass


func _physics_process(delta):
	move_and_slide(velocity)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
	
	if (global_position.x > 6000 or global_position.x < -3000 or 
		global_position.y > 2000 or global_position.y < -5000):
		collided = true

func hit():
	collided = true

func kill():
	hit()
