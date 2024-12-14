extends Node2D

var haptics

func _ready():
	pass
	

func _on_Button_pressed():
	haptics = AndroidHaptics.new()
	haptics.vibratePrimitive(AndroidHaptics.Primitive.SLOW_RISE, 1)
	pass

func _on_button_2_pressed() -> void:
	haptics = AndroidHaptics.new()
	haptics.vibratePrimitive(AndroidHaptics.Primitive.SPIN, 1)
	pass
