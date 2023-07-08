extends Node2D

signal mode_stage
signal mode_howto

var score
var high_score
var stages_complete

var input_debounce = true

func _ready():
	var save_stats = Save.pull_stats()
	score = save_stats["score"]
	high_score = save_stats["high_score"]
	stages_complete = save_stats["stages_complete"]
	
#	if stages_complete >= 5:
#		stages_complete = 0
#		Save.save_data["stages_complete"] = 0
#		Save.push_stats()
	
	$ScoreLabel2.text = str(score)
	$StageLabel2.text = str(stages_complete + 1)
	if high_score > 0:
		$HighScoreLabel2.text = str(high_score)
		$HighScoreLabel.visible = true
		$HighScoreLabel2.visible = true


func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		if not input_debounce:
			emit_signal("mode_stage", stages_complete)
	else:
		input_debounce = false
	


func _on_PlayButton_pressed():
	emit_signal("mode_stage", stages_complete)


func _on_HowToButton_pressed():
	emit_signal("mode_howto")
