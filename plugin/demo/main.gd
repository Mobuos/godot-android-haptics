extends Node2D

var haptics

func _ready():
	pass
	

func _on_Button_pressed():
	haptics = AndroidHaptics.new()
	haptics.vibrateEffect(AndroidHaptics.Effect.CLICK)
	pass

func _on_button_2_pressed() -> void:
	haptics = AndroidHaptics.new()
	haptics.vibrateEffect(AndroidHaptics.Effect.DOUBLE_CLICK)
	pass
