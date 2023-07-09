extends KinematicBody2D

var velocity = Vector2(0,0)
var collided = false

func _ready():
	pass


func _physics_process(delta):
	position += velocity * delta
	for i in get_slide_count():
		var collision = get_slide_collision(i)

func hit():
	pass
