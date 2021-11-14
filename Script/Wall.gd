extends StaticBody2D

export(String, FILE) var spriteimg
onready var spritenode = $"Sprite"


func _ready():
	var sprite = load(spriteimg)
	if load(spriteimg) is Texture:
		change_sprite(sprite)
	else:
		print("bad sprite img")

func change_sprite(spr: Texture):
	spritenode.set_texture(spr)