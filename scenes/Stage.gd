extends Node2D


signal mode_menu


func _ready():
	pass


func _process(delta):
	pass


func _on_StageCommon_exit_stage():
	emit_signal("mode_menu")
