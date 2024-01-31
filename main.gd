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
	"reef.tscn": preload("res://scenes/reef.tscn"),
	"discovery.tscn": preload("res://scenes/discovery.tscn"),
	"trench.tscn": preload("res://scenes/trench.tscn"),
	"encounter.tscn": preload("res://scenes/encounter.tscn"),
	"return.tscn": preload("res://scenes/return.tscn")
}

func _ready():
	$prompt.visible = false
	$title_screen/background/start.pressed.connect(_start_game)
	
func _start_game():
	$title_screen.visible = false
	play_scene("descent.tscn")
	
func play_scene(scene_name):
	$prompt.visible = false
	$dialogue.visible = true
	if is_instance_valid(current_scene): current_scene.queue_free()# remove previous scene
	if scene_name == "end": $title_screen.visible = true; $dialogue.visible = false; return
	print("Current depth: ", depth)
	
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
