extends Sprite

export(Texture) onready var sprite_texture setget set_texture
export(PackedScene) var target_scene


func _ready():
    pass
    
func set_texture(tex):
    self.texture = tex

func _on_area_entered(area):
    if area.is_in_group("player"):
        # ถ้าเก็บกุญแจหมดแล้ว
        if get_tree().current_scene.key_count == 0:
            self.get_tree().change_scene_to(target_scene)
