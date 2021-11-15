extends Sprite

export(Texture) onready var sprite_texture setget set_texture
export(PackedScene) var target_scene

func _ready():
	pass
	
func set_texture(tex):
	self.texture = tex

func _on_Area2D_area_entered(area):
	if area.get_parent() == $"../Player":
		self.get_tree().change_scene_to(target_scene)
