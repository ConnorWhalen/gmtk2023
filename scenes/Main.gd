extends Node2D

enum Mode {
	MENU,
	STAGE,
	UPGRADE,
	HOWTO,
	OPTIONS
}

signal mode_menu
signal mode_stage
signal mode_upgrade
signal mode_howto
signal mode_options

onready var menu_scene = preload("res://scenes/Menu.tscn")
onready var stage_scene = preload("res://scenes/Stage.tscn")
#onready var upgrade_scene = preload("res://scenes/Upgrade.tscn")
#onready var howto_scene = preload("res://scenes/HowTo.tscn")
#onready var options_scene = preload("res://scenes/options.tscn")

var current_mode_id
var current_mode


func _ready():
	set_mode(Mode.MENU)


func set_mode(mode_id):
	remove_child(current_mode)
	current_mode_id = mode_id
	match current_mode_id:
		Mode.MENU:
			current_mode = menu_scene.instance()
		Mode.STAGE:
			current_mode = stage_scene.instance()
#		Mode.UPGRADE:
#			current_mode = upgrade_scene.instance()
#		Mode.HOWTO:
#			current_mode = howto_scene.instance()
#		Mode.OPTIONS:
#			current_mode = options_scene.instance()
		
	add_child(current_mode)
	current_mode.connect("mode_menu", self, "set_mode_menu")
	current_mode.connect("mode_stage", self, "set_mode_stage")
	current_mode.connect("mode_upgrade", self, "set_mode_upgrade")
	current_mode.connect("mode_howto", self, "set_mode_howto")
	current_mode.connect("mode_options", self, "set_mode_options")


func set_mode_menu():
	set_mode(Mode.MENU)

func set_mode_stage():
	set_mode(Mode.STAGE)

func set_mode_upgrade():
	set_mode(Mode.UPGRADE)

func set_mode_howto():
	set_mode(Mode.HOWTO)

func set_mode_options():
	set_mode(Mode.OPTIONS)
