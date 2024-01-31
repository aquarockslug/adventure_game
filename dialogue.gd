extends Control

var current_line
var current_scene

func play(scene):
	current_scene = scene
	current_line = 0
	if len(scene.dialogue) > 0:
		$screen/dialogue_box.text = scene.dialogue[0]
		$screen/dialogue_box.visible = true

func _input(event):
	if not current_scene or not self.visible: return
	if not (event is InputEventMouseButton): return
	if event.button_index != MOUSE_BUTTON_LEFT or not event.pressed: return
	current_line += 1
	if current_line < len(current_scene.dialogue):
		$screen/dialogue_box.text = current_scene.dialogue[current_line]
	else:
		$screen/dialogue_box.visible = false
		self.get_parent().open_prompt(current_scene)
