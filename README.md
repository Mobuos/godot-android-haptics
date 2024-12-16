# Godot Android Haptics Plugin
A plugin to add support to [clear](https://developer.android.com/develop/ui/views/haptics/haptics-principles#clear_haptics) and [rich](https://developer.android.com/develop/ui/views/haptics/haptics-principles#rich_haptics) haptics, as opposed to the default [buzzy](https://developer.android.com/develop/ui/views/haptics/haptics-principles#buzzy_haptics) haptics that [Godot offers](https://docs.godotengine.org/en/stable/classes/class_input.html#class-input-method-vibrate-handheld) by default.

## Usage
Check `haptics_wrapper.gd`, but in short:
```gdscript
haptics = AndroidHaptics.new()
haptics.vibratePrimitive(AndroidHaptics.Primitive.THUD, 0.5)
haptics.vibratePrimitive(AndroidHaptics.Effect.TICK)
```
