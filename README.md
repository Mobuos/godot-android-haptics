# Godot Android Haptics Plugin
A plugin to add support to [clear](https://developer.android.com/develop/ui/views/haptics/haptics-principles#clear_haptics) and [rich](https://developer.android.com/develop/ui/views/haptics/haptics-principles#rich_haptics) haptics, as opposed to the default [buzzy](https://developer.android.com/develop/ui/views/haptics/haptics-principles#buzzy_haptics) haptics that [Godot offers](https://docs.godotengine.org/en/stable/classes/class_input.html#class-input-method-vibrate-handheld) by default.

## Usage
Check `haptics_wrapper.gd`, but in short:
```gdscript
haptics = AndroidHaptics.new()
haptics.vibratePrimitive(AndroidHaptics.Primitive.THUD, 0.5) # primitive, intensity
haptics.vibratePrimitive(AndroidHaptics.Effect.TICK) # effect
```

## Recommendations
There's likely no better resource than the Android documentation itself: https://developer.android.com/develop/ui/views/haptics
Most functions provided work very similarly to the ones used in native Android code, but not only that, the high level concepts can be easily re-used here:

> At a high level, the design guidelines can be summarized as:
> 
> - Favor rich and clear haptics over buzzy haptics.
> - Be consistent, both with the system and the app design.
> - Be mindful of frequency of use, and importance.
