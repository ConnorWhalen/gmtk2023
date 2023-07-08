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
onready var howto_scene = preload("res://scenes/HowTo.tscn")
#onready var upgrade_scene = preload("res://scenes/Upgrade.tscn")
#onready var options_scene = preload("res://scenes/options.tscn")

onready var stage1_scene = preload("res://scenes/Stage1.tscn")
onready var stage2_scene = preload("res://scenes/Stage2.tscn")
onready var stage3_scene = preload("res://scenes/Stage3.tscn")
onready var stage4_scene = preload("res://scenes/Stage4.tscn")
onready var stage5_scene = preload("res://scenes/Stage5.tscn")

var current_mode_id
var current_mode

var stages = []

func _ready():
	stages = [stage1_scene, stage2_scene, stage3_scene, stage4_scene, stage5_scene]
	set_mode(Mode.MENU)


func set_mode(mode_id, stage_number=0):
	remove_child(current_mode)
	current_mode_id = mode_id
	match current_mode_id:
		Mode.MENU:
			current_mode = menu_scene.instance()
		Mode.STAGE:
			current_mode = stages[stage_number].instance()
		Mode.HOWTO:
			current_mode = howto_scene.instance()
#		Mode.UPGRADE:
#			current_mode = upgrade_scene.instance()
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

func set_mode_stage(number):
	set_mode(Mode.STAGE, number)

func set_mode_upgrade():
	set_mode(Mode.UPGRADE)

func set_mode_howto():
	set_mode(Mode.HOWTO)

func set_mode_options():
	set_mode(Mode.OPTIONS)
