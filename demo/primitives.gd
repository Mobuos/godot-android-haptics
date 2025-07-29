extends Node

@export var intensity_slider: Slider
var intensity: float

var haptics: AndroidHaptics

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if intensity_slider:
		intensity_slider.value_changed.connect(_update_intensity)
		intensity = intensity_slider.value
	else:
		printerr("Missing intensity slider at \"%s\"" % self.name)
	
	for child in get_children():
		if child is Button:
			child.request_primitive_vibration.connect(_on_button_pressed)
	
	haptics = AndroidHaptics.new()

func _on_button_pressed(primitiveType: AndroidHaptics.Primitive) -> void:
	haptics.vibratePrimitive(primitiveType, intensity)

func wait(wait_duration: float) -> void:  
	await get_tree().create_timer(wait_duration, false, false, true).timeout

func _update_intensity(new_intensity: float) -> void:
	intensity = new_intensity
