extends Button

signal request_primitive_vibration(primitiveType: AndroidHaptics.Primitive)

@export var primitiveType: AndroidHaptics.Primitive

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(_on_pressed)

func _on_pressed() -> void:
	request_primitive_vibration.emit(primitiveType)
