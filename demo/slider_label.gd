extends RichTextLabel

@export var slider: Slider
var original_text: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_text = self.text
	if slider:
		slider.value_changed.connect(_slider_value_changed)
		_slider_value_changed(slider.value)
	else:
		printerr("No slider was attached to \"%s\"" % self.name)
	pass # Replace with function body.

func _slider_value_changed(new_value: float) -> void:
	self.text = original_text + " " + str(new_value)
