extends Node2D

onready var pause_menu_node = load("res://DefaultLevel/PauseMenu.tscn")
onready var player = $"Map/Player"

var key_count = 0

var player_pos
var map_size: Vector2
var menu
var pause_menu


func _ready():
	pause_menu = add_pause_menu()

func add_pause_menu() -> CanvasLayer:
	var nod = pause_menu_node.instance()
	add_child(nod)
	return nod
