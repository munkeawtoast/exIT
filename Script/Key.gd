extends Sprite

func _ready():
    # add 1 key
    get_tree().current_scene.key_count += 1

# เรียกเมื่อ area ลูกมี area เข้ามา
func _area_entered(area):
    if area.is_in_group("player"):
        collect_key()

# อัพเดทค่ากุญแจใน level และลบกุญแจ
func collect_key():
    get_tree().current_scene.key_count -= 1
    print(get_tree().current_scene.key_count)
    queue_free()
