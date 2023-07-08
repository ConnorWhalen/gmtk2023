extends Node2D


signal mode_menu
signal mode_win


func _ready():
	pass


func _process(delta):
	pass


func _on_StageCommon_exit_stage(game_complete):
	if game_complete:
		emit_signal("mode_win")
	else:
		emit_signal("mode_menu")
