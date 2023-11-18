extends Node2D

var grabbed = false
var currentSlotObject = null
var startPosition = position

func _ready():
	startPosition = position

func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("grab"):
		begin_grab()
		
	if Input.is_action_just_released("grab"):
		ungrab()
		
func _process(delta):
	if grabbed:
		position = lerp(position, get_global_mouse_position(), 25 * delta)
	else:
		adjust_position_to_slot(delta)
		
func begin_grab():
	grabbed = true
	startPosition = position
	
func ungrab():
	grabbed = false
#
#    if currentSlotObject:
#        position = currentSlotObject.position;
func adjust_position_to_slot(delta):
	var lerpAmount = 25 * delta
	if currentSlotObject:
		position = lerp(position, currentSlotObject.position, lerpAmount)
	else:
		position = lerp(position, startPosition, lerpAmount)

func _on_area_2d_area_entered(area: Area2D):
	currentSlotObject = area.get_parent().get_parent()

func _on_area_2d_area_exited(area):
	var parent = area.get_parent().get_parent()
	if currentSlotObject == parent:
		currentSlotObject = null
