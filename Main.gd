extends Node2D




func _ready():
	pass


func _process(delta):
	$Camera2D.position = $Cluster.position
