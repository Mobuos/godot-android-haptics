extends Node

var haptics: AndroidHaptics

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is Button:
			child.request_effect_vibration.connect(_on_button_pressed)
	
	haptics = AndroidHaptics.new()

func _on_button_pressed(effectType: AndroidHaptics.Effect) -> void:
	haptics.vibrateEffect(effectType)

func wait(wait_duration: float) -> void:  
	await get_tree().create_timer(wait_duration, false, false, true).timeout
