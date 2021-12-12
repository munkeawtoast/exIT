extends Sprite
enum ABILITY_ENUM {rook, knight, bishop, elephant}
export(ABILITY_ENUM, FLAGS) var ability_flag: int = 1
# เรียกเมื่อ area ลูกมี area เข้ามา
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

func _area_entered(area):
	if area.is_in_group("player"):
		changeabilty()
# อัพเดทค่ากุญแจใน level และลบกุญแจ
func changeabilty():
	var player = get_tree().current_scene.get_node("Map/Player")
	player.ability_flag = ability_flag
	player.ability = {}
	player.flag_to_ability()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
