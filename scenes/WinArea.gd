extends Area2D

var started = false

func _ready():
	pass


func _process(delta):
	pass


func win():
	started = true
	$WinTimer.start()
	
	var label = get_node("../Camera2D/ScoreLabel")
	label.visible = true


func _on_WinArea_body_entered(body):
	if body.is_in_group("Guy"):
		body.win()
		if not started:
			win()
	if body.is_in_group("Bullet"):
		body.hit()
