extends HSlider

var vibrate: bool = false
var vibration_accumulator: float = 0.0
var vibration_interval: float = 0.3

var haptics: AndroidHaptics
var is_dragging: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	haptics = AndroidHaptics.new()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if vibrate:
		var intensity: float = lerp(0.5, 1.0, pow(value, 1.5))
		vibration_interval = lerp(0.1, 0.03, pow(value, 1.2))

		vibration_accumulator += delta
		if vibration_accumulator >= vibration_interval:
				haptics.vibratePrimitive(haptics.Primitive.LOW_TICK, intensity)
				vibration_accumulator = 0.0
	if not is_dragging:
		value = lerp(value, -1.0, delta * 2)
		
		if abs(value) < 0.01:
			value = 0.0
			vibrate = false


func _on_drag_started() -> void:
	vibrate = true
	is_dragging = true


func _on_drag_ended(_value_changed: bool) -> void:
	is_dragging = false
	if value <= 0.5:
		vibrate = false


func _on_value_changed(new_value: float) -> void:
	if new_value == 0:
		haptics.vibratePrimitive(AndroidHaptics.Primitive.THUD, 0.5)
