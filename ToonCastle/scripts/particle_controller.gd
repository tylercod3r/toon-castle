extends Node3D
class_name ParticleController

@onready var particles: GPUParticles3D = $Particles
@onready var success_audio: AudioStreamPlayer = $SuccessAudio

func play_effect() -> void:
	particles.set_emitting(true)
	success_audio.play()
