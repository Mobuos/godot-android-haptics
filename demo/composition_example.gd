extends Button

var haptics: AndroidHaptics
@export var composition_alternative: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	haptics = AndroidHaptics.new()


func _on_pressed() -> void:
	if !composition_alternative:
		## Create a composition, and call vibrate on it anytime to call the vibration
		var rise_thump := haptics.Composition.new()\
			.addPrimitive(AndroidHaptics.Primitive.SLOW_RISE, 1.0)\
			.addPrimitive(AndroidHaptics.Primitive.THUD, 1.0, 500)
		
		rise_thump.vibrate()
	else:
		## Alternatively, declare the composition array directly:
		## Check AndroidHaptics.addPrimitive for more info
		var rise_thump: Array[String] = ["slow_rise-1.0-0", "thud-1.0-500"]
		haptics.Composition.new().vibrate(rise_thump)
