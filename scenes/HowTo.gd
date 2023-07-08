extends Node2D


signal mode_menu


func _ready():
	pass


func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		emit_signal("mode_menu")
