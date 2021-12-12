extends TextureButton

export(String, FILE, "*.tscn") var target_scene

func _ready():
    connect("pressed", self, "_button_pressed")

func _button_pressed():
    get_tree().change_scene(target_scene)
