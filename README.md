# Godot Android Haptics Plugin
<p align="center">
  <img src="https://github.com/user-attachments/assets/c8882560-6939-4f73-a0bd-38e5de9000bf" />
</p>

A plugin to add support to [clear](https://developer.android.com/develop/ui/views/haptics/haptics-principles#clear_haptics) and [rich](https://developer.android.com/develop/ui/views/haptics/haptics-principles#rich_haptics) haptics, as opposed to the default [buzzy](https://developer.android.com/develop/ui/views/haptics/haptics-principles#buzzy_haptics) haptics that [Godot offers](https://docs.godotengine.org/en/stable/classes/class_input.html#class-input-method-vibrate-handheld).

## Installation
Grab the zipped `addons.zip` from releases, and unzip its contents into the root folder of your project. After that you should be able to enable the plugin in Project -> Project Settings -> Plugins. Also make sure the "Vibrate" permission is allowed in Project -> Export / Android window.

You can also now install directly through Godot, as this plugin is available on the Asset Store! Just note it might not be the most up-to-date version :)

## Usage
Check `haptics_wrapper.gd`, but in short:
```gdscript

haptics = AndroidHaptics.new()
haptics.vibratePrimitive(AndroidHaptics.Primitive.THUD, 0.5) # primitive, intensity
haptics.vibrateEffect(AndroidHaptics.Effect.TICK) # effect
haptics.Composition.new()\
    .addPrimitive(AndroidHaptics.Primitive.SLOW_RISE, 1.0)\
    .addPrimitive(AndroidHaptics.Primitive.THUD, 1.0, 500)\ 
    .vibrate() # primitive, intensity, delay(ms)

var wave = AndroidHaptics.Waveform.new(
  [ 100, 100, 80,  80, 30,  30, 150, 40,  40, 200],
  [ 60,  0,   120, 0,  255, 0,  0,   255, 0,  0],
)
wave.play()

@export var curve: Curve
var wave2 = AndroidHaptics.Waveform.from_curve(curve, 2000, 20, 100)

haptics.stopVibrations()
```

## Recommendations
There's likely no better resource than the Android documentation itself: https://developer.android.com/develop/ui/views/haptics.
Most functions provided here will work very similarly to the ones used in native Android code. Not only that, the high level concepts can be easily re-used as well:

> At a high level, the design guidelines can be summarized as:
> 
> - Favor rich and clear haptics over buzzy haptics.
> - Be consistent, both with the system and the app design.
> - Be mindful of frequency of use, and importance.

## Building 
Check https://github.com/m4gr3d/Godot-Android-Plugin-Template and https://docs.godotengine.org/en/stable/tutorials/platform/android/android_plugin.html.

The final output should be in `demo/addons/GodotAndroidHaptics`
