extends Sprite2D

func _ready():
	pass 

func _process(delta):
	if self.position.y < 320: return
	self.position.y += -1
	pass
