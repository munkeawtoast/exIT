extends CanvasLayer

func set_visibility(val):
	for i in get_children():
		i.visible = val
		

func _ready():
	set_visibility(false)

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
#		get_tree().paused = not get_tree().paused
#		print(get_tree().paused)
#		set_visibility(get_tree().paused)
		get_tree().reload_current_scene()
