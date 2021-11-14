extends Area2D

onready var button = $Button
var step: Vector2 = Vector2()
var times: int

var move_done: bool = false setget do_move_done
var move_times: int = 0

func do_move_done(val):
	move_done = val
	make_button_visible()
	
func make_button_visible():
	pass
	# button.flat = false

func _physics_process(_delta):
	if move_times < times:
		if not move_done and step != Vector2() :
			move()
	else:
		self.move_done = true

func _on_body_entered(_body):
	position -= step
	move_done = true
	make_button_visible()
	if move_times == 1:
		queue_free()
		
func move():
	position += step
	move_times += 1