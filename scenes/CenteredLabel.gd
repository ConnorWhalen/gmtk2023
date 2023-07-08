extends Label

var SCREEN_HEIGHT = ProjectSettings.get_setting("display/window/size/height")
var SCREEN_WIDTH = ProjectSettings.get_setting("display/window/size/width")




func _ready():
	pass



func _process(delta):
	margin_left = -(rect_size.x*rect_scale.x)/2
	margin_top = -(rect_size.y*rect_scale.y)/2
