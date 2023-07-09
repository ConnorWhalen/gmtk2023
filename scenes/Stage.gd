extends Node2D

signal mode_menu
signal mode_win


func _ready():
	pass


func _process(delta):
	var GunTwos = get_tree().get_nodes_in_group("GunTwo")
	for gunTwo in GunTwos:
		gunTwo.set_target($StageCommon/Cluster.center_of_mass)

func _on_StageCommon_exit_stage(game_complete):
	if game_complete:
		emit_signal("mode_win")
	else:
		emit_signal("mode_menu")
