## Interface used to access the functionality provided by this plugin.
class_name AndroidHaptics

var _plugin_name = "GodotAndroidHaptics"
var _plugin_singleton

func _init():
	if Engine.has_singleton(_plugin_name):
		_plugin_singleton = Engine.get_singleton(_plugin_name)
	else:
		push_warning("%s: Failed to initialize! Unable to access the java logic" % _plugin_name)

enum Effect { CLICK, DOUBLE_CLICK, TICK, HEAVY_CLICK }
enum Primitive { SPIN, THUD, TICK, CLICK, LOW_TICK, QUICK_FALL, QUICK_RISE, SLOW_RISE }

## Vibrates with a clear haptic effect
## See https://developer.android.com/develop/ui/views/haptics/haptics-principles#clear_haptics
func vibrateEffect(effect: Effect):
	if !OS.has_feature("android"):
		print("Vibration failed: Not running on Android!")
		return
	if _plugin_singleton:
		var effect_string = _get_effect_string(effect)
		if effect_string:
			_plugin_singleton.call("vibrateEffect", effect_string)
		else:
			printerr("Invalid effect type")
	else:
		printerr("Plugin not initialized")

## Vibrates with a primitive haptic, used for building rich haptics
## See https://developer.android.com/develop/ui/views/haptics/haptics-principles#rich_haptics
func vibratePrimitive(primitive: Primitive, intensity: float):
	if !OS.has_feature("android"):
		print("Vibration failed: Not running on Android!")
		return
	if _plugin_singleton:
		var primitive_string = _get_primitive_string(primitive)
		if primitive_string:
			intensity = _clamp_intensity(intensity)
			_plugin_singleton.call("vibratePrimitive", primitive_string, intensity)
		else:
			printerr("Invalid primitive type")
	else:
		printerr("Plugin not initialized")

## A composition of primitives, used for building custom haptics
## See https://developer.android.com/develop/ui/views/haptics/custom-haptic-effects
class Composition:
	var _composition: Array[String] = []
	var _plugin_name = "GodotAndroidHaptics"
	var _plugin_singleton

	func _init():
		if Engine.has_singleton(_plugin_name):
			_plugin_singleton = Engine.get_singleton(_plugin_name)
		else:
			push_warning("%s: Failed to initialize! Unable to access the java logic" % _plugin_name)

	## Add a primitive to the composition
	# Delay is given in milliseconds
	func addPrimitive(primitive: Primitive, intensity: float, delay: int = 0) -> Composition:
		intensity = AndroidHaptics._clamp_intensity(intensity)
		self._composition.append("%s-%s-%s" % [AndroidHaptics._get_primitive_string(primitive), intensity, delay])
		return self

	## Vibrates with the defined composition
	func vibrate(composition: Array[String] = self._composition):
		if !OS.has_feature("android"):
			print("Vibration failed: Not running on Android!")
			return

		if _plugin_singleton:
			_plugin_singleton.call("vibrateComposition", composition)
		else:
			printerr("Plugin not initialized")

## Check if device has support for clear haptics (effects)
func hasEffectSupport() -> bool:
	if !OS.has_feature("android"):
		print("Not running on Android!")
		return false
	if _plugin_singleton:
		return _plugin_singleton.hasEffectHapticsSupport()
	else:
		printerr("Plugin not initialized")
		return false

## Checks if device has support for primitive haptics
func hasPrimitivesSupport() -> bool:
	if !OS.has_feature("android"):
		print("Not running on Android!")
		return false
	if _plugin_singleton:
		return _plugin_singleton.hasRichHapticsSupport()
	else:
		printerr("Plugin not initialized")
		return false

static func _get_effect_string(effect: Effect) -> String:
	match effect:
		Effect.CLICK: return "click"
		Effect.DOUBLE_CLICK: return "double_click"
		Effect.TICK: return "tick"
		Effect.HEAVY_CLICK: return "heavy_click"
	printerr("Could not find effect %s! Returning empty string." % effect)
	return ""

static func _get_primitive_string(primitive: Primitive) -> String:
	match primitive:
		Primitive.SPIN: return "spin"
		Primitive.THUD: return "thud"
		Primitive.TICK: return "tick"
		Primitive.CLICK: return "click"
		Primitive.LOW_TICK: return "low_tick"
		Primitive.QUICK_FALL: return "quick_fall"
		Primitive.QUICK_RISE: return "quick_rise"
		Primitive.SLOW_RISE: return "slow_rise"
	printerr("Could not find primitive %s! Returning empty string." % primitive)
	return ""

static func _clamp_intensity(intensity: float) -> float:
	if intensity < 0.0 or intensity > 1.0:
		printerr("Intensity value %f out of range (0.0 - 1.0). Clamping to valid range." % intensity)
	intensity = clamp(intensity, 0.0, 1.0)
	return intensity
