extends HSlider

var haptics: AndroidHaptics

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.value_changed.connect(_value_changed)
	haptics = AndroidHaptics.new()
	pass # Replace with function body.


func _value_changed(_new_value: float) -> void:
	# Slider haptic feedback
	haptics.vibratePrimitive(AndroidHaptics.Primitive.CLICK, 0.5)
