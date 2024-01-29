extends Node2D

@export var story_resource: String = "res://story.tres"
var scene_text = load(story_resource).data

var current_scene
var affection = 50

var scene_tscn = {
	"phone.tscn": preload("res://phone.tscn"),
	"drive.tscn": preload("res://drive.tscn"),
	"distraction.tscn": preload("res://distraction.tscn"),
}

func _ready():
	$prompt.visible = false
	$title_screen/background/start.pressed.connect(_start_game)
	
func _start_game():
	$title_screen.visible = false
	$prompt.visible = true
	play_scene("phone.tscn")
	
func play_scene(scene_name):
	$prompt.visible = false
	print("Current affection: ", affection)
	
	# remove previous scene if there is one
	if current_scene: current_scene.queue_free()
	
	# instantiate scene file
	if scene_name in scene_tscn:
		current_scene = scene_tscn[scene_name].instantiate()
		self.add_child(current_scene)
	
	# play dialogue
	print(scene_text)
	if scene_text[scene_name]:
		$dialogue.play(scene_text[scene_name])
	
func open_prompt(scene): $prompt.visible = true; $prompt.ask_question(scene)
func change_affection(change_amount): set_affection(affection + change_amount)
func set_affection(amount): affection = amount

















