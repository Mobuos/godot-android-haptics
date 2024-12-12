package dev.mobuos.godot.android.richhaptics

import android.annotation.TargetApi
import android.os.Build
import android.os.VibrationEffect
import android.util.Log
import android.os.Vibrator
import org.godotengine.godot.Godot
import org.godotengine.godot.plugin.GodotPlugin
import org.godotengine.godot.plugin.UsedByGodot

@TargetApi(Build.VERSION_CODES.Q)
class GodotAndroidPlugin(godot: Godot): GodotPlugin(godot) {

    override fun getPluginName() = BuildConfig.GODOT_PLUGIN_NAME

    private val effectMap = mapOf(
        "click" to VibrationEffect.EFFECT_CLICK,
        "double_click" to VibrationEffect.EFFECT_DOUBLE_CLICK,
        "tick" to VibrationEffect.EFFECT_TICK,
        "heavy_click" to VibrationEffect.EFFECT_HEAVY_CLICK,
    )

    @TargetApi(Build.VERSION_CODES.S)
    private val primitiveMap = mapOf(
        "spin" to VibrationEffect.Composition.PRIMITIVE_SPIN,
        "thud" to VibrationEffect.Composition.PRIMITIVE_THUD,
        "tick" to VibrationEffect.Composition.PRIMITIVE_TICK,
        "click" to VibrationEffect.Composition.PRIMITIVE_CLICK,
        "low_tick" to VibrationEffect.Composition.PRIMITIVE_LOW_TICK,
        "quick_fall" to VibrationEffect.Composition.PRIMITIVE_QUICK_FALL,
        "quick_rise" to VibrationEffect.Composition.PRIMITIVE_QUICK_RISE,
        "slow_rise" to VibrationEffect.Composition.PRIMITIVE_SLOW_RISE,
    )

    /**
     * Clear haptics (See https://developer.android.com/develop/ui/views/haptics/haptics-principles#clear_haptics)
     *
     * Accepts any value from effectMap, vibrates with the corresponding effect.
     */
    @UsedByGodot
    fun vibrateEffect(effectType: String) {
        runOnUiThread {
            effectMap[effectType]?.let { vibrationEffect ->
                val vibrator = activity?.getSystemService(Vibrator::class.java)
                vibrator?.vibrate(VibrationEffect.createPredefined(vibrationEffect))
            } ?: run {
                Log.d(pluginName, "No effect type $effectType was found, no vibration will be used")
            }
        }
    }

    /**
     * Check if device supports all clear haptics effects
     *
     * Clear haptics are used in vibrateEffect()
     */
    @TargetApi(Build.VERSION_CODES.R)
    @UsedByGodot
    fun hasEffectHapticsSupport(): Boolean {
        activity?.getSystemService(Vibrator::class.java)?.let { vibrator ->
            return vibrator.areAllEffectsSupported(
                VibrationEffect.EFFECT_TICK,
                VibrationEffect.EFFECT_HEAVY_CLICK,
                VibrationEffect.EFFECT_DOUBLE_CLICK,
                VibrationEffect.EFFECT_CLICK
            ) == Vibrator.VIBRATION_EFFECT_SUPPORT_YES
        } ?: run {
            return false
        }
    }

    /**
     * Rich haptics (See https://developer.android.com/develop/ui/views/haptics/haptics-principles#rich_haptics)
     *
     * Accepts any value from effectMap, vibrates with the corresponding effect.
     */
    @TargetApi(Build.VERSION_CODES.R)
    @UsedByGodot
    fun vibratePrimitive(primitiveType: String, strength: Float) {
        runOnUiThread {
            primitiveMap[primitiveType]?.let { vibrationPrimitive ->
                val vibrator = activity?.getSystemService(Vibrator::class.java)
                vibrator?.vibrate(VibrationEffect.startComposition().addPrimitive(vibrationPrimitive, strength).compose())
            } ?: run {
                Log.d(pluginName, "No primitive type $primitiveType was found, no vibration will be used")
            }
        }
    }

    /**
     * Check if device supports all rich haptics effects
     *
     * Rich haptics are used in vibratePrimitive()
     */
    @TargetApi(Build.VERSION_CODES.S)
    @UsedByGodot
    fun hasPrimitiveHapticsSupport(): Boolean {
        activity?.getSystemService(Vibrator::class.java)?.let { vibrator ->
            return vibrator.areAllPrimitivesSupported(
                VibrationEffect.Composition.PRIMITIVE_SPIN,
                VibrationEffect.Composition.PRIMITIVE_THUD,
                VibrationEffect.Composition.PRIMITIVE_TICK,
                VibrationEffect.Composition.PRIMITIVE_CLICK,
                VibrationEffect.Composition.PRIMITIVE_LOW_TICK,
                VibrationEffect.Composition.PRIMITIVE_QUICK_FALL,
                VibrationEffect.Composition.PRIMITIVE_QUICK_RISE,
                VibrationEffect.Composition.PRIMITIVE_SLOW_RISE,
            )
        } ?: run {
            return false
        }
    }
}