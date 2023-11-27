extends Node2D

var door_1 = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_down") and door_1 == 1 :
		get_tree().quit()
	pass


func _on_hermitan_house_area_entered(area):
	door_1 = 1
