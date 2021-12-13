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
	get_tree().current_scene.get_node("Map/Player").ability_flag = ability_flag
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
