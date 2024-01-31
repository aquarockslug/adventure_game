extends Node2D

@export var story_resource: String = "res://story.json"
var scene_text = load(story_resource).data

var current_scene
var depth = 0 

# todo: preload scenes dir with loop
var scene_tscn = {
	"descent.tscn": preload("res://scenes/descent.tscn"),
	"cavern.tscn": preload("res://scenes/cavern.tscn"),
	"shipwreck.tscn": preload("res://scenes/shipwreck.tscn"),
}

func _ready():
	$prompt.visible = false
	$title_screen/background/start.pressed.connect(_start_game)
	
func _start_game():
	$title_screen.visible = false
	$prompt.visible = true
	play_scene("descent.tscn")
	
func play_scene(scene_name):
	$prompt.visible = false
	print("Current depth: ", depth)
	
	# remove previous scene if there is one
	if current_scene: current_scene.queue_free()
	
	# instantiate scene file
	if scene_name in scene_tscn:
		current_scene = scene_tscn[scene_name].instantiate()
		self.add_child(current_scene)
	
	# play 
	if scene_name != "": $dialogue.play(scene_text[scene_name])
	
func open_prompt(scene): $prompt.visible = true; $prompt.ask_question(scene)
func change_depth(change_amount): set_depth(depth + change_amount)
func set_depth(amount): depth = amount
func format_story(): print(JSONBeautifier.beautify_json(JSON.stringify(scene_text)))
