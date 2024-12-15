extends Button

signal request_effect_vibration(effectType: AndroidHaptics.Primitive)

@export var effectType: AndroidHaptics.Effect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(_on_pressed)

func _on_pressed():
	request_effect_vibration.emit(effectType)
