extends Area2D

var started = false

func _ready():
	pass


func _process(delta):
	pass


func hit():
	$WinTimer.start()


func _on_WinArea_body_entered(body):
	if body.is_in_group("Guy"):
		body.win()
		if not started:
			started = true
			$WinTimer.start()
	if body.is_in_group("Bullet"):
		body.hit()
