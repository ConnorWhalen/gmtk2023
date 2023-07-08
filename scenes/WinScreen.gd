extends Node2D

signal mode_menu

var input_debounce = true

func _ready():
	var save_stats = Save.pull_stats()
	var score = save_stats["score"]
	var high_score = save_stats["high_score"]
	if score > high_score:
		Save.save_data["high_score"] = score
		Save.push_stats()
		high_score = score
	
	$ScoreLabel2.text = str(score)
	$ScoreLabel4.text = str(high_score)
	
	
	Save.save_data["score"] = 100
	Save.save_data["stages_complete"] = 0
	Save.push_stats()


func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		if not input_debounce:
			emit_signal("mode_menu")
	else:
		input_debounce = false
