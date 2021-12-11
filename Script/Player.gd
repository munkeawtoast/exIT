extends Node2D

enum ABILITY_ENUM {rook, knight, bishop, elephant}

onready var movable_array_node = $"MovableArray"
onready var player_sprite_node = $"Sprite"
onready var player_hitbox = $"PlayerHitBox"


export(ABILITY_ENUM, FLAGS) var ability_flag: int = 1 setget reset_flag
export(Texture) onready var sprite_texture

const SIZE_MULTIPLIER = 32
const MOVE_TIMES_LIMIT = 16
const ANIMATION_TIME = 0.125
onready var ANIMATING = [player_sprite_node, player_hitbox]

var movable_positions = load("res://DefaultLevel/MovablePositions.tscn")

var ability: Dictionary = {}
var available_moves: Array = []

var moves_array: Array = []

var is_moving = false

func _ready():
	set_sprite(sprite_texture)
	flag_to_ability()
	var mmfile = File.new()
	mmfile.open("res://DefaultLevel/player_moves.json", File.READ)
	var unfiltered_dict = parse_json(mmfile.get_as_text())

	for i in unfiltered_dict.keys():
		if ability[i] == true:
			moves_array.append_array(unfiltered_dict[i])

	_get_available_move_pos()

func reset_flag(flag):
	ability_flag = flag
	ability = {}
	flag_to_ability()

func set_sprite(tex):
	player_sprite_node.set_texture(tex)

func flag_to_ability():
	"""
		ex. :
		111 -> {"rook": true, "knight": true, "elephant": true}
		101 -> {"rook": true, "knight": false, "elephant": true}
	"""
	for i in len(ABILITY_ENUM):
		var num = ability_flag % int(pow(2, i+1))
		num >>= i
		ability[ABILITY_ENUM.keys()[i]] = bool(num)

func _get_available_move_pos():
	for i in moves_array:
		var movpos = movable_positions.instance()
		movable_array_node.add_child(movpos)
		
		var step = Vector2()
		var times = 1
		if "step" in i:
			step = Vector2(i["step"][0], i["step"][1])
		if "step_times" in i:
			times = i["step_times"]
			if times == -1:
				times = INF
			times = min(MOVE_TIMES_LIMIT, times)
		step *= SIZE_MULTIPLIER

		movpos.step = step
		movpos.times = times

		# for j in range(min(MOVE_TIMES_LIMIT, times)): # does not work
		# 	movpos.position += step
		# 	print(movpos.get_overlapping_bodies())
		# 	if movpos.get_overlapping_areas(): # if has overlapping
		# 		if j == 0: # can't move to the first one
		# 			movpos.queue_free()
		# 		break

		movpos.get_node("Button").connect("pressed", self, "_movable_tile_pressed", [movpos])

func _movable_tile_pressed(pos):
	if is_moving: # ไม่เดินถ้าเดินอยู่ 
		return
	move(pos.position)

func move(pos: Vector2):
	# ล็อกไม่ให้กดปุ่มอื่น
	is_moving = true
	var tween = Tween.new()
	add_child(tween)
	
	# สั่งให้ค่าไหลเป็นเวลา ANIMATION_TIME
	# เป็นทาง TRANS_CIRC
	# ไอเดียคือ
	# ให้ค่าเปลี่ยนตำแหน่ง sprite (เพื่อไม่ให้ไปชนส่วนอื่น)
	# แล้วค่อยไปเปลี่ยนตำแหน่งของ player ทีหลัง
	for i in ANIMATING:
		tween.interpolate_property(
			i,
			'position', Vector2(),
			pos-i.position, ANIMATION_TIME, 
			Tween.TRANS_CIRC, Tween.EASE_IN_OUT
		)
	# เรียก function moveself หลังผ่านไป ANIMATION_TIME วินาทีโดยแนบค่าหลังฟังชั่
	# เพิ่มเติมดู docs นาจา
	tween.interpolate_callback(self, ANIMATION_TIME, 'moveself', position+pos)

	# รันทุกตัวที่กำหนดไป
	tween.start()

	# ปัญหาตอนนี้คือยังไม่ได้ลบ tweenตัวเก่า (เอาจริงไม่ใช้ปัญหา แต่ถ้าลบได้ก็น่าจะดี)
	# TODO: ตัวลบ tweenเก่า
	

func moveself(to):
	# แก้ตำแหน่งสไปร์ทกลับที่ origin แล้วเปลี่ยนตำแหน่งเราตาม
	is_moving = false
	for i in ANIMATING:
		i.position = Vector2()
	position = to
	for i in movable_array_node.get_children():
		i.queue_free()
	_get_available_move_pos()

