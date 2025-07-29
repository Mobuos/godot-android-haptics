extends Button

var haptics: AndroidHaptics
var wave: AndroidHaptics.Waveform

var playing := false

@export var toggle_play := false
@export var curve: Curve

func _ready() -> void:
	haptics = AndroidHaptics.new()
	
	# Manually create a wave
	#var repeat = 2 if toggle_play else -1
	#wave = AndroidHaptics.Waveform.new(
		#[ 100, 100, 80,  80, 30,  30, 150, 40,  40, 200],
		#[ 60,  0,   120, 0,  255, 0,  0,   255, 0,  0],
		#repeat
	#)
	
	# Or create one from a curve
	var repeat = 1000 if toggle_play else -1
	wave = AndroidHaptics.Waveform.from_curve(curve, 2000, 20, repeat)
	print(wave.amplitudes)
	print(wave.timings)
	print(wave.repeat)

func _on_pressed() -> void:
	print(wave.amplitudes)
	print(wave.timings)
	print(wave.repeat)
	if toggle_play and playing:
		print('stopping')
		haptics.stopVibrations()
		playing = false
	else:
		print('starting')
		wave.play()
		playing = true
