extends Node2D

signal mode_menu


func _ready():
	pass


func _process(delta):
	$Camera2D.position = $Cluster.position
	
	if $Cluster.dead():
		$EndTimer.start()


func _on_EndTimer_timeout():
	emit_signal("mode_menu")


func _on_WinTimer_timeout():
	print("SCORE: " + str($Cluster.count_winners()))
	$EndTimer.start()
