extends Node2D

signal exit_stage

export(int) var win_area_x = 0
export(int) var win_area_y = 0
export(int) var win_area_w = 100
export(int) var win_area_h = 100

var keeping_score = true
var game_complete = false

func _ready():
	var save_stats = Save.pull_stats()
	$Cluster.init(save_stats["score"])
	
	$WinArea.position = Vector2(win_area_x, win_area_y)
	$WinArea/CollisionShape2D.shape.set_extents(Vector2(win_area_w, win_area_h))


func _process(delta):
	$Camera2D.position = $Cluster.center_of_mass
	
	if $Cluster.dead():
		lose()
	
	if keeping_score:
		$Camera2D/ScoreLabel.text = str($Cluster.count_winners())


func lose():
	$Camera2D/LoseLabel.visible = true
	
	set_save(10, false)
	
	$EndTimer.start()


func set_save(score, stage_won):
	var save_stats = Save.pull_stats()
	save_stats["score"] = score
	if stage_won:
		save_stats["stages_complete"] += 1
	else:
		save_stats["stages_complete"] = 0
	Save.save_data = save_stats
	Save.push_stats()
	
	return save_stats["stages_complete"] == 5


func _on_EndTimer_timeout():
	emit_signal("exit_stage", game_complete)


func _on_WinTimer_timeout():
	$Camera2D/ScoreLabel.rect_scale *= 0.8
	
	keeping_score = false
	
	if set_save($Cluster.count_winners(), true):
		game_complete = true
	
	$EndTimer.start()
