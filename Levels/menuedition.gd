extends Tween


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var menu_objects = ["../Play","../Tutorial", "../face1","../face2","../face3","../face4","../face5"]

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in menu_objects:
		get_node(i).visible = false
	interpolate_property(get_node("../RichTextLabel"), "rect_position", get_node("../RichTextLabel").rect_position + Vector2(-100, 0)\
	, get_node("../RichTextLabel").rect_position, 0.5, Tween.TRANS_LINEAR)
	interpolate_property(get_node("../RichTextLabel2"), "rect_position", get_node("../RichTextLabel2").rect_position + Vector2(100, 0)\
	, get_node("../RichTextLabel2").rect_position, 1, Tween.TRANS_LINEAR)
	start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _animation_done():
	for i in menu_objects:
		get_node(i).visible = true
