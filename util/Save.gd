extends Node

var SAVE_FILE_NAME = "user://save_file.save"

var SAVE_OVERRIDE = false	

enum STAT_INDEX {
	SCORE = 0,
	STAT_INDEX_max,
}

var save_data
var defaults = {
	"score": 100,
	"stages_complete": 0
}
var save_override = {
	"score": 100,
	"stages_complete": 0
}

func _ready():
	save_data = pull_stats()

func pull_stats():
	var save_file = File.new()

	var save_stats_tmp: Dictionary = {}

	save_file.open(SAVE_FILE_NAME, File.READ)
	var save_object = save_file.get_var()

	# fetch save, provide default if not found
	if save_object:
		save_stats_tmp = save_object
	else:
		save_stats_tmp = {}

	for key in defaults:
		if not(key in save_stats_tmp.keys()):
			save_stats_tmp[key] = defaults[key]

	save_file.close()
	
	if SAVE_OVERRIDE:
		for key in save_override:
			save_stats_tmp[key] = save_override[key]
		save_data = save_stats_tmp
		push_stats()
		SAVE_OVERRIDE = false

	return save_stats_tmp

func push_stats():

	var save_file = File.new()
	save_file.open(SAVE_FILE_NAME, File.WRITE)
	save_file.store_var(save_data)
	save_file.close()

func reset_stats():
	var save_file = File.new()
	save_file.open(SAVE_FILE_NAME, File.WRITE)
	save_file.close()
	save_data = pull_stats()
