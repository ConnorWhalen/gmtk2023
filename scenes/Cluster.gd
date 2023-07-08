extends KinematicBody2D


onready var GuyScene = preload("res://scenes/Guy.tscn")

var GUY_DISTANCE = 12.5
var CLUSTER_SPEED = 500
var MOVEMENT_INERTIA = 20

var guys = []
var movement_velocity = Vector2(0, 0)
var velocity = Vector2(0, 0)
var center_of_mass = Vector2(0, 0)

var input_right = false
var input_left = false
var input_down = false
var input_up = false
var input_enter = true

var gather_cooldown = false


func _ready():
	pass

func init(guy_count):
	var guy_row_length = int(sqrt(guy_count))
	for i in range(guy_count):
		var guy = GuyScene.instance()
		
		var x_index = i / int(sqrt(guy_count))
		var y_index = i % int(sqrt(guy_count))
		
		guy.position.x += (x_index - (guy_row_length)/2) * GUY_DISTANCE
		guy.position.y += (y_index - (guy_row_length)/2) * GUY_DISTANCE
		
		guys.append(guy)
		add_child(guy)

func _physics_process(delta):
	# input
	if Input.is_action_pressed("ui_right"):
		if not input_right:
			move_guys(Vector2(1, 0))
		input_right = true
	else:
		if input_right:
			move_guys(Vector2(-1, 0))
		input_right = false
		
	if Input.is_action_pressed("ui_left"):
		if not input_left:
			move_guys(Vector2(-1, 0))
		input_left = true
	else:
		if input_left:
			move_guys(Vector2(1, 0))
		input_left = false
		
	if Input.is_action_pressed("ui_down"):
		if not input_down:
			move_guys(Vector2(0, 1))
		input_down = true
	else:
		if input_down:
			move_guys(Vector2(0, -1))
		input_down = false
		
	if Input.is_action_pressed("ui_up"):
		if not input_up:
			move_guys(Vector2(0, -1))
		input_up = true
	else:
		if input_up:
			move_guys(Vector2(0, 1))
		input_up = false
		
	if Input.is_action_pressed("ui_accept"):
		if not input_enter:
			gather()
		input_enter = true
	else:
		if input_enter:
			pass # released
		input_enter = false

	# velocity = (velocity*MOVEMENT_INERTIA + movement_velocity) / (MOVEMENT_INERTIA+1)
	# move_and_slide(velocity)
	
	# move cluster to guys center of mass
	if guys.size() > 0:
		var guys_pos = Vector2(0, 0)
		var alive_count = 0
		for guy in guys:
			if not guy.dead:
				guys_pos += guy.global_position
				alive_count += 1
		center_of_mass = guys_pos / alive_count


func move_guys(direction: Vector2):
	add_movement(direction * CLUSTER_SPEED)
	for guy in guys:
		guy.add_movement(direction * CLUSTER_SPEED)


func add_movement(velocity: Vector2):
	movement_velocity += velocity


func gather():
	if not gather_cooldown:
		for guy in guys:
			if not guy.dead:
				guy.position = center_of_mass
		gather_cooldown = true
		$GatherTimer.start()


func dead():
	var alive_count = 0
	for guy in guys:
		if not guy.dead:
			alive_count += 1
	return alive_count == 0


func count_winners():
	var count = 0
	for guy in guys:
		if guy.won and not guy.dead:
			count += 1
	return count


func _on_GatherTimer_timeout():
	gather_cooldown = false
	for _i in range(2):
		visible = false
		yield(get_tree().create_timer(0.1, false), "timeout")
		visible = true
		yield(get_tree().create_timer(0.1, false), "timeout")
	
