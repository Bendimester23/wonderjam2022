extends Camera

var current_floor = 0
var target_position = Vector3(0, 0, 0)

onready var tween = $Tween

signal floor_change;

func _ready():
	target_position = translation

func _process(delta):
	if tween.is_active() or !GlobalValues.allow_movement:
		return
	if Input.is_action_just_pressed("down") and current_floor > -99:
		current_floor -= 1
		GlobalRoomManager.current_room = current_floor
		target_position += Vector3(0, -10, 0)
		_tween_pos()
		emit_signal("floor_change", current_floor)
	elif Input.is_action_just_pressed("up") and current_floor < 99:
		current_floor += 1
		GlobalRoomManager.current_room = current_floor
		target_position += Vector3(0, 10, 0)
		_tween_pos()
		emit_signal("floor_change", current_floor)

func _tween_pos():
	tween.interpolate_property(self, "translation", translation, target_position, .6, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()
